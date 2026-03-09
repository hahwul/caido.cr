// Search functionality for caido.cr documentation
let searchIndex = null;
let fuse = null;

function toggleSearch() {
  const overlay = document.getElementById('searchOverlay');
  const input = document.getElementById('searchInput');
  const isActive = overlay.classList.contains('active');

  if (isActive) {
    overlay.classList.remove('active');
    input.value = '';
    document.getElementById('searchResults').innerHTML = '';
  } else {
    overlay.classList.add('active');
    setTimeout(() => input.focus(), 100);
    loadSearchIndex();
  }
}

async function loadSearchIndex() {
  if (searchIndex) return;

  try {
    const response = await fetch('/search.json');
    searchIndex = await response.json();

    // Load Fuse.js from CDN if not already loaded
    if (typeof Fuse === 'undefined') {
      const script = document.createElement('script');
      script.src = 'https://cdn.jsdelivr.net/npm/fuse.js@7.0.0/dist/fuse.min.js';
      script.onload = () => initFuse();
      document.head.appendChild(script);
    } else {
      initFuse();
    }
  } catch (e) {
    console.error('Failed to load search index:', e);
  }
}

function initFuse() {
  fuse = new Fuse(searchIndex, {
    keys: ['title', 'content'],
    threshold: 0.3,
    includeMatches: true,
    minMatchCharLength: 2,
  });
}

document.addEventListener('DOMContentLoaded', () => {
  const input = document.getElementById('searchInput');
  if (input) {
    input.addEventListener('input', (e) => {
      const query = e.target.value.trim();
      if (query.length < 2 || !fuse) {
        document.getElementById('searchResults').innerHTML = '';
        return;
      }

      const results = fuse.search(query).slice(0, 8);
      const resultsEl = document.getElementById('searchResults');

      if (results.length === 0) {
        resultsEl.innerHTML = '<div class="search-result-item"><div class="search-result-title">No results found</div></div>';
        return;
      }

      resultsEl.innerHTML = results.map(r => {
        const item = r.item;
        let snippet = '';
        if (item.content) {
          const idx = item.content.toLowerCase().indexOf(query.toLowerCase());
          if (idx >= 0) {
            const start = Math.max(0, idx - 40);
            const end = Math.min(item.content.length, idx + query.length + 60);
            snippet = (start > 0 ? '...' : '') +
              item.content.slice(start, idx) +
              '<mark>' + item.content.slice(idx, idx + query.length) + '</mark>' +
              item.content.slice(idx + query.length, end) +
              (end < item.content.length ? '...' : '');
          } else {
            snippet = item.content.slice(0, 100) + '...';
          }
        }
        return `<div class="search-result-item"><a href="${item.permalink || item.url || '#'}"><div class="search-result-title">${item.title}</div><div class="search-result-snippet">${snippet}</div></a></div>`;
      }).join('');
    });
  }

  // Cmd+K shortcut
  document.addEventListener('keydown', (e) => {
    if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
      e.preventDefault();
      toggleSearch();
    }
    if (e.key === 'Escape') {
      const overlay = document.getElementById('searchOverlay');
      if (overlay && overlay.classList.contains('active')) {
        toggleSearch();
      }
    }
  });
});
