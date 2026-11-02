---
title: "Line endings on four axes: LF vs CRLF, repo vs local, .gitattributes, and the refresh"
date: "2026-11-02"
categories: [git, line-endings, gitattributes, windows]
---
## 1. Ramblings

- Some of the repos i am working on that have prettier in the checks workflow keeps popping up with this same bug
- its cosmetic but still  bother to deal with
- i can fix it with Claude but don't understand fully yet.
- I believe there are a few axis
  - 1) its not a bug - just a cosmetic thing
  - 2) LF vs CRLF
  - 3) local vs origin
  - 4) git command to fix it  `git rm -r --cached -q :/ && git reset --hard`
- so these are things i want to learn
- maybe need to init a git/GitHub glossary along the way.

## 2. Understanding

- Triage
  - There are some core concepts i need to understand (LF vs CRLF)
  - then there is tooling around these that are secondary
  - lets start with the concepts
  - then move on to the tooling



### 2.1 Core Concept: OS newline or End of Line (EOL) conventions

- When a line of code ends; there are are two ways of ending the line when it comes to the binary aspect - way 1 and way 2
- Way 1 amd way 2 are not rules. they can both work on tools acoss operating systems (windows git vs mac/unix git)
- But each tool-os has their defaults
  - Windows git defaults to way 1
  - Unix/Mac git defaults to way 2
- History of way 1 and way 2
  - a bit is a binary digit 0 or 1
  - a byte is a 8 bits
  - most ASCII cahracters (aka most of code) is 1 byte per character
  - There are two characters that are using in encoding end of line
    - Line Feed (LF) aka `\n`  
    - Carriage Return (CR) aka `\r`
    - historically these came from typewritters; where to type a new line you needed to type both to create the new line in typewritteres
    - When people started writing code on computers (keboards) not type-writers
    - we diddn tneed botht o iencode a new line but the two branches forka bit interms of opinion
      - Unix/Mac - we dont need both so lets jsut simplfiy and keep one `LF` (one less byte per line! - without losing anyhting other than deviation from history)
      - Windows - said lets keep the old traditional at the end of line type both the `CR` + `LF` - (`\r \n`) like typewriters did
- The problem 
  - Prettier standardizes to test that the code base sohuld be `LF`  (Unix/Mac) 
  - but our windows tooling often produces `CRLF`leading to frequent prettier failures



&nbsp;

## 2.2 Tooling

- So now we are on to the tooling (speiccally github). There three thigns i want to udnrestand
  - `.gitattribute` (specifically the EOL config)
  - implcaitions for `local` vs `remote`
  - how the reomcend fix command works  `git rm -r --cached -q :/ && git reset --hard`
- GitHub remote/cloud/origin stores  on the cloud a version of your codebase including the EOL - the commited bytes
- Git has a sepcific file called   `.gitattirbutes` which stores the configurations for how git converts and works with your codebase (e..g on clones or commits); one such config is the EOL config
- So to fix the preittier warning/bug; the first step is to always make sure your gitattribute EOL config is set to LF and Commit/push
- But what the config is set in the gitattrbute is not teh same as what bytes (EOL) are saved in the github repo origin and local. These stored byte vs LF config in gittatrbutes can exist in two scenarios

- There can be two cases where we can have hte bad EOL (CRLF)
  - Case one its on the GitHub Repo in the cloud/origin - Repo CRLF
  - Case 2 the Repo is okay its Repo LF but local CRLF
- These two cases have two fixes
  - Case 1 Repo CRLF
    - we can call `git add --renormalize` which will re-appled the settings of LF in `.gitattributes` to every tracekd file, so CRLF gets stroed as LF on the next commit and push
  - Case 2 Repo LF but Local CRLF
    - we can call \``git rm -r --cached -q :/ && git reset --hard`` 
    - Whihc does the following
      - `git rm -r --cached -q :/` empties the index; disk untouched
      - `git reset --hard` rebuilds the index and rewrites every file through .gitattributes, as LF
      - riskis dicards ucomed edits. so make sure you run this on a clean worktree!

---

# Reference

## a. Diff LF vs CRLF

The same two lines of code, saved with each line ending. `␍` is CR (`\r`) and `␊` is LF (`\n`); both are normally invisible.

```diff
- const a = 1;␍␊      ← CRLF (Windows): 2 bytes per line ending
- const b = 2;␍␊
+ const a = 1;␊        ← LF (Unix/Mac): 1 byte per line ending
+ const b = 2;␊
```

Raw bytes (`od -c`):

```diff
- c o n s t   a   =   1 ; \r \n
+ c o n s t   a   =   1 ; \n
```

The text is identical. The only difference is the extra `\r` before every `\n`.

Prettier (default `endOfLine: "lf"`) flags each of those `\r` characters:

```
1:13  error  Delete `␍`  prettier/prettier
```

