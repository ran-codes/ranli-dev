---
title: "JS script runners and package managers: npm, pnpm, and vite test"
date: "2026-10-08"
categories: [javascript, pnpm, npm, vite, tooling]
---
## Ramblings

- there are some basictoling for JS develeoprm either enxt.js or svelte.
- `pnpm` and `npm` then `vite` and `vitetest`
- from what i udresnta ther first 3 are packge apmagein each wiht own script fruning funcitonality. tehyera r enot edeidcate tasks urnigns like `just`
- so the tehst and cheks thems selves are ocmspeosn of atomic toosl such as lint or audit or scripts but youc an compose 'script' that ocmpsoe thes smaller tasks and run the ith pnpmn npmn nd vite 
- but what i dont udnrnsta d i
  - s what is diff betwen viteest and vite 
  - what is hte best rpactice 
  - pros and cons to each
    - I do kwno pro is worktress and globa sitnal via pnpmn but what about vite and vitetest vs npmn/pnpmn?

## Understanding

- What is key is the axis we are discussion which is what layer the technologies sit at
- There are two layers **in this context** a higher level and a lower level




| Level      | Layer           | Description                                        | Tools                                                                                                                                                                    |
| ---------- | --------------- | -------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Higher** | Package manager | Installs dependencies, runs `package.json` scripts | `npm`, `pnpm`                                                                                                                                                            |
| **Lower**  | Tool            | Does the actual work, called by scripts            | `next`, `vite`, `vitest`, `jest`, `eslint`, `oxlint`, `prettier`, `tsc`, `svelte-check`, `stylelint`, `cspell`, `concurrently`, `rimraf`, `func`, `swa`, `serve`, `node` |




## Appendix A - Related tidbits to follow up on

- vite is build tool ananllogous to turbopack for next.js ; vitetest - is that packge deicite testing packge
- pnpm is a more modern npm and has a share package store (much better for worktrees); by defualt recomended to us pnpmn for JS project's package mangement
- The best practice is for all projects to use one package manager with script running capabilites; group major tasks as scripts to be called by the package manager!

