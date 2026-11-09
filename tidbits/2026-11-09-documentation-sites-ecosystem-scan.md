---
title: "Documentation sites ecosystem scan"
date: "2026-11-09"
categories: [docs, docusaurus, astro, quarto]
---
# Rambling

- I have been exploring docuemntation sites in several of my projectsa nd ahve been getting more expeirenice and insight
- i want to use this tidbit ot compile that inshgt and also to do  slihgglt more rhtourhg omaprisons of docs site feature aprity
- jsuta s self reference amterial for docs sites dated Nov 2026 (as this like willc hagne rapidaly in 2027)
- The first reference table is a link to the docs site related PRs i have been doing recently.
- preivous pR meniton other tech but failed to touhc on psit great docs packge as docs fremwaokr.
  - its currently on Pythong
  - But roadmas is to have rust and JS support and R
- there are also other general docs gfrmaowek
  - mkdocs amterial
  - vitepress (no built in vrisoning)
  - mkdocs (in maiyinacne model, supercied but very young zeinsical)
  - spinx (python centric)
  - zensical - [https://github.com/zensical/zensical](https://github.com/zensical/zensical)  (too new)
- Here are some features sin my mind that must have NATIVE SUPPORT 
  - multi-linugal focus
  - semvar of docs   
  - agents accesiblity  
  - mermaid diagramres
  - Interactive compoetsl like tables (OJS tables)
  - Listing pages for glossaries and blogs
  - layout features like quarto for fleixblie and compelxity of docs
- next stesup
  - link related PRs
  - initail queisotna botu greater docs
    - its only py spport?? not R or rust or JS?
    - is it a packgea doucs framisome ntoa genral docs frmawkorig (relquires roxysngenr ot soemthign); so it cnanot be used frogneral docs sites?
  - develop a Parity table of tech avlailble adn silcnude the feautre sin my mind from above
  - Initi blocked page so tehconolgoes that are bl



# Understanding



- There is a difference between package docs generators (Pkgdown for R and Great Docs for Python) and general docs site frameowrks (docusarus, astro-starlight, quarto)
- This tidbit is focused on geneal docs sites framwroks only so we will onyl evlaute docsuars, astro-satrlight, quarto
- the feature aprtiy table is shown in ref 3
- the takeaway for general docs sites is to use docusarus as it has hte most antive spport ofr core feature required.
- but you can't really go wrong - hope quarto adds native semvra support soon but a issue scan.. seems unlikely. so for genral docusarus seems okay. for anything that is more R centric stick with quarot and tdoa handrolled CICID like salurbal-infra? maybe time will tell. we will try docsauruse with salrubal-obt jsut for the semvra stuff.
- time will tell...

   



---



# References

## 1. PR related to docs sites recently


| Repo                | Language | PR                                                                                  | Merged     | Framework      | What it did                              |
| ------------------- | -------- | ----------------------------------------------------------------------------------- | ---------- | -------------- | ---------------------------------------- |
| loom-warehouse      | Rust     | [#36](https://github.com/ran-codes/loom-warehouse/pull/36)                          | 2026-10-30 | Starlight      | Starlight site + GitHub Pages deploy     |
| loom-warehouse      | Rust     | [#40](https://github.com/ran-codes/loom-warehouse/pull/40)                          | 2026-11-05 | Starlight      | Home cards fixed, four-section layout    |
| loom-warehouse      | Rust     | [#42](https://github.com/ran-codes/loom-warehouse/pull/42)                          | 2026-11-05 | **Docusaurus** | Switched to Docusaurus for versioning    |
| loom-warehouse      | Rust     | [#44](https://github.com/ran-codes/loom-warehouse/pull/44)                          | 2026-11-05 | Docusaurus     | Generates `llms.txt`                     |
| loom-warehouse      | Rust     | [#45](https://github.com/ran-codes/loom-warehouse/pull/45)                          | 2026-11-05 | Docusaurus     | Markdown copy of each page               |
| salurbal-obt        | Python   | [#31](https://github.com/SALURBAL-Climate/salurbal-obt/pull/31)                     | 2026-10-22 | Quarto         | uvr + `just render`                      |
| salurbal-obt        | Python   | [#33](https://github.com/SALURBAL-Climate/salurbal-obt/pull/33)                     | 2026-10-22 | Quarto         | Specs site + CI                          |
| salurbal-obt        | Python   | [#34](https://github.com/SALURBAL-Climate/salurbal-obt/pull/34)                     | 2026-10-23 | Quarto         | Spec checked against Notion              |
| salurbal-obt        | Python   | [#36](https://github.com/SALURBAL-Climate/salurbal-obt/pull/36)                     | 2026-10-26 | Quarto         | Spec checked against production → v1.0.0 |
| salurbal-data-infra | R        | [#559](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/559)   | 2026-08-14 | Quarto         | noindex survives re-render               |
| salurbal-data-infra | R        | [#1016](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1016) | 2026-10-27 | Quarto         | Spec site + Azure Blob deploy            |
| salurbal-data-infra | R        | [#1028](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1028) | 2026-10-27 | Quarto         | Moved in design, schemas, glossary       |
| salurbal-data-infra | R        | [#1037](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1037) | 2026-10-28 | Quarto         | Fixed site CI pass/fail                  |
| salurbal-data-infra | R        | [#1050](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1050) | 2026-10-28 | Quarto         | Specs index site                         |
| salurbal-data-infra | R        | [#1086](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1086) | 2026-10-29 | Quarto         | Index at GitHub Pages root               |
| salurbal-data-infra | R        | [#1116](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1116) | 2026-10-30 | Quarto         | Path triggers + sparse checkout          |
| salurbal-data-infra | R        | [#1118](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1118) | 2026-10-30 | Quarto         | Trigger narrowed to Quarto folder        |
| salurbal-data-infra | R        | [#1120](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1120) | 2026-10-30 | Quarto         | PR trigger path filter                   |
| salurbal-data-infra | R        | [#1173](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1173) | 2026-11-03 | Quarto         | Added 11 rulings                         |
| salurbal-data-infra | R        | [#1182](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1182) | 2026-11-03 | Quarto         | Producer contract spec published         |
| salurbal-data-infra | R        | [#1189](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1189) | 2026-11-03 | Quarto         | File-flow diagram made readable          |
| salurbal-data-infra | R        | [#1208](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1208) | 2026-11-04 | Quarto         | CI on main push only                     |
| salurbal-data-infra | R        | [#1210](https://github.com/SALURBAL-Climate/salurbal-data-infrastructure/pull/1210) | 2026-11-04 | Quarto         | **One folder per spec version**          |


## 2. Tech mentioned in related PRs


| Type                   | Tool                       | Status                        | Where                                     |
| ---------------------- | -------------------------- | ----------------------------- | ----------------------------------------- |
| General docs framework | Astro Starlight 0.42       | Used, then dropped            | loom #36, #40                             |
| General docs framework | Docusaurus 3.10            | Used, current                 | loom #42–45                               |
| General docs framework | Quarto 1.10                | Used, current                 | obt, infra                                |
| Package docs generator | Great Docs (Posit)         | Not tried: Python pkgs only   | issue #64 (not a PR)                      |
| Package docs generator | pkgdown (R)                | Not tried: R standard, active | research (not a PR)                       |
| Extension              | starlight-versions         | Mentioned, not tried          | loom #42                                  |
| Extension              | starlight-sidebar-topics   | Mentioned, not tried          | loom #40                                  |
| Extension              | quarto-version-selector    | Not tried: v1.0.0, very new   | issue #64 (not a PR)                      |
| Extension              | docusaurus-plugin-llms 0.6 | Used: `llms.txt`              | loom #44, #45                             |
| Extension              | Pagefind                   | Used: Starlight search        | loom #36                                  |
| Host                   | GitHub Pages               | Used                          | loom, obt, infra index                    |
| Host                   | Azure Blob static site     | Used                          | infra refinement, producer contract specs |
| Host                   | Azure Static Web Apps      | Rejected: login not needed    | infra #1016                               |


## 3. Feature parity: general docs frameworks

Researched 2026-11-09 against each repo: Docusaurus 3.10.2 · Starlight 0.42.10 · Quarto 1.11.9.

✅ native · 🧩 extension · ❌ none


| Feature                        | Docusaurus         | Starlight          | Quarto                       | Extension that fills the gap                                                                                                                                                                       |
| ------------------------------ | ------------------ | ------------------ | ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Built on                       | React (JS/TS, MDX) | Astro (JS/TS, MDX) | Pandoc (Lua filters, `.qmd`) | —                                                                                                                                                                                                  |
| Multilingual site              | ✅                  | ✅                  | 🧩                           | [babelquarto](https://github.com/ropensci-review-tools/babelquarto) (62★, v0.1.0, R package)                                                                                                       |
| Docs versioning                | ✅                  | 🧩                 | 🧩                           | [starlight-versions](https://github.com/HiDeoo/starlight-versions) (102★, v0.10.2) · [quarto-version-selector](https://github.com/CCBR/quarto-version-selector) (0★, v1.0.0, 2 weeks old)          |
| Agent access (`llms.txt`)      | 🧩                 | 🧩                 | ✅                            | [docusaurus-plugin-llms](https://github.com/rachfop/docusaurus-plugin-llms) (147★, v0.6.1, used in loom #44) · [starlight-llms-txt](https://github.com/delucis/starlight-llms-txt) (117★, v0.12.0) |
| Mermaid diagrams               | ✅                  | 🧩                 | ✅                            | [astro-mermaid](https://github.com/joesaby/astro-mermaid) (125★, v2.2.0)                                                                                                                           |
| Interactive tables             | ✅                  | ✅                  | ✅                            | none needed                                                                                                                                                                                        |
| Listing pages (blog, glossary) | ✅                  | 🧩                 | ✅                            | [starlight-blog](https://github.com/HiDeoo/starlight-blog) (277★, v0.30.2), blog only                                                                                                              |
| Flexible layout                | ✅                  | ✅                  | ✅                            | none needed                                                                                                                                                                                        |
| Runs R and Python code         | ❌                  | ❌                  | ✅                            | none                                                                                                                                                                                               |


- Interactive tables and flexible layout: in Docusaurus and Starlight you write React or Astro components; in Quarto it is Markdown syntax or R/Python widgets.
- Quarto gaps: multilingual ([quarto-cli #275](https://github.com/quarto-dev/quarto-cli/issues/275), open since 2022) and versioning ([quarto-cli #474](https://github.com/quarto-dev/quarto-cli/issues/474), open since 2022).