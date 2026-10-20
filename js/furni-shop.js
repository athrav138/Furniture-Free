/**
 * Furni E-Commerce Engine
 * Complete shopping cart, checkout, newsletter, and user interaction system.
 */

(function () {
  'use strict';

  // Default Catalog
  const PRODUCTS = [
    { id: 'furni-1', name: 'Nordic Chair', price: 50.00, category: 'chairs', image: 'images/product-1.png', rating: 4.8 },
    { id: 'furni-2', name: 'Kruzo Aero Chair', price: 78.00, category: 'chairs', image: 'images/product-2.png', rating: 4.9 },
    { id: 'furni-3', name: 'Ergonomic Chair', price: 43.00, category: 'chairs', image: 'images/product-3.png', rating: 4.7 },
    { id: 'furni-4', name: 'Modern Studio Couch', price: 290.00, category: 'sofas', image: 'images/sofa.png', rating: 5.0 },
    { id: 'furni-5', name: 'Minimalist Wooden Chair', price: 55.00, category: 'chairs', image: 'images/product-1.png', rating: 4.6 },
    { id: 'furni-6', name: 'Comfort Lounge Chair', price: 82.00, category: 'chairs', image: 'images/product-2.png', rating: 4.8 },
    { id: 'furni-7', name: 'Executive Velvet Chair', price: 68.00, category: 'chairs', image: 'images/product-3.png', rating: 4.9 },
    { id: 'furni-8', name: 'Contemporary Sofa', price: 340.00, category: 'sofas', image: 'images/sofa.png', rating: 4.9 }
  ];

  // Cart Storage Utilities
  const Furni = {
    getCart: function () {
      try {
        const cart = localStorage.getItem('furni_cart');
        return cart ? JSON.parse(cart) : [];
      } catch (e) {
        return [];
      }
    },

    saveCart: function (cart) {
      localStorage.setItem('furni_cart', JSON.stringify(cart));
      Furni.updateBadge();
    },

    getCoupon: function () {
      try {
        const coupon = localStorage.getItem('furni_coupon');
        return coupon ? JSON.parse(coupon) : null;
      } catch (e) {
        return null;
      }
    },

    saveCoupon: function (coupon) {
      if (coupon) {
        localStorage.setItem('furni_coupon', JSON.stringify(coupon));
      } else {
        localStorage.removeItem('furni_coupon');
      }
    },

    addToCart: function (product, qty) {
      qty = parseInt(qty, 10) || 1;
      let cart = Furni.getCart();
      const existingIndex = cart.findIndex(item => item.id === product.id || item.name.toLowerCase() === product.name.toLowerCase());

      if (existingIndex > -1) {
        cart[existingIndex].quantity += qty;
      } else {
        cart.push({
          id: product.id || 'furni-' + Date.now(),
          name: product.name,
          price: parseFloat(product.price),
          image: product.image || 'images/product-1.png',
          quantity: qty
        });
      }

      Furni.saveCart(cart);
      Furni.showToast(`<strong>${product.name}</strong> added to your cart!`, 'success');
      Furni.animateCartIcon();
    },

    removeFromCart: function (id) {
      let cart = Furni.getCart();
      const removed = cart.find(item => item.id === id);
      cart = cart.filter(item => item.id !== id);
      Furni.saveCart(cart);
      if (removed) {
        Furni.showToast(`Removed <strong>${removed.name}</strong> from cart.`, 'info');
      }
    },

    updateQuantity: function (id, qty) {
      qty = parseInt(qty, 10);
      if (isNaN(qty) || qty < 1) qty = 1;

      let cart = Furni.getCart();
      const item = cart.find(i => i.id === id);
      if (item) {
        item.quantity = qty;
        Furni.saveCart(cart);
      }
    },

    clearCart: function () {
      localStorage.removeItem('furni_cart');
      localStorage.removeItem('furni_coupon');
      Furni.updateBadge();
    },

    getCartSummary: function () {
      const cart = Furni.getCart();
      const coupon = Furni.getCoupon();

      const subtotal = cart.reduce((sum, item) => sum + (item.price * item.quantity), 0);
      const itemCount = cart.reduce((sum, item) => sum + item.quantity, 0);

      // Shipping is free over $100, otherwise $15 flat
      const shipping = subtotal > 0 ? (subtotal >= 100 ? 0 : 15) : 0;

      let discount = 0;
      if (coupon && subtotal > 0) {
        if (coupon.type === 'percent') {
          discount = (subtotal * coupon.value) / 100;
        } else if (coupon.type === 'fixed') {
          discount = Math.min(coupon.value, subtotal);
        }
      }

      const total = Math.max(0, subtotal - discount + shipping);

      return {
        items: cart,
        itemCount: itemCount,
        subtotal: subtotal,
        shipping: shipping,
        discount: discount,
        coupon: coupon,
        total: total
      };
    },

    updateBadge: function () {
      const summary = Furni.getCartSummary();
      const badges = document.querySelectorAll('.cart-badge');
      badges.forEach(badge => {
        badge.textContent = summary.itemCount;
        badge.style.display = summary.itemCount > 0 ? 'inline-block' : 'none';
      });
    },

    animateCartIcon: function () {
      const cartLinks = document.querySelectorAll('a[href*="cart.html"]');
      cartLinks.forEach(link => {
        link.classList.add('cart-bounce');
        setTimeout(() => link.classList.remove('cart-bounce'), 600);
      });
    },

    showToast: function (message, type) {
      let container = document.getElementById('furni-toast-container');
      if (!container) {
        container = document.createElement('div');
        container.id = 'furni-toast-container';
        container.className = 'toast-container position-fixed bottom-0 end-0 p-3';
        container.style.zIndex = '9999';
        document.body.appendChild(container);
      }

      const toastId = 'toast-' + Date.now();
      const bgClass = type === 'success' ? 'text-bg-success' : type === 'info' ? 'text-bg-dark' : 'text-bg-warning';
      const icon = type === 'success' ? 'fa-check-circle' : type === 'info' ? 'fa-info-circle' : 'fa-exclamation-triangle';

      const toastEl = document.createElement('div');
      toastEl.id = toastId;
      toastEl.className = `toast align-items-center ${bgClass} border-0 shadow-lg mb-2`;
      toastEl.setAttribute('role', 'alert');
      toastEl.setAttribute('aria-live', 'assertive');
      toastEl.setAttribute('aria-atomic', 'true');
      toastEl.innerHTML = `
        <div class="d-flex">
          <div class="toast-body d-flex align-items-center">
            <i class="fas ${icon} me-2 fs-5"></i>
            <div>${message}</div>
          </div>
          <button type="button" class="btn-close btn-close-white me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
      `;

      container.appendChild(toastEl);
      if (window.bootstrap && window.bootstrap.Toast) {
        const bsToast = new window.bootstrap.Toast(toastEl, { delay: 3500 });
        bsToast.show();
        toastEl.addEventListener('hidden.bs.toast', () => toastEl.remove());
      } else {
        toastEl.style.display = 'block';
        setTimeout(() => toastEl.remove(), 3500);
      }
    }
  };

  // Expose global API
  window.Furni = Furni;
  window.FurniProducts = PRODUCTS;

  // Initialize Page-Specific Logic on DOM Ready
  document.addEventListener('DOMContentLoaded', function () {
    // Graceful fallback for any missing images
    document.addEventListener('error', function (e) {
      if (e.target && e.target.tagName === 'IMG') {
        const src = e.target.getAttribute('src') || '';
        if (src.includes('couch.png')) {
          e.target.src = 'images/sofa.png';
        } else if (!src.includes('product-1.png')) {
          e.target.src = 'images/product-1.png';
        }
      }
    }, true);

    // Inject cart badges into all cart nav links if not present
    setupNavbarCart();

    // Setup interactive user icon modal
    setupUserModal();

    // Setup product buttons on Home & Shop
    setupProductClicks();

    // Setup newsletter forms
    setupNewsletterForms();

    // Check specific pages
    if (window.location.pathname.endsWith('cart.html') || document.querySelector('.site-blocks-table')) {
      initCartPage();
    } else if (window.location.pathname.endsWith('checkout.html') || document.querySelector('.site-block-order-table')) {
      initCheckoutPage();
    } else if (window.location.pathname.endsWith('thankyou.html') || document.querySelector('.thankyou-icon')) {
      initThankyouPage();
    } else if (window.location.pathname.endsWith('contact.html') || document.querySelector('form button[type="submit"]')) {
      initContactPage();
    }

    Furni.updateBadge();
  });

  // Setup navbar cart badge and wrapper
  function setupNavbarCart() {
    const cartLinks = document.querySelectorAll('.custom-navbar-cta a[href*="cart.html"]');
    cartLinks.forEach(link => {
      link.classList.add('position-relative');
      if (!link.querySelector('.cart-badge')) {
        const badge = document.createElement('span');
        badge.className = 'cart-badge badge rounded-pill bg-warning text-dark position-absolute top-0 start-100 translate-middle';
        badge.style.fontSize = '0.7rem';
        badge.style.padding = '0.35em 0.55em';
        badge.style.display = 'none';
        link.appendChild(badge);
      }
    });
  }

  // Setup user account modal / quick popup
  function setupUserModal() {
    const userLinks = document.querySelectorAll('.custom-navbar-cta a[href="#"], .custom-navbar-cta a:not([href*="cart.html"])');
    userLinks.forEach(link => {
      if (link.querySelector('img[src*="user"]')) {
        link.setAttribute('href', 'javascript:void(0)');
        link.addEventListener('click', function (e) {
          e.preventDefault();
          showUserModal();
        });
      }
    });
  }

  function showUserModal() {
    let modal = document.getElementById('furniUserModal');
    if (!modal) {
      modal = document.createElement('div');
      modal.id = 'furniUserModal';
      modal.className = 'modal fade';
      modal.setAttribute('tabindex', '-1');
      modal.setAttribute('aria-hidden', 'true');
      modal.innerHTML = `
        <div class="modal-dialog modal-dialog-centered">
          <div class="modal-content border-0 shadow">
            <div class="modal-header bg-dark text-white border-0">
              <h5 class="modal-title"><i class="fas fa-user-circle me-2"></i>My Furni Account</h5>
              <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body p-4">
              <div class="text-center mb-4">
                <div class="bg-light rounded-circle d-inline-flex p-3 mb-2 text-primary">
                  <i class="fas fa-user fs-1"></i>
                </div>
                <h5 class="mb-1" id="modalUserName">Welcome, Guest!</h5>
                <p class="text-muted small">Sign in to manage your orders, wishlist, and shipping addresses.</p>
              </div>
              <form id="furniLoginForm" onsubmit="event.preventDefault(); window.FurniLoginSubmit();">
                <div class="mb-3">
                  <label class="form-label small fw-bold">Email Address</label>
                  <input type="email" id="userEmailInput" class="form-control" placeholder="user@example.com" required>
                </div>
                <div class="mb-3">
                  <label class="form-label small fw-bold">Password</label>
                  <input type="password" id="userPassInput" class="form-control" placeholder="••••••••" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 fw-bold mb-3">Sign In</button>
              </form>
              <div class="d-flex justify-content-between small text-muted">
                <a href="shop.html" class="text-decoration-none text-muted">Browse Catalog</a>
                <a href="cart.html" class="text-decoration-none text-primary fw-bold">View My Cart</a>
              </div>
            </div>
          </div>
        </div>
      `;
      document.body.appendChild(modal);

      window.FurniLoginSubmit = function () {
        const email = document.getElementById('userEmailInput').value;
        const name = email.split('@')[0];
        localStorage.setItem('furni_user', JSON.stringify({ email: email, name: name }));
        const bsModal = window.bootstrap.Modal.getInstance(modal);
        if (bsModal) bsModal.hide();
        Furni.showToast(`Welcome back, <strong>${name}</strong>!`, 'success');
      };
    }

    if (window.bootstrap && window.bootstrap.Modal) {
      const bsModal = new window.bootstrap.Modal(modal);
      bsModal.show();
    }
  }

  // Setup product "Add to Cart" and item cards
  function setupProductClicks() {
    // If cart is empty on first visit ever, pre-populate 2 sample items so the cart looks lively immediately
    if (!localStorage.getItem('furni_visited')) {
      localStorage.setItem('furni_visited', 'true');
      if (Furni.getCart().length === 0) {
        Furni.saveCart([
          { id: 'furni-1', name: 'Nordic Chair', price: 50.00, image: 'images/product-1.png', quantity: 1 },
          { id: 'furni-2', name: 'Kruzo Aero Chair', price: 78.00, image: 'images/product-2.png', quantity: 1 }
        ]);
      }
    }

    const productItems = document.querySelectorAll('.product-item');
    productItems.forEach((item, index) => {
      // Find cross icon
      const cross = item.querySelector('.icon-cross');
      const titleEl = item.querySelector('.product-title');
      const priceEl = item.querySelector('.product-price');
      const imgEl = item.querySelector('.product-thumbnail');

      const name = titleEl ? titleEl.textContent.trim() : 'Furniture Item';
      let price = 50.00;
      if (priceEl) {
        const priceClean = priceEl.textContent.replace(/[^0-9.]/g, '');
        price = parseFloat(priceClean) || 50.00;
      }
      const image = imgEl ? imgEl.getAttribute('src') : 'images/product-1.png';
      const id = 'furni-' + (index + 1);

      if (cross) {
        cross.style.cursor = 'pointer';
        cross.addEventListener('click', function (e) {
          e.preventDefault();
          e.stopPropagation();
          Furni.addToCart({ id: id, name: name, price: price, image: image }, 1);
        });
      }

      // Clicking the card itself
      item.addEventListener('click', function (e) {
        if (!e.target.closest('.icon-cross')) {
          e.preventDefault();
          Furni.addToCart({ id: id, name: name, price: price, image: image }, 1);
        }
      });
    });
  }

  // Newsletter subscription
  function setupNewsletterForms() {
    const forms = document.querySelectorAll('.subscription-form form');
    forms.forEach(form => {
      form.addEventListener('submit', function (e) {
        e.preventDefault();
        const emailInput = form.querySelector('input[type="email"]');
        const nameInput = form.querySelector('input[type="text"]');
        const email = emailInput ? emailInput.value.trim() : '';

        if (!email || !email.includes('@')) {
          Furni.showToast('Please enter a valid email address.', 'warning');
          return;
        }

        const name = nameInput && nameInput.value.trim() ? nameInput.value.trim() : 'Valued Customer';
        form.reset();
        Furni.showToast(`Thank you, <strong>${name}</strong>! You are now subscribed to Furni newsletters.`, 'success');
      });
    });
  }

  // CART PAGE LOGIC
  function initCartPage() {
    const tableBody = document.querySelector('.site-blocks-table tbody');
    if (!tableBody) return;

    function renderCartTable() {
      const summary = Furni.getCartSummary();
      const cart = summary.items;

      if (cart.length === 0) {
        tableBody.innerHTML = `
          <tr>
            <td colspan="6" class="py-5 text-center">
              <div class="empty-cart-wrap py-4">
                <i class="fas fa-shopping-basket fa-4x text-muted mb-3 d-block"></i>
                <h4 class="text-black mb-2">Your Shopping Cart is Empty</h4>
                <p class="text-muted mb-4">Discover our handcrafted, modern furniture collection to furnish your home.</p>
                <a href="shop.html" class="btn btn-primary px-4 py-2">Explore Shop</a>
              </div>
            </td>
          </tr>
        `;
        updateCartTotals(summary);
        return;
      }

      tableBody.innerHTML = '';
      cart.forEach(item => {
        const itemTotal = (item.price * item.quantity).toFixed(2);
        const tr = document.createElement('tr');
        tr.dataset.id = item.id;
        tr.innerHTML = `
          <td class="product-thumbnail">
            <img src="${item.image}" alt="${item.name}" class="img-fluid rounded" style="max-height: 85px;">
          </td>
          <td class="product-name">
            <h2 class="h5 text-black mb-0">${item.name}</h2>
          </td>
          <td class="product-price fw-bold">$${item.price.toFixed(2)}</td>
          <td>
            <div class="input-group mb-0 d-flex align-items-center justify-content-center quantity-container" style="max-width: 120px; margin: 0 auto;">
              <div class="input-group-prepend">
                <button class="btn btn-outline-black btn-decrease px-2" type="button">&minus;</button>
              </div>
              <input type="number" min="1" class="form-control text-center quantity-amount px-1" value="${item.quantity}" style="width: 50px;">
              <div class="input-group-append">
                <button class="btn btn-outline-black btn-increase px-2" type="button">&plus;</button>
              </div>
            </div>
          </td>
          <td class="line-total fw-bold text-primary">$${itemTotal}</td>
          <td><button class="btn btn-black btn-sm btn-remove" title="Remove Item"><i class="fas fa-times"></i></button></td>
        `;

        // Event listeners
        const decBtn = tr.querySelector('.btn-decrease');
        const incBtn = tr.querySelector('.btn-increase');
        const qtyInput = tr.querySelector('.quantity-amount');
        const removeBtn = tr.querySelector('.btn-remove');

        decBtn.addEventListener('click', function () {
          let q = parseInt(qtyInput.value, 10) || 1;
          if (q > 1) {
            q--;
            qtyInput.value = q;
            Furni.updateQuantity(item.id, q);
            renderCartTable();
          }
        });

        incBtn.addEventListener('click', function () {
          let q = parseInt(qtyInput.value, 10) || 1;
          q++;
          qtyInput.value = q;
          Furni.updateQuantity(item.id, q);
          renderCartTable();
        });

        qtyInput.addEventListener('change', function () {
          let q = parseInt(qtyInput.value, 10);
          if (isNaN(q) || q < 1) q = 1;
          qtyInput.value = q;
          Furni.updateQuantity(item.id, q);
          renderCartTable();
        });

        removeBtn.addEventListener('click', function (e) {
          e.preventDefault();
          Furni.removeFromCart(item.id);
          renderCartTable();
        });

        tableBody.appendChild(tr);
      });

      updateCartTotals(summary);
    }

    function updateCartTotals(summary) {
      const subtotalEls = document.querySelectorAll('.cart-subtotal-val');
      const discountRow = document.getElementById('cart-discount-row');
      const discountEl = document.getElementById('cart-discount-val');
      const shippingEl = document.getElementById('cart-shipping-val');
      const totalEls = document.querySelectorAll('.cart-total-val');

      subtotalEls.forEach(el => el.textContent = `$${summary.subtotal.toFixed(2)}`);

      if (discountRow && discountEl) {
        if (summary.discount > 0) {
          discountRow.style.display = 'flex';
          discountEl.textContent = `-$${summary.discount.toFixed(2)}`;
        } else {
          discountRow.style.display = 'none';
        }
      }

      if (shippingEl) {
        shippingEl.textContent = summary.shipping === 0 ? 'FREE' : `$${summary.shipping.toFixed(2)}`;
      }

      totalEls.forEach(el => el.textContent = `$${summary.total.toFixed(2)}`);

      // Disable checkout button if empty
      const checkoutBtn = document.querySelector('button[onclick*="checkout.html"], .btn-checkout');
      if (checkoutBtn) {
        if (summary.items.length === 0) {
          checkoutBtn.setAttribute('disabled', 'disabled');
          checkoutBtn.classList.add('disabled');
        } else {
          checkoutBtn.removeAttribute('disabled');
          checkoutBtn.classList.remove('disabled');
        }
      }
    }

    // Coupon Handler
    const couponInput = document.getElementById('coupon');
    const couponBtn = couponInput ? couponInput.closest('.row').querySelector('button') : null;
    if (couponBtn && couponInput) {
      couponBtn.addEventListener('click', function (e) {
        e.preventDefault();
        const code = couponInput.value.trim().toUpperCase();
        if (!code) {
          Furni.showToast('Please enter a coupon code.', 'warning');
          return;
        }

        if (code === 'FURNI10' || code === 'SAVE10') {
          Furni.saveCoupon({ code: code, type: 'percent', value: 10, label: '10% OFF' });
          Furni.showToast('Promo code <strong>FURNI10</strong> applied! You saved 10%.', 'success');
          renderCartTable();
        } else if (code === 'WELCOME20' || code === 'FURNI20') {
          Furni.saveCoupon({ code: code, type: 'percent', value: 20, label: '20% OFF' });
          Furni.showToast('Promo code <strong>WELCOME20</strong> applied! You saved 20%.', 'success');
          renderCartTable();
        } else if (code === 'FREESHIP') {
          Furni.saveCoupon({ code: code, type: 'fixed', value: 15, label: 'Free Shipping' });
          Furni.showToast('Promo code <strong>FREESHIP</strong> applied!', 'success');
          renderCartTable();
        } else {
          Furni.showToast('Invalid coupon code. Try <strong>FURNI10</strong> or <strong>WELCOME20</strong>', 'warning');
        }
      });
    }

    // Update Cart button
    const updateCartBtn = document.querySelector('.btn-update-cart, button:contains("Update Cart")');
    const allButtons = document.querySelectorAll('button');
    allButtons.forEach(btn => {
      if (btn.textContent.trim().toLowerCase() === 'update cart') {
        btn.addEventListener('click', function (e) {
          e.preventDefault();
          renderCartTable();
          Furni.showToast('Shopping cart updated successfully!', 'success');
        });
      } else if (btn.textContent.trim().toLowerCase() === 'continue shopping') {
        btn.addEventListener('click', function (e) {
          e.preventDefault();
          window.location.href = 'shop.html';
        });
      }
    });

    renderCartTable();
  }

  // CHECKOUT PAGE LOGIC
  function initCheckoutPage() {
    const summary = Furni.getCartSummary();
    const orderTableBody = document.querySelector('.site-block-order-table tbody');

    if (!orderTableBody) return;

    function renderOrderSummary() {
      const summary = Furni.getCartSummary();
      const cart = summary.items;

      if (cart.length === 0) {
        orderTableBody.innerHTML = `
          <tr>
            <td colspan="2" class="text-center py-4">
              <p class="text-muted mb-2">No items in your cart.</p>
              <a href="shop.html" class="btn btn-sm btn-primary">Return to Shop</a>
            </td>
          </tr>
        `;
        return;
      }

      let rowsHtml = '';
      cart.forEach(item => {
        const itemTotal = (item.price * item.quantity).toFixed(2);
        rowsHtml += `
          <tr>
            <td>${item.name} <strong class="mx-2">x</strong> ${item.quantity}</td>
            <td class="text-end fw-semibold">$${itemTotal}</td>
          </tr>
        `;
      });

      rowsHtml += `
        <tr class="border-top">
          <td class="text-black font-weight-bold"><strong>Subtotal</strong></td>
          <td class="text-end text-black fw-bold">$${summary.subtotal.toFixed(2)}</td>
        </tr>
      `;

      if (summary.discount > 0) {
        rowsHtml += `
          <tr class="text-success">
            <td><strong>Discount (${summary.coupon ? summary.coupon.label : 'Promo'})</strong></td>
            <td class="text-end fw-bold">-$${summary.discount.toFixed(2)}</td>
          </tr>
        `;
      }

      rowsHtml += `
        <tr>
          <td class="text-black"><strong>Shipping</strong></td>
          <td class="text-end text-black">${summary.shipping === 0 ? '<span class="badge bg-success">FREE</span>' : '$' + summary.shipping.toFixed(2)}</td>
        </tr>
        <tr class="border-top fs-5">
          <td class="text-black font-weight-bold"><strong>Order Total</strong></td>
          <td class="text-end text-primary font-weight-bold fw-bold"><strong>$${summary.total.toFixed(2)}</strong></td>
        </tr>
      `;

      orderTableBody.innerHTML = rowsHtml;
    }

    renderOrderSummary();

    // Coupon code on checkout
    const couponInput = document.getElementById('c_code');
    const couponBtn = document.getElementById('button-addon2');
    if (couponBtn && couponInput) {
      couponBtn.addEventListener('click', function (e) {
        e.preventDefault();
        const code = couponInput.value.trim().toUpperCase();
        if (code === 'FURNI10' || code === 'SAVE10') {
          Furni.saveCoupon({ code: code, type: 'percent', value: 10, label: '10% OFF' });
          Furni.showToast('10% discount applied to your order!', 'success');
          renderOrderSummary();
        } else if (code === 'WELCOME20' || code === 'FURNI20') {
          Furni.saveCoupon({ code: code, type: 'percent', value: 20, label: '20% OFF' });
          Furni.showToast('20% discount applied to your order!', 'success');
          renderOrderSummary();
        } else {
          Furni.showToast('Invalid coupon. Try <strong>FURNI10</strong> or <strong>WELCOME20</strong>', 'warning');
        }
      });
    }

    // Place Order Button Handler
    const placeOrderBtn = document.querySelector('button[onclick*="thankyou.html"], .btn-place-order');
    if (placeOrderBtn) {
      placeOrderBtn.removeAttribute('onclick');
      placeOrderBtn.addEventListener('click', function (e) {
        e.preventDefault();

        const currentSummary = Furni.getCartSummary();
        if (currentSummary.items.length === 0) {
          Furni.showToast('Your cart is empty! Add products before placing an order.', 'warning');
          return;
        }

        // Validate required fields
        const fname = document.getElementById('c_fname') ? document.getElementById('c_fname').value.trim() : '';
        const lname = document.getElementById('c_lname') ? document.getElementById('c_lname').value.trim() : '';
        const address = document.getElementById('c_address') ? document.getElementById('c_address').value.trim() : '';
        const email = document.getElementById('c_email_address') ? document.getElementById('c_email_address').value.trim() : '';
        const phone = document.getElementById('c_phone') ? document.getElementById('c_phone').value.trim() : '';

        if (!fname || !lname || !address || !email || !phone) {
          Furni.showToast('Please fill in all required billing fields marked with *', 'warning');
          return;
        }

        // Determine payment method
        let paymentMethod = 'Direct Bank Transfer';
        const openCollapse = document.querySelector('.collapse.show');
        if (openCollapse) {
          if (openCollapse.id === 'collapsecheque') paymentMethod = 'Cheque Payment';
          else if (openCollapse.id === 'collapsepaypal') paymentMethod = 'PayPal';
        }

        // Build Order Record
        const orderId = 'FUR-' + Math.floor(100000 + Math.random() * 900000);
        const orderRecord = {
          orderId: orderId,
          date: new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'short', day: 'numeric' }),
          customer: {
            name: `${fname} ${lname}`,
            email: email,
            phone: phone,
            address: address,
            notes: document.getElementById('c_order_notes') ? document.getElementById('c_order_notes').value.trim() : ''
          },
          paymentMethod: paymentMethod,
          items: currentSummary.items,
          subtotal: currentSummary.subtotal,
          discount: currentSummary.discount,
          shipping: currentSummary.shipping,
          total: currentSummary.total
        };

        localStorage.setItem('furni_last_order', JSON.stringify(orderRecord));
        Furni.clearCart();

        // Redirect to confirmation page
        window.location.href = 'thankyou.html';
      });
    }
  }

  // THANK YOU PAGE LOGIC
  function initThankyouPage() {
    const rawOrder = localStorage.getItem('furni_last_order');
    if (!rawOrder) return;

    try {
      const order = JSON.parse(rawOrder);
      const container = document.querySelector('.thankyou-icon') ? document.querySelector('.thankyou-icon').closest('.container') : null;
      if (!container) return;

      const orderCard = document.createElement('div');
      orderCard.className = 'row justify-content-center mt-4';
      orderCard.innerHTML = `
        <div class="col-lg-8">
          <div class="card border-0 shadow-sm rounded-4 p-4 p-md-5 bg-white text-start">
            <div class="d-flex justify-content-between align-items-center border-bottom pb-3 mb-4">
              <div>
                <span class="badge bg-success-subtle text-success px-3 py-2 rounded-pill fw-semibold">Order Confirmed</span>
                <h4 class="mt-2 mb-0 fw-bold">Order #${order.orderId}</h4>
              </div>
              <div class="text-end text-muted small">
                <div>Date: ${order.date}</div>
                <div>Payment: <strong>${order.paymentMethod}</strong></div>
              </div>
            </div>

            <div class="row mb-4">
              <div class="col-sm-6 mb-3 mb-sm-0">
                <h6 class="text-uppercase text-muted fw-bold small">Delivering To</h6>
                <p class="mb-0 fw-semibold text-black">${order.customer.name}</p>
                <p class="mb-0 text-muted">${order.customer.address}</p>
                <p class="mb-0 text-muted">${order.customer.phone} | ${order.customer.email}</p>
              </div>
              <div class="col-sm-6 text-sm-end">
                <h6 class="text-uppercase text-muted fw-bold small">Payment Status</h6>
                <span class="badge bg-primary text-white px-3 py-1">Authorized</span>
                <p class="mt-2 mb-0 text-muted small">Tracking updates will be sent to your email.</p>
              </div>
            </div>

            <h6 class="text-uppercase text-muted fw-bold small mb-3">Order Items</h6>
            <div class="table-responsive mb-3">
              <table class="table align-middle">
                <tbody>
                  ${order.items.map(item => `
                    <tr>
                      <td style="width: 60px;">
                        <img src="${item.image}" alt="${item.name}" class="rounded" style="width: 50px; height: 50px; object-fit: cover;">
                      </td>
                      <td>
                        <span class="fw-semibold text-black">${item.name}</span>
                        <div class="text-muted small">$${item.price.toFixed(2)} each</div>
                      </td>
                      <td class="text-center text-muted">x ${item.quantity}</td>
                      <td class="text-end fw-bold text-black">$${(item.price * item.quantity).toFixed(2)}</td>
                    </tr>
                  `).join('')}
                </tbody>
              </table>
            </div>

            <div class="border-top pt-3">
              <div class="d-flex justify-content-between mb-1">
                <span class="text-muted">Subtotal:</span>
                <span class="fw-semibold">$${order.subtotal.toFixed(2)}</span>
              </div>
              ${order.discount > 0 ? `
              <div class="d-flex justify-content-between mb-1 text-success">
                <span>Discount Applied:</span>
                <span class="fw-bold">-$${order.discount.toFixed(2)}</span>
              </div>` : ''}
              <div class="d-flex justify-content-between mb-2">
                <span class="text-muted">Shipping:</span>
                <span class="fw-semibold">${order.shipping === 0 ? 'FREE' : '$' + order.shipping.toFixed(2)}</span>
              </div>
              <div class="d-flex justify-content-between fs-4 fw-bold border-top pt-2 text-primary">
                <span>Total Paid:</span>
                <span>$${order.total.toFixed(2)}</span>
              </div>
            </div>

            <div class="d-flex justify-content-center gap-3 mt-4 pt-2">
              <button class="btn btn-outline-dark px-4 py-2" onclick="window.print();"><i class="fas fa-print me-2"></i>Print Receipt</button>
              <a href="shop.html" class="btn btn-primary px-4 py-2"><i class="fas fa-arrow-left me-2"></i>Continue Shopping</a>
            </div>
          </div>
        </div>
      `;

      container.appendChild(orderCard);
    } catch (e) {
      console.error(e);
    }
  }

  // CONTACT PAGE LOGIC
  function initContactPage() {
    const contactForm = document.querySelector('form button[type="submit"]')?.closest('form');
    if (!contactForm) return;

    contactForm.addEventListener('submit', function (e) {
      e.preventDefault();
      const fname = document.getElementById('fname') ? document.getElementById('fname').value.trim() : '';
      const lname = document.getElementById('lname') ? document.getElementById('lname').value.trim() : '';
      const email = document.getElementById('email') ? document.getElementById('email').value.trim() : '';
      const message = document.getElementById('message') ? document.getElementById('message').value.trim() : '';

      if (!fname || !email || !message) {
        Furni.showToast('Please fill in your name, email, and message.', 'warning');
        return;
      }

      contactForm.reset();
      Furni.showToast(`Thank you, <strong>${fname}</strong>! Your inquiry has been sent. We'll reply within 24 hours.`, 'success');
    });
  }

})();
