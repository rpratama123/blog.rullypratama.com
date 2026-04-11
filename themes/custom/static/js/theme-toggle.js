(function() {
  const STORAGE_KEY = 'rp-theme';
  const toggle = document.getElementById('themeToggle');
  const html = document.documentElement;

  // Determine the initial theme: saved preference → system preference → light
  function getPreferred() {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved === 'dark' || saved === 'light') return saved;
    // Auto: follow OS preference
    return window.matchMedia('(prefers-color-scheme: dark)').matches
      ? 'dark'
      : 'light';
  }

  function applyTheme(theme) {
    html.setAttribute('data-theme', theme);
    if (toggle) {
      toggle.setAttribute('aria-checked', theme === 'dark');
    }
  }

  // Initialise
  applyTheme(getPreferred());

  // Setup listener after DOM is ready
  document.addEventListener('DOMContentLoaded', () => {
    const btn = document.getElementById('themeToggle');
    if (!btn) return;

    btn.addEventListener('click', () => {
      const current = html.getAttribute('data-theme');
      const next = current === 'dark' ? 'light' : 'dark';
      applyTheme(next);
      localStorage.setItem(STORAGE_KEY, next);
    });

    // Sync button state
    applyTheme(getPreferred());
  });

  // Listen for OS-level changes (only if user hasn't manually toggled)
  window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
    if (!localStorage.getItem(STORAGE_KEY)) {
      applyTheme(e.matches ? 'dark' : 'light');
    }
  });
})();
