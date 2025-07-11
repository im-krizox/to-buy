# 🛠️ Detailed Work Plan – Shopping List App with Flutter + Firebase

## 🧾 Project Overview
Cross-platform mobile application (Flutter with Dart) that allows users to:
- Create, edit, and delete shopping list items.
- Authenticate via email or external providers (Google, Facebook, Apple).
- Automatically classify products into categories using AI.
- View a dashboard with analytics on shopping behavior.

---

## 🗂️ General Phase Structure

| Phase | Name                        | Main Goal                                          |
|-------|-----------------------------|----------------------------------------------------|
| 1     | Initial Setup               | Configure Flutter project and Firebase connection  |
| 2     | Authentication              | Email login + external providers                   |
| 3     | Shopping List CRUD          | Add, edit, delete items from the list              |
| 4     | AI-based Categorization     | Auto-categorize items via ML/AI                    |
| 5     | Analytics Dashboard         | Charts and statistics view                         |
| 6     | Polish & Deployment         | Testing, UI polish, store release                  |

---

## ✅ Phase 1: Initial Setup

### 🎯 Goal:
Set up the Flutter environment and connect to Firebase.

### 🔧 Tasks:
1. [ ] Create Flutter project (`flutter create your_app`)
2. [ ] Set up Firebase for both Android and iOS
3. [ ] Install and configure required packages:
   - `firebase_core`
   - `firebase_auth`
   - `cloud_firestore`
   - `flutter_secure_storage`
   - `google_sign_in`, `flutter_facebook_auth`, `sign_in_with_apple`
4. [ ] Initialize Firebase in `main.dart`
5. [ ] Set up app navigation (`go_router` or `flutter_modular`)
6. [ ] Organize folder structure:
lib/
├── main.dart
├── app.dart
├── config/                
├── core/
├── features/
├── shared/               
└── utils/                 


---

## ✅ Phase 2: User Authentication

### 🎯 Goal:
Allow users to register and log in with email and social providers.

### 🔧 Tasks:
1. [ ] Welcome screen with login options
2. [ ] Email/password login & registration screen
3. [ ] Integrate Google Sign-In (Android & iOS)
4. [ ] Integrate Facebook Login
5. [ ] Integrate Apple Sign-In (iOS only)
6. [ ] Save user data in Firestore under `users/uid`
7. [ ] Authentication middleware for navigation protection
8. [ ] Implement logout and session handling
9. [ ] Store session/token securely using `flutter_secure_storage`

---

## ✅ Phase 3: Shopping List CRUD

### 🎯 Goal:
Enable full CRUD operations on shopping list items per authenticated user.

### 🔧 Tasks:
1. [ ] Create `ShoppingItem` model with fields: name, quantity, category, purchased (bool), timestamp
2. [ ] Design main screen with:
- List of items
- FAB to add new item
- Edit/delete using swipe (Dismissible)
3. [ ] Item form screen for creating/updating
4. [ ] Save items in Firestore under `users/uid/items`
5. [ ] Show real-time item updates (StreamBuilder)
6. [ ] Mark items as purchased
7. [ ] Filter by: All, Purchased, Pending

---

## ✅ Phase 4: AI-Based Categorization

### 🎯 Goal:
Automatically categorize products upon adding using an AI model.

### 🔧 Tasks:
1. [ ] Add `category` field to `ShoppingItem`
2. [ ] Option 1: External API (recommended for simplicity)
- [ ] Create API endpoint using Firebase Functions or external backend
- [ ] Train a simple classification model (e.g., using product names)
- [ ] On item creation, send product name to API and receive category
3. [ ] Option 2: On-device TFLite model (offline ML)
- [ ] Train and convert model to `.tflite`
- [ ] Integrate using `tflite_flutter`
4. [ ] Display auto-assigned category in the UI

---

## ✅ Phase 5: Analytics Dashboard

### 🎯 Goal:
Show visual insights based on shopping data.

### 🔧 Tasks:
1. [ ] Build statistics screen using `fl_chart` or `syncfusion_flutter_charts`
2. [ ] Analyze:
- Most purchased items
- Most and least used categories
- Purchase trends over time
3. [ ] Query Firestore and aggregate necessary data
4. [ ] Display charts:
- Bar
- Pie
- Line (for time series)
5. [ ] Add textual summary of insights

---

## ✅ Phase 6: Polish and Deployment

### 🎯 Goal:
Ensure the app is production-ready for release.

### 🔧 Tasks:
1. [ ] Testing (unit/widget/integration via `flutter_test`)
2. [ ] Form validation and input sanitization
3. [ ] Error handling (try/catch + SnackBars or dialogs)
4. [ ] Android/iOS platform compatibility testing
5. [ ] Add icons and splash screen (`flutter_launcher_icons`, `flutter_native_splash`)
6. [ ] Remove unnecessary permissions and keys
7. [ ] Build release APK/IPA
8. [ ] Publish to Google Play and App Store

---

## 🧠 Optional Features (Bonus Phase)

- [ ] Offline storage with Hive or Isar
- [ ] Push notifications via `firebase_messaging`
- [ ] Multi-language support (`flutter_localizations`)
- [ ] Light/Dark mode
- [ ] Shared lists between users

---

## 🛠️ Recommended Tools

| Tool                 | Purpose                            |
|----------------------|-------------------------------------|
| Flutter              | Main development framework          |
| Dart                 | Programming language                |
| Firebase Auth        | Authentication service              |
| Firestore            | Cloud database                      |
| Firebase Functions   | AI/logic APIs (optional)            |
| Hive                 | Local DB (optional)                 |
| fl_chart             | Data visualization                  |
| Cursor (Agent Mode)  | Assisted development with agents    |
