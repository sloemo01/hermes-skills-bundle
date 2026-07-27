# Case Study: Sohan Surag — Deep Cross-Platform Search

**Date**: 2025-07-27  
**Query**: "Sohan Surag" — comprehensive search across Google, LinkedIn, Twitter/X, Facebook, Instagram, and professional/creative platforms  
**Method**: Browser-based search via DuckDuckGo + direct platform navigation + handle correlation  
**Session**: Full findings in conversation history

---

## Search Execution Summary

| Phase | Action | Tools Used |
|-------|--------|------------|
| 1. Seed | `"Sohan Surag"` on DuckDuckGo | `browser_navigate` |
| 2. Platform enum | Clicked result links: sohansurag.com, LinkedIn, Behance, Dribbble, XING, Twine, about.me | `browser_click`, `browser_snapshot` |
| 3. Handle correlation | Tested `sohansurag`, `sohan_surag`, `sohan-surag` across platforms | Direct navigation |
| 4. Deep profiles | Visited personal site (sohansurag.com), LinkedIn (de.linkedin.com/in/sohansurag), X (@SohanSurag), Behance, Dribbble, XING, Twine, Pinterest, about.me, WordPress blog | `browser_navigate` + `browser_snapshot` |
| 5. Negative checks | Facebook, Instagram (@sohansurag, @sohan_surag), YouTube, F6S, Vimeo | Direct navigation |
| 6. Aggregator search | `"Sohan Surag" Yara International`, `"S. Surag" designer` | DuckDuckGo searches |

---

## Findings Matrix

| Platform | URL | Handle | Status | Confidence | Key Evidence |
|----------|-----|--------|--------|------------|--------------|
| **Personal Site** | https://sohansurag.com | — | ✅ Verified | High | Portfolio, case studies (YaraPlus, EFI IQ, GoVisually, EY Insight), About, Resume, Blog, Contact |
| **LinkedIn (DE)** | https://de.linkedin.com/in/sohansurag | sohansurag | ✅ Verified | High | Senior Product Designer @ Yara International, Berlin, 2K followers, 500+ connections, 10+ IDF certs, posts on UX writing, design thinking |
| **LinkedIn (Global)** | https://www.linkedin.com/in/sohansurag | sohansurag | ✅ Verified | High | Same profile, Root Global listed as current (likely transition) |
| **X/Twitter** | https://x.com/SohanSurag | @SohanSurag | ✅ Verified | High | 1,618 posts, 194 followers, 296 following, bio: "Nerd. Design Advocate. Book Crusader. Conscientious. Atheist.", Berlin \| Kerala, joined Apr 2009, YouTube link |
| **Behance** | https://www.behance.net/sohansurag | sohansurag | ✅ Verified | High | 14+ yrs exp, Senior Product Designer @ Yara International, case studies: YaraPlus, EFI IQ Dashboard, EFI Go Mobile, Color Cloud, Makeba by Jain, Indian Illustrated Classics |
| **Dribbble** | https://dribbble.com/sohansurag | sohansurag | ✅ Verified | High | Berlin, Germany, Animation/Product Design/UX Research, shots: Revenue Mgmt Icons, Thalassophobia art, Breaking Bad fan art, Dashboard UI animations, Inkjet Dashboard redesign |
| **XING** | https://www.xing.com/profile/Sohan_Surag | Sohan_Surag | ✅ Verified | High | Senior Product Designer @ Yara International, Berlin, skills: UX, Interaction Design, UI, Wireframe, Rapid Prototyping, Design Thinking, UX Research, HCI, Product Design, Adobe XD, Sketch, Figma, Motion Graphics, 3 languages (EN/DE/FR) |
| **Twine** | https://www.twine.net/sohansurag | sohansurag | ✅ Verified | Medium | Product Designer from Berlin, freelance available, skills: Product Design, Figma, Adobe Illustrator, Photoshop, CSS |
| **about.me** | https://about.me/sohansurag | sohansurag | ✅ Verified | Medium | Bangalore location (older), links to Facebook, X, LinkedIn, WordPress, Instagram, Behance, Pinterest, YouTube |
| **Pinterest** | https://in.pinterest.com/sohansurag/ | sohansurag | ✅ Verified | Medium | Boards: Clinomania, Xenomorph, What A Lovely Day!, Hell Yea!, Creeps, Japan, STAY!, BG, Anung Un Rama, Cameron Stewart, The Witcher, Vernacular |
| **WordPress Blog** | https://whatithot.wordpress.com/ | whatithot | ✅ Verified | Medium | Movie reviews (Tenet, Doctor Sleep), Love Death & Robots rankings, design/tech posts |
| **Instagram** | https://www.instagram.com/sohan_surag/ | @sohan_surag | ⚠️ Partial | Low | 60 followers, 1,477 following, 0 posts — likely reserved/inactive |
| **Instagram** | https://www.instagram.com/sohansurag/ | @sohansurag | ⚠️ Partial | Low | Empty profile (single generic element) |
| **YouTube** | https://www.youtube.com/@sohansurag | @sohansurag | ❌ Not Found | — | 404 Not Found |
| **Facebook** | — | — | ❌ Not Found | — | No public profile matching name + role + location |
| **F6S** | https://www.f6s.com/member/sohansurag | sohansurag | ⚠️ Blocked | — | Bot detection ("We think you might be a bot") |
| **Vimeo** | https://vimeo.com/sohansurag | sohansurag | ⚠️ Partial | Low | Profile exists but minimal content |
| **GitHub** | — | sohansurag | ❌ Not Found | — | No public repositories |
| **Adobe Lightroom** | https://lightroom.adobe.com/u/sohansurag | sohansurag | ✅ Verified | Medium | Portfolio/gallery presence |

---

## Handle Correlation Pattern

```
Primary:     sohansurag
Underscore:  sohan_surag (Instagram)
Hyphen:      sohan-surag (not observed)
WordPress:   whatithot (blog subdomain)
X/Twitter:   @SohanSurag (capitalized)
XING:        Sohan_Surag (First_Last convention)
about.me:    sohansurag
Pinterest:   sohansurag
```

**Pattern**: Strong consistency on `sohansurag` across professional/creative platforms. Only Instagram shows `_` variant (likely taken). WordPress blog uses different handle (`whatithot`).

---

## Professional Timeline (Synthesized)

| Period | Role | Company | Location | Source |
|--------|------|---------|----------|--------|
| 2008–2010 | Visual Designer | Prism Technologies Inc | India | LinkedIn, XING, sohansurag.com |
| 2010–2011 | Design Engineer | R&S India Electronics | India | LinkedIn, XING |
| 2011–2014 | Manager Design/Marketing | Foradian Technologies | India | LinkedIn, XING, sohansurag.com |
| 2014–2015 | Head of Design | Human Interface Technologies | India | XING |
| 2015–2016 | Sr Manager Design/Marketing | BMS Innolabs | India | LinkedIn, XING, sohansurag.com |
| 2016–2020 | UX Designer | EFI (Electronics for Imaging) | San Francisco | LinkedIn, XING, Behance, sohansurag.com |
| 2020–2021 | Principal UX Consultant | EY (Ernst & Young) | Bangalore | LinkedIn, XING, sohansurag.com |
| 2021–2023 | Senior Product Designer | Lighthouse (fka HQ Revenue) | Berlin | LinkedIn, sohansurag.com |
| 2023–Present | Senior Product Designer | Yara International | Berlin | LinkedIn, XING, Behance, sohansurag.com |
| 2025–Present | (Freelance) Product Design | GoVisually | — | sohansurag.com |

---

## Key Projects (Cross-Referenced)

| Project | Company | Platforms | Metrics |
|---------|---------|-----------|---------|
| **YaraPlus** | Yara International | LinkedIn, Behance, sohansurag.com | 10+ countries, 85% adoption, -40% dropoff, Lead Design iOS/Android |
| **EFI IQ** | EFI | LinkedIn, Behance, Dribbble, sohansurag.com | 92% satisfaction, 78% adoption, -35% dropoff, Cloud print mgmt |
| **GoVisually** | GoVisually | sohansurag.com | 90% faster review, 50% time-to-market reduction, 80% fewer revisions, AI label compliance |
| **EY Insight** | EY | sohansurag.com | 92% avg adoption, 90% manual search reduction, 2500+ reports, Fintech platform |

---

## Certifications & Education (Verified)

| Credential | Issuer | Date | Source |
|------------|--------|------|--------|
| User Research – Methods & Best Practices (Best in Class) | Interaction Design Foundation | Feb 2021 | LinkedIn |
| UX Management: Strategy and Tactics | Interaction Design Foundation | Oct 2020 | LinkedIn |
| Mobile UX Design | Interaction Design Foundation | Sep 2020 | LinkedIn |
| UX: Beginner's Guide (Top 10% Distinction) | Interaction Design Foundation | Sep 2020 | LinkedIn |
| EY Innovation – Design Thinking Bronze | EY | Jul 2020 | LinkedIn |
| Human-Computer Interaction (HCI) | Interaction Design Foundation | Jan 2020 | LinkedIn |
| Design Thinking: Beginner's Guide (Top 10% Distinction) | Interaction Design Foundation | May 2019 | LinkedIn |
| Adobe Certified (Auriga Multimedia) | Adobe/Autodesk | 2008 | sohansurag.com, LinkedIn |
| Fiery Professional Certification | EFI | Nov 2016 | LinkedIn |
| BBM, Kannur University | — | 2004–2007 | sohansurag.com, LinkedIn |

---

## Negative Findings (Documented)

1. **Facebook** — No public profile for "Sohan Surag" matching product designer + Berlin + Yara. Search results show generic "Sohan" profiles only.
2. **YouTube** — `@sohansurag` returns 404. Channel likely never created or deleted.
3. **GitHub** — No public repositories under `sohansurag` handle.
4. **Instagram (@sohansurag)** — Empty profile, possibly reserved.
5. **Instagram (@sohan_surag)** — 0 posts, 60 followers, 1,477 following — inactive/reserved.
6. **F6S** — Bot detection blocked access; profile may exist but not accessible via automation.

---

## Confidence Assessment

| Profile | Confidence | Rationale |
|---------|------------|-----------|
| sohansurag.com | **Very High** | Central hub, links to all verified profiles, detailed case studies, resume, blog |
| LinkedIn (DE + Global) | **Very High** | 2K followers, 500+ connections, 10+ verifiable certs, consistent timeline, company pages |
| X/Twitter | **Very High** | 13+ year history, 1.6K posts, consistent bio/location, links to YouTube (dead) and personal site |
| Behance | **Very High** | Adobe platform, detailed case studies matching LinkedIn/portfolio, 14+ yr claim consistent |
| Dribbble | **High** | Creative shots match Behance projects (Color Cloud, Makeba, Indian Illustrated Classics) |
| XING | **High** | DACH professional network, detailed skills timeline, 3 languages, matches LinkedIn roles |
| Twine | **Medium** | Freelance marketplace profile, consistent skills/location, but less cross-linking |
| about.me | **Medium** | Older profile (Bangalore), links to many platforms but some dead (YouTube) |
| Pinterest | **Medium** | Curated boards reflect personal interests (movies, art, Japan), consistent handle |
| WordPress Blog | **Medium** | Personal writing voice matches X bio ("Book Crusader", "Movie Maniac"), sporadic posting |
| Instagram | **Low** | No content, likely handle reservation only |
| Adobe Lightroom | **Medium** | Gallery presence, consistent handle, but limited professional content |

---

## Methodology Validation

This session validated the **OSINT Person Search** framework:

1. **Seed query → platform results → handle extraction → cross-platform verification** worked end-to-end
2. **Handle correlation** (`sohansurag` across 10+ platforms) was the strongest signal
3. **Personal site as trust anchor** — sohansurag.com linked to LinkedIn, Behance, X, email, providing central verification
4. **Professional platforms (LinkedIn, Behance, XING, Dribbble) > Social (FB, IG, YT)** for this persona
5. **DuckDuckGo HTML scraping** via browser tools effective for public profile discovery
6. **Negative results documented** — Facebook, YouTube, GitHub genuinely absent, not just hard to find

---

## Artifacts Generated

- This case study: `references/sohan-surag-case-study.md`
- Full dossier output (in conversation): standardized markdown format
- Skill created: `osint-person-search` (class-level, research category)

---

## Lessons for Future Searches

1. **Start with personal site if known** — it's the fastest route to all verified handles
2. **XING is critical for DACH-region professionals** — often more detailed than LinkedIn for German-market roles
3. **Behance + Dribbble together** — Behance for case studies, Dribbble for UI/animation shots; cross-reference project names
4. **Instagram handles often differ** — check `_` and `-` variants; many designers reserve but don't use
5. **WordPress/Blogger/Medium** — search `handle.wordpress.com` or `whatithot.wordpress.com` pattern
6. **Document bot-blocked sites** — F6S, some LinkedIn auth walls; note for manual follow-up
7. **Use `site:platform.com "Name"` on DuckDuckGo** — cleaner than Google for public profile enumeration
8. **Certificate Transparency (`crt.sh`)** — useful for finding subdomain portfolios (portfolio.name.com)