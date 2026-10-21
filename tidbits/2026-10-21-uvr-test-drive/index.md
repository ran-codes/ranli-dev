---
title: "Test driving uvr: a uv-style manager for R"
date: "2026-10-21"
categories: [r, uvr, tooling]
---
## Ramblings

- okay here we test `uvr`  - [https://github.com/nbafrank/uvr](https://github.com/nbafrank/uvr)
- so scanning the docs so here are my queistons
  - scope
    - so it can be used for 'file' level or 'project level' management 
    - is there a way to set  a global defaul liek uv global?
  - the commands
    - `uvr init` does what? it inits a uv project memaning it creat eina ofdler some artacts like uv ldoes (lock files .... project.toml??))
    - `uvr add` adds a package to the uvr proejct - akes sne
    - `uvr sync` takes a uvr lcok file and isntalls the local R packges - quesiot to wehre does each get a local R pake folder? or is like pnpmn where there isa global store that can be reused across worktrees and stuff?
    - `uvr run` so alls cipts msut be call via temrinal ? what about quarto?
  - Queisotn
    - where are packge sinstaled withi lcoal repo? if so thas bad worktreses wont work?

## Ran Testing

### 1. Install CLI tool

```shell
PS C:\Users\ranli\orca\workspaces\ran-codes.github.io\uvr-test> irm https://raw.githubusercontent.com/nbafrank/uvr/main/install.ps1 | iex
uvr-install: Detected platform: x86_64-pc-windows-msvc
uvr-install: Installing uvr v0.4.7
uvr-install: Downloading uvr-x86_64-pc-windows-msvc.zip...
uvr-install: Verifying checksum...
uvr-install: Checksum verified
uvr-install: Extracting...
uvr-install: Installed uvr to C:\Users\ranli\.local\bin\uvr.exe
uvr 0.4.7
PS C:\Users\ranli\orca\workspaces\ran-codes.github.io\uvr-test> uvr --version
uvr 0.4.7
```



### 2. Init New Project `uvr init`

- This 'project' was scoped to this tidbits subfodler so relative path of  `tidbits/2026-10-21-uvr-test-drive` so `PS C:\Users\ranli\orca\workspaces\[ran-codes.github.io](http://ran-codes.github.io)\uvr-test\tidbits> cd .\2026-10-21-uvr-test-drive\`
- We first init a project here `uvr init`

```
PS C:\Users\ranli\orca\workspaces\ran-codes.github.io\uvr-test\tidbits\2026-10-21-uvr-test-drive> uvr init hello
✓ Initialized project hello
  uvr.toml
  .uvr/library/
```

This produced a few atirfacts:

1. `gitignore`
2. `.Rprofile`
   - This file contians the R code required for uvr to work?
3. `uvr.toml`
   - A init is empty wiht single paraptmer `name = "hello"`



### 3. Adding a package `uvr add`

- Lets now test some packages `uvr add tidyverse`
- that was fast 2.4 seconds!
- what gwas chagnd  
  - a new uvr.lock file (becuase its fithe fist add with dpeneicny detials)
  - then a dmepnciens secionts in the uvr.toml



```toml
[dependencies]
tidyverse = "*"
```



### 4. Lets test it out with a Script

- We create test.R whihc otnaisn sprint mtcars
- `uvr run test.R`



this is through the terminal 



```shell
PS C:\Users\ranli\orca\workspaces\ran-codes.github.io\uvr-test\tidbits\2026-10-21-uvr-test-drive> uvr run test.R
uvr: library linked (100 packages)
── Attaching core tidyverse packages ──────────────────────────────── tidyverse 2.0.0 ──
✔ dplyr     1.2.1     ✔ readr     2.2.0
✔ forcats   1.0.1     ✔ stringr   1.6.0
✔ ggplot2   4.0.3     ✔ tibble    3.3.1
✔ lubridate 1.9.5     ✔ tidyr     1.3.2
✔ purrr     1.2.2
── Conflicts ────────────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts tobecome errors
  cyl  n
1   4 11
2   6  7
3   8 14
```



It Works as epected!!



### 5. Does this work with a quarto file - YES with the activaiton like uvr actiaviete

- we setup `text.qmd` a normal 

- [x] Open a new `pwsh` (PowerShell 7) terminal → `$PSVersionTable.PSVersion` says 7.x (5.1 can't parse `activate.ps1`)
- [x] `. .uvr/activate.ps1` → no error
- [x] `Rscript -e ".libPaths()"` → `.uvr/library` listed first
- [x] `quarto render test.qmd` → renders without errors
- [x] Open `test.html` → `.libPaths()` shows `.uvr/library` first, tidyverse loads
- [x] `deactivate` → shell back to normal

```shell
.libPaths()

[1] "C:/Users/ranli/orca/workspaces/ran-codes.github.io/uvr-test/tidbits/2026-10-21-uvr-test-drive/.uvr/library"
[2] "C:/Program Files/R/R-4.5.3/library"      
```



- [x] Negative test: fresh `pwsh` at the repo root → `Rscript -e ".libPaths()"` → no `.uvr/library` (run outside this folder, since its `.Rprofile` links the library even without activation)

```shell
PS C:\Users\ranli\orca\workspaces\ran-codes.github.io\uvr-test> Rscript -e ".libPaths()"

[1] "C:/Users/ranli/AppData/Local/R/win-library/4.5"
[2] "C:/Program Files/R/R-4.5.3/library"   
```



&nbsp;

## Understanding

- So it seems like
- UVR can be used for both file level (metadata store in commnets at tope of R script) or project (Like uv level of details)
- There is a global package donwlaod folder which project pull from meaning the local lock files only ocntian poitners; This is GREAT for workteees!!!!
- See below for test run!
- Tips
  - set [Activaite] prompt conif tot true to see the uvr indicaiotr inthe tmeirnal! like it does for venv!
- THIS WORKS GREAT. Need ot itnegrate it into some projects!!!



## Appendix A - Related tidbits to follow up on