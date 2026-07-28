#!/usr/bin/env bash
# =============================================================================
# Hermes Research Automation Skill Bundle — Installer
# =============================================================================
# Installs all prerequisites EXCEPT the NVIDIA NIM API key
# (which you must add manually via Hermes Settings > Models/Providers).
#
# macOS / Linux:   curl -fsSL https://raw.githubusercontent.com/sloemo01/hermes-skills-bundle/main/install.sh | bash
# Windows (PS):    irm https://raw.githubusercontent.com/sloemo01/hermes-skills-bundle/main/install.ps1 | iex
# =============================================================================

set -euo pipefail

# =============================================================================
# CONFIGURATION
# =============================================================================
REPO_URL="https://github.com/sloemo01/hermes-skills-bundle.git"
SKILLS_DIR="${HOME}/.hermes/skills/hermes-skills-bundle"
KIMI_INSTALL_URL="https://cdn.kimi.com/webbridge/install.sh"
KIMI_INSTALL_URL_PS="https://cdn.kimi.com/webbridge/install.ps1"

# =============================================================================
# LOGGING
# =============================================================================
log_info()  { echo -e "\033[1;34m[INFO]\033[0m  $*"; }
log_ok()    { echo -e "\033[1;32m[OK]\033[0m    $*"; }
log_warn()  { echo -e "\033[1;33m[WARN]\033[0m  $*"; }
log_err()   { echo -e "\033[1;31m[ERR]\033[0m  $*"; }

# =============================================================================
# OS DETECTION
# =============================================================================
detect_os() {
    case "$(uname -s)" in
        Darwin) echo "macos" ;;
        Linux)  echo "linux" ;;
        *)      echo "unknown" ;;
    esac
}
OS="$(detect_os)"

# =============================================================================
# STEP 0: NVIDIA NIM API KEY REMINDER
# =============================================================================
cat <<'EOF'

╔═══════════════════════════════════════════════════════════════════════╗
║  Hermes Research Automation Skill Bundle — Installer                ║
╚═══════════════════════════════════════════════════════════════════════╝

⚠️  BEFORE RUNNING: You MUST add your NVIDIA NIM API key first!

   1. Go to https://build.nvidia.com/nvidia/nemotron-3-ultra-550b-a55b
   2. Click "Get API Key" → copy nvapi-...
   3. In Hermes: Settings (gear) → Models/Providers → NVIDIA → paste key
   4. Select model: nvidia/nemotron-3-ultra-550b-a55b

EOF

read -p "Press Enter after adding your NVIDIA API key to Hermes..." -r
echo ""

# =============================================================================
# STEP 1: Install Kimi WebBridge Daemon
# =============================================================================
install_kimi_webbridge() {
    log_info "Checking for Kimi WebBridge daemon..."

    # Check if already installed
    local kimi_paths=(
        "${HOME}/.kimi-webbridge/bin/kimi-webbridge"
        "/usr/local/bin/kimi-webbridge"
        "/opt/homebrew/bin/kimi-webbridge"
    )

    for path in "${kimi_paths[@]}"; do
        if [[ -x "$path" ]]; then
            log_ok "Found kimi-webbridge at $path"
            echo "$path"
            return 0
        fi
    done

    # Check PATH
    if command -v kimi-webbridge >/dev/null 2>&1; then
        log_ok "kimi-webbridge already in PATH"
        command -v kimi-webbridge
        return 0
    fi

    # Install
    log_info "Installing Kimi WebBridge daemon..."
    if curl -fsSL "$KIMI_INSTALL_URL" | bash; then
        log_ok "Kimi WebBridge installed via installer"
    else
        log_err "Kimi WebBridge installation failed"
        return 1
    fi

    # Verify
    for path in "${kimi_paths[@]}"; do
        if [[ -x "$path" ]]; then
            log_ok "Found kimi-webbridge at $path after install"
            echo "$path"
            return 0
        fi
    done

    if command -v kimi-webbridge >/dev/null 2>&1; then
        log_ok "kimi-webbridge now in PATH"
        command -v kimi-webbridge
        return 0
    fi

    log_err "Could not verify Kimi WebBridge installation"
    return 1
}

# =============================================================================
# STEP 2: Start Kimi Daemon
# =============================================================================
start_kimi_daemon() {
    local kimi_path="$1"
    log_info "Starting Kimi WebBridge daemon..."

    if [[ -z "$kimi_path" ]]; then
        log_err "No Kimi WebBridge binary found"
        return 1
    fi

    # Start daemon (idempotent)
    if ! "$kimi_path" start; then
        log_warn "Daemon start command failed (may already be running)"
    fi

    # Wait and verify
    sleep 2
    for i in {1..5}; do
        if curl -sf http://127.0.0.1:10086/status >/dev/null 2>&1; then
            local status
            status=$(curl -sf http://127.0.0.1:10086/status 2>/dev/null)
            if echo "$status" | grep -q '"running":true'; then
                log_ok "Daemon responding at http://127.0.0.1:10086"
                return 0
            fi
        fi
        sleep 1
    done

    log_warn "Daemon started but not responding yet. May need a moment."
    return 0
}

# =============================================================================
# STEP 3: Browser Extension (manual)
# =============================================================================
check_browser_extension() {
    log_info "Kimi WebBridge browser extension (manual step required):"
    cat <<'EOF'
  You MUST install the browser extension (Chromium-based browsers ONLY):

  Chrome / Edge / Brave / Arc:
    → https://chromewebstore.google.com/detail/kimi-webbridge/fldmhceldgbpfpkbgopacenieobmligc?pli=1
    → Click "Add to Chrome"

  Firefox: ❌ NOT SUPPORTED — Kimi WebBridge only works on Chromium-based browsers

  After install:
    → Click extension icon in toolbar
    → Sign in with your Kimi account (REQUIRED)
    → Should show "Connected to daemon"
EOF
}
# =============================================================================
# STEP 3: Clone Skills
# =============================================================================
clone_skills() {
    log_info "Cloning skills to ${SKILLS_DIR}..."

    if [[ -d "${SKILLS_DIR}/.git" ]]; then
        log_info "Repository exists, pulling latest..."
        (cd "${SKILLS_DIR}" && git pull --ff-only)
        log_ok "Skills updated"
    else
        if git clone "${REPO_URL}" "${SKILLS_DIR}"; then
            log_ok "Skills cloned to ${SKILLS_DIR}"
        else
            log_err "Clone failed"
            return 1
        fi
    fi
}

# =============================================================================
# STEP 4: Verify Skills
# =============================================================================
verify_skills() {
    log_info "Verifying skills..."

    local skills=(
        "kimi-webbridge"
        "deep-web-research"
        "job-search-automation"
        "linkedin-automation"
        "mcp-server-research"
        "osint-person-search"
        "interactive-prompt-analyzer"
        "research-automation-bundle"
        "memory-setup"
    )

    local missing=0
    for skill in "${skills[@]}"; do
        if [[ -f "${SKILLS_DIR}/${skill}/SKILL.md" ]]; then
            log_ok "  ${skill}"
        else
            log_err "  ${skill} (MISSING)"
            ((missing++))
        fi
    done

    if [[ $missing -eq 0 ]]; then
        log_ok "All ${#skills[@]} skills present"
        return 0
    else
        log_err "${missing} skill(s) missing"
        return 1
    fi
}

# =============================================================================
# STEP 5: Prompt Restart
# =============================================================================
prompt_restart_hermes() {
    log_warn "You MUST RESTART HERMES now for skills to load:"
    case "$OS" in
        macos)
            log_warn "  Cmd+Q to quit Hermes, then reopen"
            ;;
        linux)
            log_warn "  Close Hermes window, then reopen from app menu"
            ;;
        *)
            log_warn "  Close Hermes, then reopen from app menu"
            ;;
    esac
}

# =============================================================================
# MAIN
# =============================================================================
main() {
    echo ""
    echo "╔════════════════════════════════════════════════════════════════╗"
    echo "║  Hermes Research Automation Skill Bundle — Installer          ║"
    echo "╚════════════════════════════════════════════════════════════════╝"
    echo ""

    # Step 1: Install Kimi WebBridge
    KIMI_PATH=$(install_kimi_webbridge) || exit 1

    # Step 2: Start daemon
    start_kimi_daemon "${KIMI_PATH}" || exit 1

    # Step 3: Browser extension
    check_browser_extension

    # Step 3: Clone skills
    clone_skills || exit 1

    # Step 4: Verify
    verify_skills || exit 1

    # Step 5: Prompt restart
    prompt_restart_hermes

    echo ""
    log_ok "Installation complete! 🎉"
    echo ""
    log_info "Next steps after restarting Hermes:"
    log_info "  1. In chat: \"Set up my memory\"  (runs 5-question setup)"
    log_info "  2. Try: \"Research AI agent frameworks\""
    log_info "  3. Try: \"Find remote ML engineer jobs\""
    echo ""
}

# Run if executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    main "$@"
fi