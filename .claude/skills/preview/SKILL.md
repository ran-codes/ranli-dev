---
name: preview
description: Start a fast Quarto preview of this site without rendering anything. Runs `quarto preview --render none`, which serves the existing `_site` on a free port and opens the browser. Use when the user says "preview", "start preview", "fast preview", or invokes /preview.
---

# Preview

Run exactly this, in the background:

```
quarto preview --render none
```

- Never render. No `quarto render`, no `quarto preview` without `--render none` — unless the user asks for a render explicitly.
- Quarto picks a free port and opens the browser. Report the URL it prints.
- Pages not yet in `_site` 404 until they are saved (preview re-renders on save) or rendered on request. Say so if a page 404s.
