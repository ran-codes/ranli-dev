-- Add a page's `topics:` front matter to the title block's meta row, as a column
-- between Author and Published, matching Quarto's own heading/contents markup.
-- The column is emitted into the body and moved into place by a small script,
-- because Pandoc filters cannot reach the title block. No-op without topics.
function Pandoc(doc)
  local topics = doc.meta.topics
  if not topics or FORMAT ~= "html" then return doc end
  local links = {}
  for _, t in ipairs(topics) do
    local slug = pandoc.utils.stringify(t)
    table.insert(links, string.format('<a href="/topics/%s/">%s</a>', slug, slug))
  end
  local html = string.format([[
<div class="quarto-title-meta-topics" hidden>
  <div>
    <div class="quarto-title-meta-heading">Topics</div>
    <div class="quarto-title-meta-contents"><p>%s</p></div>
  </div>
</div>
<script>
document.addEventListener("DOMContentLoaded", function () {
  var meta = document.querySelector(".quarto-title-meta");
  var wrap = document.querySelector(".quarto-title-meta-topics");
  if (!meta || !wrap) return;
  var col = wrap.firstElementChild;
  meta.appendChild(col);
  meta.classList.add("has-topics");
  wrap.remove();
});
</script>]], table.concat(links, ", "))
  doc.blocks:insert(1, pandoc.RawBlock("html", html))
  return doc
end
