---
title: "rig v0.11 - initial breakdown"
date: "2026-11-06"
categories: [r, rig, tooling]
---
# Rambling



- so posit just dropped rig v0.11 which apparently is a big deal because rig now managnes not jsut r verison but also r packages and projects; this makes it a super versitile tool that didnt exsitnig i th epost ecosytem befroe and relaly only esiting as a commutniy uvr package
- they dropped a thre part blog post aout this
  - R installations - [https://opensource.posit.co/blog/2026-10-09\_rig-0-11-0-part-one/?mkt\_tok=NzA5LU5YTi03MDYAAAGlUJB2DsIZMY7HVSuBkFUcmSe\_228qu8tlT1Zq\_q6plrmFKRdYl3tH0JDsTWhQJV3jrKvLOdKm81ZHagkmyawr8regy1BRL0V3FiqdJQaOwg0XA5s](https://opensource.posit.co/blog/2026-10-09_rig-0-11-0-part-one/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DsIZMY7HVSuBkFUcmSe_228qu8tlT1Zq_q6plrmFKRdYl3tH0JDsTWhQJV3jrKvLOdKm81ZHagkmyawr8regy1BRL0V3FiqdJQaOwg0XA5s)
  - R Packages - [https://opensource.posit.co/blog/2026-10-12\_rig-0-11-0-part-two/?mkt\_tok=NzA5LU5YTi03MDYAAAGlUJB2DkXVKrP40XoLMNXUs7xDzuBKN8BI3eADi03ydxzjV4sYJIENtBYNVHI80MBe-\_ngMiQgBOculS6gzifluHc-eLq3-JiK-6nmFHIQ7BVfjSQ](https://opensource.posit.co/blog/2026-10-12_rig-0-11-0-part-two/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DkXVKrP40XoLMNXUs7xDzuBKN8BI3eADi03ydxzjV4sYJIENtBYNVHI80MBe-_ngMiQgBOculS6gzifluHc-eLq3-JiK-6nmFHIQ7BVfjSQ)
  - R projects - [https://opensource.posit.co/blog/2026-10-15\_rig-0-11-0-part-three/?mkt\_tok=NzA5LU5YTi03MDYAAAGlUJB2DbvRH3b5q12idkOUvapnuL\_ftiQE5c6UVCVQiCjm\_XtNS6RFhDHifpfo2XcIlVHsNmZD5ciL2x5Egz1SBXX3raIXhTv1a0fJceaddPIVMKg](https://opensource.posit.co/blog/2026-10-15_rig-0-11-0-part-three/?mkt_tok=NzA5LU5YTi03MDYAAAGlUJB2DbvRH3b5q12idkOUvapnuL_ftiQE5c6UVCVQiCjm_XtNS6RFhDHifpfo2XcIlVHsNmZD5ciL2x5Egz1SBXX3raIXhTv1a0fJceaddPIVMKg)
- intiail impressio si that is fundamentall cahgesna lot of how R systmes are manged and a serioius contender to replace UVR
- This is new thing that willinfomr my opition on R system amnagement that was coverd in previous psots
  - [https://ranli.dev/tidbits/2026-10-12-r-package-and-env-management-renv.html](https://ranli.dev/tidbits/2026-10-12-r-package-and-env-management-renv.html)
  - [https://ranli.dev/tidbits/2026-10-21-uvr-test-drive/](https://ranli.dev/tidbits/2026-10-21-uvr-test-drive/)
- some queions
  - does this repalce uvr
  - i get R installs and packages but what are R projects in rig  (wahts hte utilty ? is r rpeojcts manged in uvr as well or not?)
  - how epxirement is the uspport of pack/proj (is it epxeirmental lable is it stable)
    - to inform if its owrht swithcing now or jsut wait for a more GA lable for htese fetures
- Approach
  - you know this is really one of those times where i am not sure how to approach this
  - should i raw dog it and feed it to an agent and ask quesitons like i suueally do - untill i have good understanidng
  - or sohuld i jsut read the blogs
  - how about lets do a hyrbid have the agent read it provide me bulletpoints to review then then i do my usualy question to learn type thing
- Notes from reading the summaryes
  - Part 1 -  R installation
    - User mode (without admin rights is super useful) - this is a feature i want to track? like does the uvr does it?
    - does uvr manage rtools?
    - sets up rstdio and positron automatically - what does tha tmena like do the intergrations?
    - P3M is waht???
  - Par 2 - R apckages
    - installs packages like page (tihouht starting R)
    - labeled as experiemntal... so when will it not be experimental? 
  - part 3 -  R projects
    - rproj.toml is the project toml then a rporoj.lock. - so these are the key artifacts
    - proejct shared packge file on disc (global packge )
    - laled as epxiemrental .... so whne willit not be expeirmental.

# Understanding

- rig now indeed has package/proj managmenet making on feature parity with uvr
- It seems to be more ergonomic than uvr as its maintaind by posit and thus tighter seams with posit tools. highlights include
  - rtools management 
  - IDE (Rstudio and POsitorn) auto-integration

- These are two very big feature additions that make it a  no-brainer not to adopt
- However currently rig pck/proj features ar elabled as expeirmental. so lets hold off on this untel they become GA
- Looking forward to it!! 

---

# References

## 1. Agent Bullet Points (make a toggle colabspoible later)

**Part 1: R installations**

- User mode: installs R without admin rights
- Portable Linux builds run on any glibc/musl distro
- `rig rtools` installs and manages Rtools on Windows
- Sets up RStudio and Positron automatically
- P3M is now the default; new `repos add` and `status`
- User mode is less tested than admin mode

**Part 2: R packages (`rig pkg`)**

- Installs packages like pak, without starting R
- Sources: CRAN, GitHub, git, URLs, local paths
- Version constraints: `@==`, `^`, `~`
- Dependency solver, parallel downloads, shared cache
- `doctor` finds broken or missing dependencies
- `info`, `deps`, `tree`, `search` look up packages
- Installs system deps automatically on major Linux distros
- The rig website labels it experimental

**Part 3: R projects (`rig proj`)**

- Works like uv or cargo: `rproj.toml` plus `rproj.lock`
- One lockfile covers several platforms and R versions
- Locked versions stay put until you `--upgrade`
- `sync` builds `.rvenv` and installs R if missing
- Projects share package files on disk, so libraries are cheap
- `rig run` runs project code or inline-dependency scripts
- Imports a project from DESCRIPTION or `renv.lock`
- devtools and similar tools live in a shared `tools` library
- The rig website labels it experimental

## 2. Feature parity: uvr vs rig


| Feature                                | rig v0.11.1                              | uvr                                   |
| -------------------------------------- | ---------------------------------------- | ------------------------------------- |
| Install R without admin rights         | ✅ user mode (admin is still the default) | ✅ always                              |
| Rtools management                      | ✅                                        | ❌                                     |
| Default R in RStudio/Positron          | ✅ set system-wide                        | ⚠️ per-project Positron settings only |
| Packages outside a project             | ✅ `rig pkg`                              | ❌                                     |
| CRAN/Bioc/GitHub/git/URL/local sources | ✅                                        | ✅                                     |
| Multi-platform lockfile                | ✅                                        | ✅                                     |
| Linux system deps                      | ✅ installs them when run as root         | ✅ installs with a flag                |
| Inline-dependency scripts              | ✅                                        | ✅                                     |
| Import from renv                       | ✅ also from DESCRIPTION                  | ✅ renv only                           |
| Search/info commands                   | ✅                                        | ❌                                     |
| Resolution strategies, overrides       | ❌                                        | ✅                                     |
| Stability                              | `pkg`/`proj` labeled experimental        | no label; pre-1.0 (v0.4.x)            |


- **No roadmap exists:** no milestones or issues, and no date for dropping the label
- **What the label means:** commands, `rproj.toml`, and `rproj.lock` formats may change
- **Risk is similar for both:** uvr is unlabeled but still pre-1.0
- **Recommendation:** try rig now, but expect lockfile churn; asking in rig's GitHub Discussions is the only way to get an ETA

