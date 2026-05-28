# 🏪 Wholesale Shop Management System

> A beginner-friendly web application for managing wholesale shop operations — products, customers, inventory, and billing — built with **MySQL**, **HTML**, **CSS**, and **JavaScript**.

![Project Status](https://img.shields.io/badge/Status-Complete-green)
![Tech Stack](https://img.shields.io/badge/Stack-MySQL%20%7C%20HTML%20%7C%20CSS%20%7C%20JS-blue)
![Level](https://img.shields.io/badge/Level-Beginner--Intermediate-yellow)

---

## 📋 Table of Contents

- [About the Project](#about-the-project)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Folder Structure](#folder-structure)
- [Database Schema](#database-schema)
- [Setup Instructions](#setup-instructions)
- [Project Workflow](#project-workflow)
- [Screenshots](#screenshots)
- [Future Improvements](#future-improvements)
- [Interview Q&A](#interview-qa)
- [Author](#author)

---

## 📌 About the Project

This project simulates a real-world wholesale shop management system suitable for small and medium wholesale businesses. It covers the complete business cycle — from adding products and registering customers to managing stock and generating invoices.

Developed as a **BTech CSE final/mini project** to demonstrate skills in:
- Relational Database Design (MySQL)
- Frontend Development (HTML/CSS/JS)
- CRUD Operations
- Business Logic Implementation

---

## ✅ Features

### 📦 Product Management
- Add, edit, and delete products
- Categorize products (Groceries, Electronics, Beverages, etc.)
- Set selling price, cost price, and unit type
- View profit margin per product

### 👥 Customer Management
- Register wholesale customers with GST numbers
- Set and manage credit limits
- View complete purchase history per customer
- Search and filter customers

### 🗄️ Inventory Management
- Real-time stock tracking
- Visual stock bar indicators (green/yellow/red)
- Stock entry log (Purchase, Sale, Adjustment, Return)
- Low stock and out-of-stock alerts on dashboard

### 🧾 Billing System
- Create itemized invoices with multiple products
- Auto-calculate GST (18%) and discounts
- Mark bills as Paid / Unpaid / Partial
- Print-ready bill receipts
- Filter bills by payment status

### 📊 Dashboard
- Summary stats (total products, customers, revenue, pending dues)
- Low stock alert table
- Pending bills list
- Recent transactions table

---

## 🛠️ Tech Stack

| Layer      | Technology        | Purpose                           |
|------------|-------------------|-----------------------------------|
| Database   | MySQL 8.0+        | Data storage and relationships    |
| Frontend   | HTML5             | Page structure                    |
| Styling    | CSS3              | Responsive design, dark theme     |
| Logic      | Vanilla JavaScript| UI interactions, CRUD simulation  |
| Fonts      | Google Fonts      | IBM Plex Sans, DM Serif Display   |

> **Note:** In this version, the JavaScript simulates backend/MySQL operations using in-memory mock data. To connect to a real MySQL database, integrate a PHP or Node.js backend.

---

## 📁 Folder Structure

```
wholesale-shop-management/
│
├── database/
│   ├── schema.sql          # CREATE TABLE statements
│   ├── sample_data.sql     # INSERT sample records
│   └── crud_queries.sql    # All CRUD + analytics queries
│
├── frontend/
│   ├── index.html          # Dashboard page
│   ├── css/
│   │   └── style.css       # Global styles
│   ├── js/
│   │   └── app.js          # Utility functions & mock data
│   └── pages/
│       ├── products.html   # Product management
│       ├── customers.html  # Customer management
│       ├── inventory.html  # Inventory tracking
│       └── billing.html    # Billing & invoices
│
├── docs/
│   └── interview_qa.md     # Interview questions & answers
│
└── README.md
```

---

## 🗄️ Database Schema

The database has **6 tables** with proper foreign key relationships:

```
categories ──┐
             │
products ────┤──── bill_items ────┐
             │                   │
             └── inventory_log   │
                                 │
customers ──────── bills ────────┘
```

### Table Summary

| Table          | Purpose                              | Key Columns                          |
|----------------|--------------------------------------|--------------------------------------|
| `categories`   | Product categories                   | category_id, category_name           |
| `products`     | Product catalog with pricing         | product_id, unit_price, stock_qty    |
| `customers`    | Wholesale buyer info                 | customer_id, gst_number, credit_limit|
| `bills`        | Invoice headers                      | bill_id, final_amount, payment_status|
| `bill_items`   | Line items per bill                  | item_id, bill_id, product_id, qty    |
| `inventory_log`| Stock movement history               | log_id, change_type, quantity        |

---

## ⚙️ Setup Instructions

### Step 1: Clone the Repository
```bash
git clone https://github.com/yourusername/wholesale-shop-management.git
cd wholesale-shop-management
```

### Step 2: Set Up the MySQL Database

1. Open **MySQL Workbench** or **phpMyAdmin** or MySQL CLI
2. Run the schema file:
```sql
SOURCE database/schema.sql;
```
3. Insert sample data:
```sql
SOURCE database/sample_data.sql;
```
4. Verify tables:
```sql
USE wholesale_shop_db;
SHOW TABLES;
```

### Step 3: Open the Frontend

Since this is a static frontend (no server required):
1. Navigate to the `frontend/` folder
2. Open `index.html` directly in your browser

OR use VS Code with **Live Server** extension:
- Right-click `index.html` → "Open with Live Server"

### Step 4: (Optional) Connect to Real MySQL Backend

To connect the frontend to a real MySQL database:
1. Create a PHP or Node.js backend API
2. Replace the mock `DB` object in `app.js` with `fetch()` API calls
3. Host backend on XAMPP / WAMP / Node server

---

## 🔄 Project Workflow

```
User Opens App
     │
     ▼
Dashboard (stats, alerts)
     │
     ├──► Product Management
     │    Add/Edit/Delete products → MySQL: products table
     │
     ├──► Customer Management
     │    Register customers → MySQL: customers table
     │
     ├──► Inventory Management
     │    Track stock → MySQL: inventory_log table
     │    Stock updates → MySQL: products.stock_qty
     │
     └──► Billing System
          Select customer → Add products → Auto-calculate
          Generate invoice → MySQL: bills + bill_items tables
          Update stock → MySQL: products.stock_qty decreases
```

---

## 🔮 Future Improvements

1. **PHP/Node.js Backend** — Connect to real MySQL instead of mock data
2. **User Authentication** — Login system with admin/staff roles
3. **Supplier Management** — Track purchase orders from suppliers
4. **PDF Export** — Export invoices as PDF using jsPDF
5. **Email Invoices** — Send bills via email using PHPMailer/NodeMailer
6. **Sales Charts** — Monthly revenue graphs using Chart.js
7. **Barcode Scanner** — Add products by scanning barcodes
8. **WhatsApp Integration** — Send payment reminders via WhatsApp API
9. **Multi-branch Support** — Manage multiple shop locations
10. **Mobile App** — Convert to Android using React Native or Flutter

---

## 🎓 Interview Q&A

See [`docs/interview_qa.md`](docs/interview_qa.md) for 20+ common interview questions and answers.

---

## 👨‍💻 Author

**[Your Name]**
BTech Computer Science Engineering
[Your College Name], [Year]

- GitHub: [@yourusername](https://github.com/yourusername)
- LinkedIn: [Your LinkedIn](https://linkedin.com/in/yourprofile)
- Email: your.email@gmail.com

---

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

---

> ⭐ If this project helped you, please give it a star on GitHub!
