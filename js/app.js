/* ============================================================
   WHOLESALE SHOP MANAGEMENT SYSTEM - app.js
   Description: Handles UI interactions, mock data, CRUD logic
   Note: In a real project, these functions would call a PHP/Node
         backend which talks to MySQL. Here we simulate with JS.
   ============================================================ */

'use strict';

// ============================================================
//  MOCK DATA STORE (simulates MySQL database rows in browser)
//  In production: replace fetch() calls to your backend API
// ============================================================

let DB = {
  categories: [
    { id: 1, name: 'Groceries' },
    { id: 2, name: 'Electronics' },
    { id: 3, name: 'Beverages' },
    { id: 4, name: 'Stationery' },
    { id: 5, name: 'Cleaning' }
  ],

  products: [
    { id: 1, name: 'Basmati Rice 25kg',      categoryId: 1, unitPrice: 1800, costPrice: 1500, unit: 'bag',    stock: 50, reorder: 10 },
    { id: 2, name: 'Wheat Flour 10kg',        categoryId: 1, unitPrice: 450,  costPrice: 380,  unit: 'bag',    stock: 80, reorder: 15 },
    { id: 3, name: 'Sugar 50kg',              categoryId: 1, unitPrice: 2200, costPrice: 1950, unit: 'bag',    stock: 40, reorder: 10 },
    { id: 4, name: 'Refined Oil 15L',         categoryId: 1, unitPrice: 1650, costPrice: 1430, unit: 'tin',    stock: 60, reorder: 10 },
    { id: 5, name: 'Toor Dal 5kg',            categoryId: 1, unitPrice: 700,  costPrice: 600,  unit: 'packet', stock: 100,reorder: 20 },
    { id: 6, name: 'LED Bulb 9W',             categoryId: 2, unitPrice: 85,   costPrice: 60,   unit: 'piece',  stock: 200,reorder: 30 },
    { id: 7, name: 'USB Charger 2A',          categoryId: 2, unitPrice: 250,  costPrice: 180,  unit: 'piece',  stock: 8,  reorder: 25 },
    { id: 8, name: 'Extension Board 4-plug',  categoryId: 2, unitPrice: 380,  costPrice: 290,  unit: 'piece',  stock: 75, reorder: 15 },
    { id: 9, name: 'AA Battery Pack of 4',    categoryId: 2, unitPrice: 90,   costPrice: 65,   unit: 'pack',   stock: 3,  reorder: 50 },
    { id:10, name: 'Coca-Cola 2L (Case 6)',   categoryId: 3, unitPrice: 480,  costPrice: 390,  unit: 'case',   stock: 90, reorder: 20 },
    { id:11, name: 'Mineral Water 1L x12',    categoryId: 3, unitPrice: 180,  costPrice: 140,  unit: 'case',   stock: 0,  reorder: 25 },
    { id:12, name: 'Tea Bags 100pcs',         categoryId: 3, unitPrice: 220,  costPrice: 170,  unit: 'box',    stock: 160,reorder: 30 },
    { id:13, name: 'A4 Paper 500 sheets',     categoryId: 4, unitPrice: 320,  costPrice: 260,  unit: 'ream',   stock: 80, reorder: 15 },
    { id:14, name: 'Ball Pen Box (10pc)',      categoryId: 4, unitPrice: 90,   costPrice: 65,   unit: 'box',    stock: 250,reorder: 40 },
    { id:15, name: 'Detergent Powder 5kg',    categoryId: 5, unitPrice: 450,  costPrice: 370,  unit: 'bag',    stock: 130,reorder: 25 },
    { id:16, name: 'Floor Cleaner 5L',        categoryId: 5, unitPrice: 380,  costPrice: 300,  unit: 'can',    stock: 70, reorder: 15 },
  ],

  customers: [
    { id: 1, name: 'Ramesh General Store',  phone: '9876543210', email: 'ramesh@gmail.com',    address: '12, MG Road, Delhi',    gst: '07AABCU9603R1ZP', credit: 75000  },
    { id: 2, name: 'Sharma Brothers Mart',  phone: '9812345678', email: 'sharma@gmail.com',    address: '45, Civil Lines, Agra', gst: '09AAHCS8586R1ZT', credit: 100000 },
    { id: 3, name: 'Patel Supermarket',     phone: '9701234567', email: 'patel@gmail.com',     address: '78, Station Road, Surat',gst:'24AACCP9801R1ZA', credit: 60000  },
    { id: 4, name: 'City Retail Hub',       phone: '9988776655', email: 'cityretail@gmail.com',address: '33, Park Street, Kolkata',gst:'19AABCC1234R1ZB', credit: 150000 },
    { id: 5, name: 'Gupta Wholesale Depot', phone: '9654321098', email: 'gupta@gmail.com',     address: '55, Nehru Nagar, Kanpur',gst:'09AAECG2345R1ZC', credit: 200000 },
  ],

  bills: [
    { id: 1, customerId: 1, date: '2024-05-10', total: 10500, discount: 5,  tax: 18, final: 11799,  status: 'Paid',    mode: 'Cash'   },
    { id: 2, customerId: 2, date: '2024-05-12', total: 25000, discount: 8,  tax: 18, final: 27260,  status: 'Paid',    mode: 'Online' },
    { id: 3, customerId: 3, date: '2024-05-15', total: 8000,  discount: 0,  tax: 18, final: 9440,   status: 'Unpaid',  mode: 'Credit' },
    { id: 4, customerId: 4, date: '2024-05-18', total: 45000, discount: 10, tax: 18, final: 47628,  status: 'Partial', mode: 'Credit' },
    { id: 5, customerId: 5, date: '2024-05-20', total: 18000, discount: 5,  tax: 18, final: 20214,  status: 'Paid',    mode: 'Online' },
    { id: 6, customerId: 1, date: '2024-05-22', total: 12000, discount: 0,  tax: 18, final: 14160,  status: 'Unpaid',  mode: 'Credit' },
  ],

  nextId: { products: 17, customers: 6, bills: 7 }
};


function saveDB() {
  localStorage.setItem('wholesaleDB', JSON.stringify(DB));
}


// ===============================
// LOCAL STORAGE SUPPORT
// ===============================

const savedDB = localStorage.getItem('wholesaleDB');

if (savedDB) {
  DB = JSON.parse(savedDB);
} else {
  saveDB();
}



// ============================================================
//  UTILITY FUNCTIONS
// ============================================================

/**
 * Format a number as Indian currency (₹ XX,XX,XXX)
 * @param {number} amount
 * @returns {string}
 */
function formatCurrency(amount) {
  return '₹' + Number(amount).toLocaleString('en-IN', {
    minimumFractionDigits: 2, maximumFractionDigits: 2
  });
}

/**
 * Format a date string to DD-MM-YYYY
 * @param {string} dateStr
 * @returns {string}
 */
function formatDate(dateStr) {
  const d = new Date(dateStr);
  return d.toLocaleDateString('en-IN', { day: '2-digit', month: 'short', year: 'numeric' });
}

/**
 * Get today's date in YYYY-MM-DD format (for date inputs)
 */
function todayISO() {
  return new Date().toISOString().split('T')[0];
}

/**
 * Show a temporary alert notification
 * @param {string} message
 * @param {'success'|'error'} type
 */
function showAlert(message, type = 'success') {
  const alertBox = document.getElementById('alertBox');
  if (!alertBox) return;
  alertBox.textContent = (type === 'success' ? '✅ ' : '❌ ') + message;
  alertBox.className = `alert alert-${type} show`;
  setTimeout(() => { alertBox.className = 'alert'; }, 3000);
}

/**
 * Get stock status badge HTML
 * @param {number} stock  Current stock qty
 * @param {number} reorder Reorder level
 * @returns {string} HTML badge
 */
function stockBadge(stock, reorder) {
  if (stock === 0)           return '<span class="badge badge-red">Out of Stock</span>';
  if (stock <= reorder)      return '<span class="badge badge-yellow">Low Stock</span>';
  return '<span class="badge badge-green">In Stock</span>';
}

/**
 * Get payment status badge HTML
 * @param {string} status
 * @returns {string} HTML badge
 */
function paymentBadge(status) {
  const map = {
    'Paid':    'badge-green',
    'Unpaid':  'badge-red',
    'Partial': 'badge-yellow'
  };
  return `<span class="badge ${map[status] || 'badge-blue'}">${status}</span>`;
}

/**
 * Get category name by ID
 */
function getCategoryName(id) {
  const cat = DB.categories.find(c => c.id === id);
  return cat ? cat.name : '—';
}

/**
 * Get customer name by ID
 */
function getCustomerName(id) {
  const cust = DB.customers.find(c => c.id === id);
  return cust ? cust.name : '—';
}

// ============================================================
//  SIDEBAR / MOBILE NAV
// ============================================================
function initSidebar() {
  const hamburger = document.getElementById('hamburger');
  const sidebar   = document.querySelector('.sidebar');
  const overlay   = document.getElementById('sidebarOverlay');

  if (hamburger && sidebar) {
    hamburger.addEventListener('click', () => {
      sidebar.classList.toggle('open');
    });
  }

  if (overlay) {
    overlay.addEventListener('click', () => sidebar.classList.remove('open'));
  }

  // Mark active nav link based on current page
  const currentPage = window.location.pathname.split('/').pop() || 'index.html';
  document.querySelectorAll('.sidebar-nav a').forEach(link => {
    if (link.getAttribute('href') === currentPage) {
      link.classList.add('active');
    }
  });
}

// ============================================================
//  MODAL HELPER FUNCTIONS
// ============================================================
function openModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) modal.classList.add('open');
}

function closeModal(modalId) {
  const modal = document.getElementById(modalId);
  if (modal) {
    modal.classList.remove('open');
    // Reset any form inside the modal
    const form = modal.querySelector('form');
    if (form) form.reset();
  }
}

// Close modal when clicking outside content
document.addEventListener('click', (e) => {
  if (e.target.classList.contains('modal-overlay')) {
    e.target.classList.remove('open');
  }
});

// ============================================================
//  TOPBAR DATE
// ============================================================
function setTopbarDate() {
  const el = document.getElementById('currentDate');
  if (el) {
    el.textContent = new Date().toLocaleDateString('en-IN', {
      weekday: 'short', day: '2-digit', month: 'short', year: 'numeric'
    });
  }
}

// ============================================================
//  TABLE SEARCH FILTER (generic)
//  Filters <tbody> rows based on text search input
// ============================================================
function initTableSearch(inputId, tableBodyId) {
  const input = document.getElementById(inputId);
  const tbody = document.getElementById(tableBodyId);
  if (!input || !tbody) return;

  input.addEventListener('input', () => {
    const query = input.value.toLowerCase();
    Array.from(tbody.querySelectorAll('tr')).forEach(row => {
      row.style.display = row.textContent.toLowerCase().includes(query) ? '' : 'none';
    });
  });
}

// ============================================================
//  BILLING CALCULATOR
//  Computes subtotals, discount, tax, and final bill amount
// ============================================================
function calculateBillTotals(items, discountPct, taxPct) {
  const subtotal    = items.reduce((sum, item) => sum + item.subtotal, 0);
  const discountAmt = subtotal * (discountPct / 100);
  const afterDisc   = subtotal - discountAmt;
  const taxAmt      = afterDisc * (taxPct / 100);
  const finalAmt    = afterDisc + taxAmt;

  return { subtotal, discountAmt, afterDisc, taxAmt, finalAmt };
}

// ============================================================
//  INIT ON PAGE LOAD
// ============================================================
document.addEventListener('DOMContentLoaded', () => {
  initSidebar();
  setTopbarDate();
});
