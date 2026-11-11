-- Attach the thumb-focus script and styles to HTML pages. The script applies each
-- image's data-focus crop, and adds the drag/zoom editor only on localhost.
function Meta(meta)
  if quarto.doc.is_format("html") then
    quarto.doc.add_html_dependency({
      name = "thumb-focus",
      version = "0.1.0",
      scripts = { "thumb-focus.js" },
      stylesheets = { "thumb-focus.css" },
    })
  end
  return meta
end
