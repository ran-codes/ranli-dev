---
title: "Quarto lightbox figures for HTML and Revealjs"
date: "2026-10-13"
categories: [quarto, html, revealjs]
---
## Ramblings

- Just learned Quarto can turn images into lightbox figures (click to enlarge) in HTML outputs like HTML documents and Revealjs slides. Docs: [https://quarto.org/docs/output-formats/html-lightbox-figures.html](https://quarto.org/docs/output-formats/html-lightbox-figures.html)

## Understanding

- A UI element that is an image which when cliked pops out hte image zoomed in in a nmodal is called a Lightbox 
- Ref and example:  [https://en.wikipedia.org/wiki/Lightbox\_(JavaScript)](https://en.wikipedia.org/wiki/Lightbox_(JavaScript))
- This feature has two parts
  - 1) the thumbnail image shown on your page (trigger)
  - 2) the modal that pops up (inlcude the dim abckground) with closable button
- Quarto makes this available for HTML outputs?
  - [https://quarto.org/docs/output-formats/html-lightbox-figures.html](https://quarto.org/docs/output-formats/html-lightbox-figures.html) 

## Appendix A - Related tidbits to follow up on