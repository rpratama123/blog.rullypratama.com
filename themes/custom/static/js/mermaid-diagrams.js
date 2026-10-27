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

  function render(themeName) {
    currentTheme = themeName;
    mermaid.initialize({
      startOnLoad: false,
      securityLevel: 'strict',
      darkMode: themeName === 'dark',
      theme: themeName === 'dark' ? 'dark' : 'default'
    });
    // Restore source text that a previous render may have replaced.
    diagrams.forEach(function (pre) {
      pre.textContent = pre.dataset.mermaidSource;
    });
    return mermaid
      .run({ nodes: diagrams, suppressErrors: true })
      .catch(function (err) {
        console.error('Mermaid render failed:', err);
      });
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
    if (!mermaid || pendingRerender) return;
    var next = getTheme();
    if (next === currentTheme) return;
    pendingRerender = render(next).then(function () {
      pendingRerender = null;
    });
  }).observe(document.documentElement, {
    attributes: true,
    attributeFilter: ['data-theme']
  });
})();
