# 🎮 Game Store — Database Systems Project

A full-stack e-commerce web application for browsing, purchasing, and managing games.
Built as a Database Systems course project, it covers database design, backend API
development, user authentication, and role-based access control.

## 👥 Group Members

| Member | Roll Number |
|--------|-------------|
| Anza Naseer | 23F-0631 |
| Maidah Nasir | 23F-0764 |

## 📁 Project Structure
game-store-backend/
├── server.js           # Express server with auth routes (register/login)
├── db.js               # SQL Server connection configuration
├── package.json        # Project metadata and dependencies
├── package-lock.json   # Dependency lock file
└── README.md

## 🛠️ Tech Stack

| Layer | Technology |
|-------|------------|
| Database | MySQL / SQL Server |
| Query Language | SQL |
| Backend Language | Node.js (JavaScript) |
| Backend Framework | Express.js |
| Password Security | bcryptjs |
| DB Driver | mssql |

> **Note:** The project spec originally planned C# / .NET Core for the backend.
> This deliverable uses **Node.js + Express** for the authentication layer.

## 🗄️ Database Schema

The `Game_Store` database consists of the following core tables:

### `Users`
| Column | Type | Description |
|--------|------|-------------|
| user_id | INT (PK) | Unique user identifier |
| username | VARCHAR | Display name |
| email | VARCHAR | User email (unique) |
| password | VARCHAR | Hashed password |
| role | VARCHAR | `Customer` or `Admin` |

### `Games`
| Column | Type | Description |
|--------|------|-------------|
| game_id | INT (PK) | Unique game identifier |
| title | VARCHAR | Game title |
| description | TEXT | Game description |
| price | DECIMAL | Price |
| genre | VARCHAR | Game genre |
| platform | VARCHAR | Target platform |

### `Orders`
| Column | Type | Description |
|--------|------|-------------|
| order_id | INT (PK) | Unique order identifier |
| user_id | INT (FK) | References Users |
| order_date | DATETIME | Date of order |
| total_amount | DECIMAL | Total order cost |
| status | VARCHAR | Order status |

### `Payments`
| Column | Type | Description |
|--------|------|-------------|
| payment_id | INT (PK) | Unique payment identifier |
| order_id | INT (FK) | References Orders |
| payment_date | DATETIME | Date of payment |
| payment_status | VARCHAR | Payment status |
| payment_method | VARCHAR | Method used |

### `Inventory`
| Column | Type | Description |
|--------|------|-------------|
| game_id | INT (FK) | References Games |
| stock_quantity | INT | Current stock level |

## 🔗 API Endpoints

### Auth Routes

#### `POST /register`
Registers a new user. Password is hashed with bcrypt before storage.

**Request Body:**
```json
{
  "username": "john_doe",
  "email": "john@example.com",
  "password": "SecurePass123"
}
```

**Response:**
```json
{ "message": "User registered successfully" }
```

---

#### `POST /login`
Authenticates an existing user by comparing the hashed password.

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "SecurePass123"
}
```

**Response:**
```json
{ "message": "Login successful" }
```

---

## ⚙️ Setup & Installation

### Prerequisites
- [Node.js](https://nodejs.org/) v18+
- SQL Server or MySQL installed and running
- A database named `Game_Store` created on your server

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/game-store-backend.git
cd game-store-backend
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Configure the Database
Open `db.js` and update the connection credentials:
```js
const config = {
    user: 'your_username',       // Your SQL Server username
    password: 'your_password',   // Your SQL Server password
    server: 'localhost',         // Server host
    database: 'Game_Store',
    options: {
        encrypt: true,
        trustServerCertificate: true
    }
};
```

### 4. Start the Server
```bash
node server.js
```

The server will start at:
http://localhost:3000

---

## 🔐 Security

- Passwords are never stored in plain text.
- All passwords are hashed using **bcryptjs** with **10 salt rounds** before storage.
- SQL Server connection uses encryption (`encrypt: true`) and supports self-signed certificates via `trustServerCertificate`.

---

## 📦 Dependencies

| Package | Version | Purpose |
|---------|---------|---------|
| `express` | ^5.1.0 | HTTP server and routing |
| `bcryptjs` | ^3.0.2 | Password hashing |
| `mssql` | latest | SQL Server connection driver |

---

## 🚀 Project Deliverables

This project is broken into 5 deliverables per the course requirements:

| # | Deliverable | Status |
|---|-------------|--------|
| 1 | Database Design & Setup (Schema, Queries, Triggers, Views) | ✅ In Progress |
| 2 | Basic Game Store UI (Home, Product, Cart, Login pages) | 🔲 Upcoming |
| 3 | User Authentication & Role-Based Access Control | ✅ In Progress |
| 4 | Shopping Cart & Order Processing | 🔲 Upcoming |
| 5 | Final Integration, Testing & Refinements | 🔲 Upcoming |

---

## 📚 Course Information

**Course:** Database Systems
**Institution:** FAST - NUCES 
**Semester:** Spring 2025
