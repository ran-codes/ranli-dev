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

## Processing

## Understanding

## Appendix A - Related tidbits to follow up on
