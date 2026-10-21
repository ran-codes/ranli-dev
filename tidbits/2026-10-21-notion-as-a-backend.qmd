---
title: "Notion as a backend for a static site"
date: "2026-10-21"
categories: [notion, cloudflare, architecture]
---


## Rambling

its finel lfor assuepr siempl do public wihtou auth so anyitng. lets say we have suepr simple database in notion a tabel of baby names two columns Name and another randomi coumn lets say numebr popautliary rating 0-10 that datbase is etup on notion. what hapepsn how i need auth otken specific ot that databaes that is troe din the cloruflar worker and the when a udpat ei mad ein the itnernface here what the psuh is goig to the cloduflalir which then udapte sthe databse? what abotu fetch in real time lets say i have a table viewin tidibits but hte entry is a form this woudl require JS for hte form but the table what ist here  sj lgoica there too that is like scan the noitnoatab ever 1 se to se if udpat ehtei f hter is to rererhes the html table? but that seems usper iniefiencet . who si my arhcenture plan? tohguhts?

## Understanding

- I want to explore the easiest way to get a CRUD feature using Notion databases as the backend on s simple static site
- This would require some sort of proxy function to store the API Token with access to the Notion database
- This would then ahve several comepontsn

1. A database (Notion database) - lets say simple schema of baby names 2 columns 'Name (text)' and "popularity 0 - 10 numeric'
2. front end - a data entry form - JS for data entry that after click submit will push info and trigger some server function
   - What access permissions will this need - READ and WRITE
   - This is simple Insert form we cna make it mroe ocmeplx for pathces and deleiotns but htat sjust JS compelxity the archiehture we will just handle insert
3. Proxy -  a serverless function (e.g. a Cloudflare worker) whihc stores the Database acces secerets. There are as many routes as needed for CRUD (Routes) into `/names`
   - routes
     -  `GET` Reads
     -  `POST` inserts new rows 
     - `PATCH` updates
     - `DELETE` deletes
   - Providers for serverless functions (aka edge functiosn)
     - Cloudflare workers (easeiest to setup and most free tier calls)
     - Azure Functions
     - AWS Lambda
     - GCP Cloud Run Functions
4. Front end -  a table that reads from the databse has JS logic to:
   - on page load will read form database `GET /names`
   - on form submission it is trigere to reread so the udpate thigns how up `GET /names`



## Artifacts

```{mermaid}
sequenceDiagram
    participant Form as Front end: form (JS)
    participant Table as Front end: table (JS)
    participant Worker as Cloudflare Worker<br/>(holds Notion token)
    participant Notion as Notion database<br/>(baby names)

    Note over Table,Notion: Page load
    Table->>Worker: GET /names
    Worker->>Notion: query database
    Notion-->>Worker: rows
    Worker-->>Table: JSON rows

    Note over Form,Notion: Form submit
    Form->>Worker: POST /names {name, popularity}
    Worker->>Notion: create page (row)
    Notion-->>Worker: ok
    Worker-->>Form: ok
    Form->>Table: trigger refresh
    Table->>Worker: GET /names
    Worker-->>Table: updated rows
```

## Appendix A - Related tidbits to follow up on

