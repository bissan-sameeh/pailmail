# 📧 Mail App (Flutter)

A smart and modern Mail Application built with Flutter. It features full account management, role-based access, message categorization, and a clean architecture using the MVC pattern and Provider for state management.

---

## 🚀 Features

### 🔐 Authentication
- User login and registration
- Update password and username
- Role management: switch between user/admin
- Edit user profile information

### ✉️ Email Management
- Add new emails with full details
- View email details in a clean interface
- Categorize emails based on:
  - `Pending`
  - `Inbox`
  - `Category`
  - `Completed`
- Filter emails by status
- View all mails associated with categories
- View all mails associated with status
- Real time: refresh data based on user interaction
- completely integration betwwn front end and backend(Api)
- Responsive UI 
  
- رهثص 

### ⚙️ Tech Stack
- **Flutter** for cross-platform UI
- **Provider** for efficient state management
- **MVC Architecture** for clean and scalable code structure



## 📁 Project Structure


lib/
├── models/         # Data models (email, user, etc.)
├── views/          # UI screens and widgets
├── controllers/    # Business logic and app flow
├── providers/      # State management with Provider
├── core/           # APIs and data handling
└── main.dart       # Entry point

