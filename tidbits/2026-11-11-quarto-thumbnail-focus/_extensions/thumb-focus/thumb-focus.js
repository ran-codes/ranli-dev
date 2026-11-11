// Apply each <img data-focus="x% y% zoom"> crop. On localhost, also make every
// thumbnail editable: drag to move the crop, scroll to zoom, double-click to reset.
(function () {
  const EDITABLE = ["localhost", "127.0.0.1"].includes(location.hostname);
  const MIN_ZOOM = 1;
  const MAX_ZOOM = 4;

  const clamp = (n, lo, hi) => Math.min(hi, Math.max(lo, n));

  function parseFocus(value) {
    const [x, y, zoom] = (value || "").trim().split(/\s+/).map(parseFloat);
    return {
      x: Number.isFinite(x) ? clamp(x, 0, 100) : 50,
      y: Number.isFinite(y) ? clamp(y, 0, 100) : 50,
      zoom: Number.isFinite(zoom) ? clamp(zoom, MIN_ZOOM, MAX_ZOOM) : 1,
    };
  }

  function formatFocus(focus) {
    return `focus: "${Math.round(focus.x)}% ${Math.round(focus.y)}% ${focus.zoom.toFixed(2)}"`;
  }

  function applyFocus(img, focus) {
    img.style.objectPosition = `${focus.x}% ${focus.y}%`;
    img.style.transformOrigin = `${focus.x}% ${focus.y}%`;
    img.style.transform = focus.zoom === 1 ? "" : `scale(${focus.zoom})`;
  }

  // How far the cover-fitted image overhangs its frame, in px per axis. Dragging by
  // that many px moves object-position by 100%.
  function overhang(img, frame) {
    const fw = frame.clientWidth;
    const fh = frame.clientHeight;
    const scale = Math.max(fw / img.naturalWidth, fh / img.naturalHeight);
    return {
      x: img.naturalWidth * scale - fw || fw,
      y: img.naturalHeight * scale - fh || fh,
    };
  }

  function makeEditable(img, focus) {
    const frame = img.parentElement;
    const initial = { ...focus };
    img.draggable = false;

    const readout = document.createElement("div");
    readout.className = "thumb-focus-readout";
    const line = document.createElement("span");
    const copy = document.createElement("button");
    copy.type = "button";
    copy.textContent = "Copy";
    readout.append(line, copy);
    frame.append(readout);

    const update = () => {
      applyFocus(img, focus);
      line.textContent = formatFocus(focus);
    };

    copy.addEventListener("click", (e) => {
      e.stopPropagation();
      navigator.clipboard.writeText(formatFocus(focus)).then(
        () => { copy.textContent = "Copied"; setTimeout(() => (copy.textContent = "Copy"), 1200); },
        () => { copy.textContent = "Failed"; }
      );
    });
    readout.addEventListener("pointerdown", (e) => e.stopPropagation());

    let drag = null;
    frame.addEventListener("pointerdown", (e) => {
      drag = { x: e.clientX, y: e.clientY, start: { ...focus }, reach: overhang(img, frame) };
      frame.setPointerCapture(e.pointerId);
      frame.classList.add("dragging");
    });
    frame.addEventListener("pointermove", (e) => {
      if (!drag) return;
      // Dragging right reveals more of the left side, so x goes down.
      focus.x = clamp(drag.start.x - ((e.clientX - drag.x) / drag.reach.x) * 100, 0, 100);
      focus.y = clamp(drag.start.y - ((e.clientY - drag.y) / drag.reach.y) * 100, 0, 100);
      update();
    });
    const endDrag = () => { drag = null; frame.classList.remove("dragging"); };
    frame.addEventListener("pointerup", endDrag);
    frame.addEventListener("pointercancel", endDrag);

    frame.addEventListener("wheel", (e) => {
      e.preventDefault();
      focus.zoom = clamp(focus.zoom * (1 - e.deltaY * 0.001), MIN_ZOOM, MAX_ZOOM);
      update();
    }, { passive: false });

    frame.addEventListener("dblclick", () => {
      Object.assign(focus, initial);
      update();
    });

    update();
  }

  document.addEventListener("DOMContentLoaded", () => {
    const images = document.querySelectorAll("img[data-focus]");
    if (EDITABLE && images.length) document.body.classList.add("thumb-focus-edit");
    images.forEach((img) => {
      const focus = parseFocus(img.dataset.focus);
      applyFocus(img, focus);
      if (EDITABLE) makeEditable(img, focus);
    });
  });
})();
