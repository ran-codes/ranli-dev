---
title: "Next.js server vs. client components in static exports"
date: "2026-10-05"
categories: [nextjs, react, static-site]
---
## Ramblings

- Next.js has two types of compoents
  - Server Componets and Client Compoentsn
- These terms are confusing because Next.js static exports can still use server comeponts
- They just indicate what is run at build time not what is expeorted
- So at build time server compoents run the next.js server and export pure HTML
- Client ocmeopnts run at build time to export boht the HTML and the JS coderequired for a HTML page to funciton
- Server site build ouptus are smaller ebucase thye dont ship JS
- The best practice is to use SErver side comeponts uneslss required client side specific features (most of the server comeponts are the best practice)
- It is confuse beacuse there are some SSR next.js feautre locked ibehcig server comeponts which in that cas erequires a nExt.j server and would not work as auflly static export
- So this PR essentially  developes the loom integraitn o to work with both server and client pages; as wella smepahsize the best practice of defaulting to server

## Understanding

- Two Types of Next.js Components: 1) Server and 2) Client
  - The key idea and difference is: **where the code** **runs** not when
  - Server components
    - The JS runs on the Next.js Server to produce HTML
    - In hybrid/SSR Next.js this could be in the actual Next.js server in real-time in production as there is a server
    - In export/SSG Next.js this runs on Next.js during build time to produce HTML that is deploy to a serverless static site host.
  - Client Components
    - The Next.js code (JS) is shipped and runs in the clients browser
- Best practice is to user Server Compoents; 'use client' only when required on smaller niche compoentns that need it



---

## Appendix A - Related tidbits to follow up on

- Hydration
- What breaks exports