---
title: "Agent accessibility in Quarto and Docusaurus doc sites"
date: "2026-11-06"
categories: [quarto, docusaurus, ai-agents, docs]
---
# Rambling

- ugh i am making a lot of documentatino sites mainly in quarot but starting to get into toher docs specific tools like docusarus and astro starlight
- my quetions is in the agent of agents. 
- what best practieces (in Nov 2026) are there for makig doc siste agent and accessible
- i hear the word `llm.txt` or soethgi or wheher that quaot emebds. but id ton know
- this tibit is just to oreint my self and provide myself wihta priemr so i can impelment best practices into my docs sites

# Understanding

- there is a gold standard for agent accessiblity of doc sites
  - `llms.txt` is a singel index of all the pages on your side
  - (`llms.md` oor `.md`) is markdown copy of each page
  - `llms-full.txt` all docs in one file
- For the tools that i use here is the support for these artifacts


|                                        | Quarto (native, 1.9+) | Docusaurus 3.x (no native support; community plugin [rachfop/docusaurus-plugin-llms](https://github.com/rachfop/docusaurus-plugin-llms) v0.6.1) |
| -------------------------------------- | --------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------- |
| `llms.txt` (page index)                | ✅                     | ✅                                                                                                                                               |
| Markdown copy of each page             | ✅                     | ✅                                                                                                                                               |
| `llms-full.txt` (all docs in one file) | ❌                     | ✅                                                                                                                                               |


- Quarot has native support
- Only works in website and set in quarto.yaml

```
website:
  llms-txt: true
```