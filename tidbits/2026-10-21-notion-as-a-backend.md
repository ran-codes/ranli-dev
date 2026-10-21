---
title: "Notion as a backend for a static site"
date: "2026-10-21"
categories: [notion, cloudflare, architecture]
---
## Ramblings

- I want to explore the easiest way to get a CRUD feature using Notion databases as the backend on s simple static site
- This would require some sort of proxy function to store the API Token with access to the Notion database
- This would then ahve several comepontsn

1. A database (Notion database) - lets say simple schema of baby names 2 columns 'Name (text)' and "popularity 0 - 10 numeric'
2. front end - a data entry form - JS for data entry that after click submit will push info and trigger some server function
   - What access permissions will this need - write so basically ALL permissions
3. Proxy -  a serverless function (e.g. a Cloudflare worker) whihc stores the Database acces secerets will recieve the 
4. Front end -  a table that reads from the databse
   - on page load will read form database
   - on form submission it is trigere to reread so the udpate thigns how up

- Quesitons
  - so does the Front end table need a proxy function to read data too?
    - would this be two seperate functions?

## Understanding



## Appendix A - Related tidbits to follow up on
