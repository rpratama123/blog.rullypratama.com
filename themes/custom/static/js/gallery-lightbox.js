(function () {
  'use strict';

  var grid = document.getElementById('gallery-grid');
  var dialog = document.getElementById('gallery-lightbox');
  if (!grid || !dialog) return;

  var lbImg = document.getElementById('lb-img');
  var lbContainer = dialog.querySelector('.lb-image-container');
  var lbCounter = document.getElementById('lb-counter');
  var btnClose = dialog.querySelector('.lb-close');
  var btnPrev = dialog.querySelector('.lb-prev');
  var btnNext = dialog.querySelector('.lb-next');
  var btnZoomIn = dialog.querySelector('.lb-zoom-in');
  var btnZoomOut = dialog.querySelector('.lb-zoom-out');
  var btnZoomReset = dialog.querySelector('.lb-zoom-reset');
  var btnZoomFit = dialog.querySelector('.lb-zoom-fit');
  var btnZoomActual = dialog.querySelector('.lb-zoom-actual');

  var items = Array.from(grid.querySelectorAll('.gallery-item'));
  var current = 0;

  // Zoom state
  var scale = 1;
  var translateX = 0;
  var translateY = 0;
  var isDragging = false;
  var startX = 0;
  var startY = 0;
  var initialTranslateX = 0;
  var initialTranslateY = 0;

  function updateTransform() {
    lbImg.style.transform = 'translate(' + translateX + 'px, ' + translateY + 'px) scale(' + scale + ')';
  }

  function resetZoom() {
    scale = 1;
    translateX = 0;
    translateY = 0;
    updateTransform();
  }

  function zoomIn() {
    scale = Math.min(scale * 1.25, 5);
    updateTransform();
  }

  function zoomOut() {
    scale = Math.max(scale / 1.25, 0.5);
    if (scale <= 1) {
      resetZoom();
    } else {
      updateTransform();
    }
  }

  function zoomFit() {
    resetZoom();
  }

  function zoomActual() {
    // Wait for image to load if needed
    if (!lbImg.naturalWidth) {
      lbImg.onload = function() {
        calculateActualSize();
      };
      return;
    }
    calculateActualSize();
  }

  function calculateActualSize() {
    var naturalWidth = lbImg.naturalWidth;
    var containerWidth = lbContainer.clientWidth;
    var containerHeight = lbContainer.clientHeight;
    
    // Calculate the "fit" scale (how much the image is shrunk to fit initially)
    var fitScale = Math.min(containerWidth / naturalWidth, containerHeight / lbImg.naturalHeight, 1);
    
    // To show actual size, we need to counteract the fit scale
    scale = 1 / fitScale;
    translateX = 0;
    translateY = 0;
    updateTransform();
  }

  function show(index) {
    current = (index + items.length) % items.length;
    var item = items[current];
    lbImg.src = item.dataset.full;
    lbImg.alt = item.querySelector('img').alt;
    resetZoom();
    if (lbCounter) lbCounter.innerHTML = '<span class="lb-counter-current">' + (current + 1) + '</span> / ' + items.length;
    if (!dialog.open) dialog.showModal();
  }

  // Store natural dimensions when image loads
  lbImg.addEventListener('load', function() {
    lbImg.dataset.naturalWidth = lbImg.naturalWidth;
    lbImg.dataset.naturalHeight = lbImg.naturalHeight;
  });

  function close() {
    dialog.close();
    lbImg.src = '';
    resetZoom();
  }

  // Open on item click
  items.forEach(function (item) {
    item.addEventListener('click', function () {
      show(parseInt(item.dataset.index, 10));
    });
  });

  // Prev / Next buttons
  btnPrev.addEventListener('click', function (e) {
    e.stopPropagation();
    show(current - 1);
  });

  btnNext.addEventListener('click', function (e) {
    e.stopPropagation();
    show(current + 1);
  });

  // Close button
  btnClose.addEventListener('click', close);

  // Zoom controls
  if (btnZoomIn) btnZoomIn.addEventListener('click', function (e) {
    e.stopPropagation();
    zoomIn();
  });

  if (btnZoomOut) btnZoomOut.addEventListener('click', function (e) {
    e.stopPropagation();
    zoomOut();
  });

  if (btnZoomReset) btnZoomReset.addEventListener('click', function (e) {
    e.stopPropagation();
    resetZoom();
  });

  if (btnZoomFit) btnZoomFit.addEventListener('click', function (e) {
    e.stopPropagation();
    zoomFit();
  });

  if (btnZoomActual) btnZoomActual.addEventListener('click', function (e) {
    e.stopPropagation();
    zoomActual();
  });

  // Mouse wheel zoom
  lbContainer.addEventListener('wheel', function (e) {
    if (!dialog.open) return;
    e.preventDefault();
    if (e.deltaY < 0) {
      zoomIn();
    } else {
      zoomOut();
    }
  }, { passive: false });

  // Pan functionality
  lbContainer.addEventListener('mousedown', function (e) {
    if (!dialog.open || scale <= 1) return;
    e.preventDefault();
    isDragging = true;
    startX = e.clientX;
    startY = e.clientY;
    initialTranslateX = translateX;
    initialTranslateY = translateY;
    lbContainer.classList.add('is-dragging');
  });

  document.addEventListener('mousemove', function (e) {
    if (!isDragging) return;
    e.preventDefault();
    var dx = e.clientX - startX;
    var dy = e.clientY - startY;
    translateX = initialTranslateX + dx;
    translateY = initialTranslateY + dy;
    updateTransform();
  });

  document.addEventListener('mouseup', function () {
    isDragging = false;
    if (lbContainer) lbContainer.classList.remove('is-dragging');
  });

  // Click on backdrop closes dialog (but not when clicking image or controls)
  dialog.addEventListener('click', function (e) {
    if (e.target === dialog || e.target === lbContainer) close();
  });

  // Keyboard navigation
  document.addEventListener('keydown', function (e) {
    if (!dialog.open) return;
    if (e.key === 'ArrowLeft')  { e.preventDefault(); show(current - 1); }
    if (e.key === 'ArrowRight') { e.preventDefault(); show(current + 1); }
    if (e.key === 'Escape')     { close(); }
    if (e.key === '+' || e.key === '=') { e.preventDefault(); zoomIn(); }
    if (e.key === '-') { e.preventDefault(); zoomOut(); }
    if (e.key === '0') { e.preventDefault(); resetZoom(); }
  });
})();
