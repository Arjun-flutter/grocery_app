# 🛒 Fresh Mart - Smart Grocery App

[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev/)
[![Firebase](https://img.shields.io/badge/firebase-%23039BE5.svg?style=for-the-badge&logo=firebase&logoColor=white)](https://firebase.google.com/)
[![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev/)

Fresh Mart is a **modern Grocery E-commerce mobile application** built using **Flutter** and **Firebase**.
The app provides a smooth grocery shopping experience where users can browse products, search items, manage cart, and simulate a realistic checkout process.

This project follows **Clean Architecture (MVVM)** principles and uses **Provider** for efficient state management.

---

## 🚀 Features

- 🔐 **Authentication**: Firebase Email & Password authentication.
- 📦 **Product Catalog**: Live grocery data from **DummyJSON REST API**.
- 🔍 **Smart Search**: Real-time search and category-based filtering.
- 🛒 **Cart System**: Add/Remove items, quantity control, and dynamic delivery charges.
- 💳 **Checkout Flow**: Premium bottom sheet for payment method selection.
- 🎨 **Modern UI**: Emerald Green theme, responsive design, and Material 3.

---

## 📸 App Screenshots

### 🔹 Onboarding & Authentication
| Splash Screen | Login Screen | Register Screen |
| :---: | :---: | :---: |
| <img src="screenshots/splash_screen.png" width="200"> | <img src="screenshots/login_screen.png" width="200"> | <img src="screenshots/register_screen.png" width="200"> |

### 🔹 Browsing & Discovery
| Home Screen | Categories | Category Products |
| :---: | :---: | :---: |
| <img src="screenshots/home_screen.png" width="200"> | <img src="screenshots/categorys_screen.png" width="200"> | <img src="screenshots/category_list.png" width="200"> |

### 🔹 Shopping & Cart
| Search Filter | Active Cart | Empty Cart |
| :---: | :---: | :---: |
| <img src="screenshots/search_filter.png" width="200"> | <img src="screenshots/cart_items.png" width="200"> | <img src="screenshots/empty_cart.png" width="200"> |

### 🔹 Checkout & Profile
| Payment Selection | Processing | Order Success | Profile Page |
| :---: | :---: | :---: | :---: |
| <img src="screenshots/payment_screen.png" width="180"> | <img src="screenshots/payment_loading.png" width="180"> | <img src="screenshots/success_screen.png" width="180"> | <img src="screenshots/profile_screen.png" width="180"> |

---

## 📂 Project Structure

```
lib/
├── models/          # Product and User models
├── services/        # API and Payment services
├── providers/       # Auth, Cart, and Product state management
├── screens/         # UI Screens (Home, Cart, Auth, etc.)
├── widgets/         # Reusable UI components
└── main.dart        # Entry point and Firebase initialization
```

---

## ⚙️ Setup & Installation

1. **Clone the repo:** `git clone https://github.com/Arjun-flutter/grocery_app.git'
2. **Install dependencies:** `flutter pub get`
3. **Firebase:** Place `google-services.json` in `android/app/`.
4. **Run:** `flutter run`

---

Developed with ❤️ by **Nagarjuna Reddy Avula**
