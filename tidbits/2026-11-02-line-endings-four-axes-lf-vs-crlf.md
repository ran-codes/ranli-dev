---
title: "Line endings on four axes: LF vs CRLF, repo vs local, .gitattributes, and the refresh"
date: "2026-11-02"
categories: [git, line-endings, gitattributes, windows]
---
# 1. Ramblings

- Some of the repos i am working on that have prettier in the checks workflow keeps popping up with this same bug
- its cosmetic but still  bother to deal with
- i can fix it with claude but dont understand fully yet.
- I believe there are a few axis
  - 1) its not a bug - just a cosmetic thing
  - 2) LF vs CRLF
  - 3) local vs origin
  - 4) git command to fix it  `git rm -r --cached -q :/ && git reset --hard`
- so these are things i want to learn
- probably need to init a git/github glossary along the way.

# 2. Understanding

- Triage
  - There are some core concpets i need to udnerstand (LF vs CRLF)
  - then there is tooling around these that are secondary
  - lets start wiht the concepts



## 2.1 Core Concept: OS newline or End of Line (EOL) conventions

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
      -   Unix/Mac - we dont need both so lets jsut simplfiy and keep one `LF` (one less byte per line! - without losing anyhting other than deviation from history)
      - Windows - said lets keep the old traditional at the end of line type both the `CR` + `LF` - (`\r \n`) like typewriters did

- The problem 
  - Prettier standardizes to test that the code base sohuld be `LF`  (Unix/Mac) 
  - but our windows tooling often produces `CRLF`leading to frequent prettier failures



## 2.2 Tooling

- So now we are ont