<#
.SYNOPSIS
    Hermes Research Automation Skill Bundle — Windows Installer
.DESCRIPTION
    Installs all prerequisites EXCEPT the NVIDIA NIM API key
    (which you must add manually via Hermes Settings > Models/Providers).

    Run in PowerShell (Admin recommended):
    irm https://raw.githubusercontent.com/sloemo01/hermes-skills-bundle/main/install.ps1 | iex

    Or: git clone ... && .\install.ps1
.NOTES
    Requires: PowerShell 5.1+ (Windows 10/11), Git for Windows
#>

# =============================================================================
# CONFIGURATION
# =============================================================================
$ErrorActionPreference = "Stop"
$REPO_URL       = "https://github.com/sloemo01/hermes-skills-bundle.git"
$SKILLS_DIR     = Join-Path (Join-Path (Join-Path $env:USERPROFILE ".hermes") "skills") "hermes-skills-bundle"
$KIMI_INSTALL_URL = "https://cdn.kimi.com/webbridge/install.ps1"

# =============================================================================
# LOGGING
# =============================================================================
function Log-Info  { Write-Host "[INFO]  $($args)" -ForegroundColor Cyan }
function Log-Ok    { Write-Host "[OK]    $($args)" -ForegroundColor Green }
function Log-Warn  { Write-Host "[WARN]  $($args)" -ForegroundColor Yellow }
function Log-Err   { Write-Host "[ERR]   $($args)" -ForegroundColor Red }

function Test-Command { (Get-Command $args[0] -ErrorAction SilentlyContinue) -ne $null }


# =============================================================================
# STEP 1: Install Kimi WebBridge Daemon
# =============================================================================
function Install-KimiWebBridge {
    Log-Info "Checking for Kimi WebBridge daemon..."

    # Check common install locations
    $kimiPaths = @(
        "$env:USERPROFILE\.kimi-webbridge\bin\kimi-webbridge.exe",
        "$env:LOCALAPPDATA\kimi-webbridge\bin\kimi-webbridge.exe",
        "C:\Program Files\kimi-webbridge\bin\kimi-webbridge.exe"
    )

    foreach ($path in $kimiPaths) {
        if (Test-Path $path) {
            Log-Ok "Found kimi-webbridge at $path"
            return $path
        }
    }

    # Check PATH
    if (Test-Command "kimi-webbridge.exe") {
        Log-Ok "kimi-webbridge already in PATH"
        return "kimi-webbridge.exe"
    }

    # Install via winget or direct download
    if (Test-Command "winget") {
        Log-Info "Installing Kimi WebBridge via winget..."
        try {
            winget install --id MoonshotAI.KimiWebBridge --silent --accept-source-agreements --accept-package-agreements
            if ($LASTEXITCODE -ne 0) { throw "winget install failed (exit code $LASTEXITCODE)" }
            Log-Ok "Kimi WebBridge installed via winget"
        }
        catch {
            Log-Err "winget install failed. Try manual: $($KIMI_INSTALL_URL)"
            return $null
        }
    }
    else {
        Log-Warn "winget not found. Trying direct download..."
        try {
            # Download and run installer
            $tempFile = Join-Path ([IO.Path]::GetTempPath()) ("hermes_kimi_" + [Guid]::NewGuid().ToString('N') + ".ps1")
            Invoke-WebRequest -Uri "https://cdn.kimi.com/webbridge/install.ps1" -OutFile $tempFile
            & powershell -ExecutionPolicy Bypass -File $tempFile
            Remove-Item $tempFile -Force
            Log-Ok "Kimi WebBridge installed via CDN"
        }
        catch {
            Log-Err "Direct install failed: $_"
            Log-Warn "Manual install: https://kimi.com/features/webbridge"
            return $null
        }
    }

    # Verify installation
    foreach ($path in $kimiPaths) {
        if (Test-Path $path) {
            Log-Ok "Found kimi-webbridge at $path after install"
            return $path
        }
    }

    if (Test-Command "kimi-webbridge.exe") {
        Log-Ok "kimi-webbridge.exe now in PATH"
        return "kimi-webbridge.exe"
    }

    Log-Err "Could not verify Kimi WebBridge installation"
    return $null
}

# =============================================================================
# STEP 2: Start Kimi Daemon
# =============================================================================
function Start-KimiDaemon {
    param([string]$KimiPath)

    Log-Info "Starting Kimi WebBridge daemon..."

    if (-not $KimiPath) {
        Log-Err "No Kimi WebBridge binary found"
        return $false
    }

    try {
        if ($KimiPath -eq "kimi-webbridge.exe") {
            & "kimi-webbridge.exe" start
        }
        else {
            & $KimiPath start
        }
        Log-Ok "Daemon started (or already running)"

        # Wait and verify
        Start-Sleep -Seconds 2
        for ($i = 1; $i -le 5; $i++) {
            try {
                $status = Invoke-RestMethod -Uri "http://127.0.0.1:10086/status" -Method Get -ErrorAction Stop -TimeoutSec 5
                if ($status.running -eq $true) {
                    Log-Ok "Daemon responding at http://127.0.0.1:10086"
                    return $true
                }
            }
            catch {
                Start-Sleep -Seconds 1
            }
        }
        Log-Warn "Daemon started but not responding yet. May need a moment."
        return $true
    }
    catch {
        Log-Err "Failed to start daemon: $_"
        return $false
    }
}

# =============================================================================
# STEP 3: Browser Extension (manual)
# =============================================================================
function Check-BrowserExtension {
    Log-Info "Kimi WebBridge browser extension (manual step required):"
    Write-Warning "You MUST install the browser extension (Chromium-based browsers ONLY):"
    Write-Warning "  Chrome / Edge / Brave / Arc:"
    Write-Warning "    → https://chromewebstore.google.com/detail/kimi-webbridge/fldmhceldgbpfpkbgopacenieobmligc?pli=1"
    Write-Warning "    → Click 'Add to Chrome'"
    Write-Warning ""
    Write-Warning "  After install:"
    Write-Warning "    → Click extension icon in toolbar"
    Write-Warning "    → Sign in with your Kimi account (REQUIRED)"
    Write-Warning "    → Should show 'Connected to daemon'"
}

# =============================================================================
# STEP 3: Clone Skills Repository
# =============================================================================
function Clone-Skills {
    Log-Info "Cloning skills to $SKILLS_DIR..."

    if (Test-Path (Join-Path $SKILLS_DIR ".git")) {
        Log-Info "Repository exists, pulling latest..."
        try {
            Push-Location $SKILLS_DIR
            git pull --ff-only
            if ($LASTEXITCODE -ne 0) { throw "git pull failed (exit code $LASTEXITCODE)" }
            Log-Ok "Skills updated"
        }
        finally { Pop-Location }
    }
    else {
        try {
            git clone "https://github.com/sloemo01/hermes-skills-bundle.git" $SKILLS_DIR
            Log-Ok "Skills cloned to $SKILLS_DIR"
        }
        catch {
            Log-Err "Clone failed: $_"
            return $false
        }
    }
    return $true
}

# =============================================================================
# STEP 4: Verify Skills
# =============================================================================
function Verify-Skills {
    Log-Info "Verifying skills..."

    $skills = @(
        "kimi-webbridge",
        "deep-web-research",
        "job-search-automation",
        "linkedin-automation",
        "mcp-server-research",
        "osint-person-search",
        "interactive-prompt-analyzer",
        "research-automation-bundle",
        "memory-setup"
    )

    $missing = 0
    foreach ($skill in $skills) {
        $skillFile = Join-Path (Join-Path $SKILLS_DIR $skill) "SKILL.md"
        if (Test-Path $skillFile) {
            Log-Ok "  $skill"
        }
        else {
            Log-Err "  $skill (MISSING)"
            $missing++
        }
    }

    if ($missing -eq 0) {
        Log-Ok "All $($skills.Count) skills present"
        return $true
    }
    else {
        Log-Err "$missing skill(s) missing"
        return $false
    }
}

# =============================================================================
# STEP 5: Prompt Restart
# =============================================================================
function Prompt-RestartHermes {
    Write-Warning "You MUST RESTART HERMES now for skills to load:"
    Write-Warning "  Close Hermes (Alt+F4), then reopen from Start menu"
}

# =============================================================================
# MAIN
# =============================================================================
try {
    Write-Host ""
    Write-Host "╔═══════════════════════════════════════════════════════════════════════╗"
    Write-Host "║  Hermes Research Automation Skill Bundle — Windows Installer      ║"
    Write-Host "╚═══════════════════════════════════════════════════════════════════════╝"
    Write-Host ""

    Write-Warning "⚠️  BEFORE RUNNING: You MUST add your NVIDIA NIM API key first!"
    Write-Warning "   1. Go to https://build.nvidia.com/nvidia/nemotron-3-ultra-550b-a55b"
    Write-Warning "   2. Click 'Get API Key' → copy nvapi-..."
    Write-Warning "   3. In Hermes: Settings (gear) → Models/Providers → NVIDIA → paste key"
    Write-Warning "   4. Select model: nvidia/nemotron-3-ultra-550b-a55b"
    Write-Host ""
    Read-Host "Press Enter after adding your NVIDIA API key to Hermes..."

    # Step 1: Install Kimi WebBridge
    $kimiPath = Install-KimiWebBridge
    if (-not $kimiPath) { throw "Kimi WebBridge installation failed" }

    # Step 2: Start daemon
    if (-not (Start-KimiDaemon $kimiPath)) { throw "Failed to start Kimi daemon" }

    # Step 3: Browser extension
    Check-BrowserExtension

    # Step 4: Clone skills
    if (-not (Clone-Skills)) { throw "Skills clone failed" }

    # Step 5: Verify
    if (-not (Verify-Skills)) { throw "Skill verification failed" }

    # Step 6: Prompt restart
    Prompt-RestartHermes

    Write-Host ""
    Write-Host "============================================================"
    Write-Host "  Installation complete! 🎉"
    Write-Host "============================================================"
    Write-Host ""
    Write-Host "Next steps after restarting Hermes:"
    Write-Host "  1. In chat: 'Set up my memory'  (runs 5-question setup)"
    Write-Host "  2. Try: 'Research AI agent frameworks'"
    Write-Host "  3. Try: 'Find remote ML engineer jobs'"
    Write-Host ""
}
catch {
    Log-Err "Installation failed: $_"
    exit 1
}