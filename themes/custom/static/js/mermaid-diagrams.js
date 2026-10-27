// Mermaid diagram renderer.
//
// Loaded lazily via the ```mermaid code block render hook, so it only runs on
// pages that actually contain diagrams. Loads Mermaid from a pinned CDN
// version (same opt-in CDN pattern as KaTeX in head.html) and re-renders all
// diagrams when the site theme flips, since Mermaid has no runtime theme swap.
(function () {
  'use strict';

  // Pins the Mermaid major version (jsdelivr resolves to the latest 11.x).
  // Note: dynamic ESM imports cannot use SRI checks, so the version pin is
  // the only integrity control — do not switch to an unpinned CDN URL.
  var MERMAID_URL = 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';

  var diagrams = Array.prototype.slice.call(document.querySelectorAll('pre.mermaid'));
  if (!diagrams.length) return;

  var mermaid = null;
  var currentTheme = null;
  var pendingRerender = null;

  // Keep the original source before the first render — mermaid.run() replaces
  // the <pre> content with an <svg>, and theme re-renders must start over.
  diagrams.forEach(function (pre) {
    pre.dataset.mermaidSource = pre.textContent;
  });

  function getTheme() {
    var t = document.documentElement.getAttribute('data-theme');
    if (t !== 'dark' && t !== 'light') {
      // data-theme is set synchronously by theme-toggle.js in the <head>,
      // but fall back to OS preference just in case.
      t = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
    }
    return t;
  }

  var renderCount = 0;

  function render(themeName) {
    // Re-entrant guard: serialize renders so overlapping ones can't fight
    // over the same <pre> nodes.
    if (pendingRerender) return pendingRerender;
    currentTheme = themeName;
    mermaid.initialize({
      startOnLoad: false,
      securityLevel: 'strict',
      darkMode: themeName === 'dark',
      theme: themeName === 'dark' ? 'dark' : 'default'
    });

    // We drive rendering manually with mermaid.render() instead of
    // mermaid.run(): run() tags nodes as processed and has unreliable
    // re-render behavior (diagrams degrade to raw code after theme changes).
    // render() is stateless per call — safe to repeat indefinitely.
    var jobs = diagrams.map(function (pre, i) {
      var source = pre.dataset.mermaidSource;
      // Show the raw source if this render fails, so nothing gets lost.
      pre.textContent = source;
      return mermaid
        .render('mermaid-' + renderCount++ + '-' + i, source)
        .then(function (result) {
          pre.innerHTML = result.svg;
        })
        .catch(function (err) {
          console.error('Mermaid render failed (diagram #' + (i + 1) + '):', err);
        });
    });

    pendingRerender = Promise.all(jobs).then(function () {
      pendingRerender = null;
      // If the theme flipped while rendering, catch up on the missed change.
      if (getTheme() !== currentTheme) render(getTheme());
    });
    return pendingRerender;
  }

  import(MERMAID_URL)
    .then(function (module) {
      mermaid = module.default;
      return render(getTheme());
    })
    .catch(function (err) {
      console.error('Failed to load Mermaid from CDN:', err);
    });

  // Re-render diagrams whenever the <html data-theme> attribute changes
  // (theme-toggle.js) — keeps diagrams in sync with the site palette.
  new MutationObserver(function () {
    if (!mermaid) return;
    render(getTheme());
  }).observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['data-theme']
  });
})();
