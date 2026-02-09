# 📱 Task Manager App - Flutter Firebase Project

## 🎯 Project Overview

A modern Task Management application built with Flutter and Firebase. This is a simple yet feature-rich app perfect for exam demonstrations.

### Why Task Manager?
- ✅ Simple concept (not News App or OTT like previous batches)
- ✅ Shows authentication flows
- ✅ Demonstrates CRUD operations
- ✅ Uses real-time Firestore database
- ✅ Professional UI with Material Design
- ✅ Cross-platform support (Android, iOS, Web, Windows, macOS, Linux)

---

## 📦 What's Inside

### 1. **Login Page** (`lib/pages/login_page.dart`)
- Email/Password authentication
- Sign-up and Sign-in modes
- Beautiful gradient background
- Error handling and validation
- Loading states

### 2. **Home Page** (`lib/pages/home_page.dart`)
- Task management interface
- Add new tasks
- Mark tasks as complete/incomplete
- Delete tasks
- Real-time Firestore sync
- User logout
- Empty state handling

### 3. **Firebase Integration** 
- Authentication with email/password
- Firestore database for data persistence
- Real-time updates using StreamBuilder
- User-specific data isolation

---

## 🚀 Complete Setup Instructions

### Step 1: Create Firebase Project
```
1. Visit: https://console.firebase.google.com/
2. Click "Create a project"
3. Enter project name: "Task Manager App"
4. Click "Create project"
5. Wait for project to be created
```

### Step 2: Enable Firebase Services
```
Authentication:
- Go to Authentication
- Click Get Started
- Enable Email/Password
- Click Save

Firestore Database:
- Go to Firestore Database
- Click Create database
- Start in Test mode
- Select location (us-central1 recommended)
- Click Create
```

### Step 3: Connect Flutter to Firebase
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"

# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

When prompted:
- Select your Firebase project
- Select platforms: Windows, Web, Android (or all)
- Press Enter to confirm

This will auto-generate `firebase_options.dart` with your credentials.

### Step 4: Set Firestore Security Rules
In Firebase Console:
```
Firestore Database → Rules → Replace with:
```

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
      match /tasks/{taskId} {
        allow read, write: if request.auth.uid == userId;
      }
    }
  }
}
```

Click "Publish"

### Step 5: Run the App

**Option A: Web Browser (Easiest)**
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter run -d chrome
```

**Option B: Windows Desktop**
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter run -d windows
```

---

## 📱 How to Use the App

### Sign Up
1. Launch the app
2. Click "Sign Up" at the bottom
3. Enter your email and password
4. Click "Sign Up" button
5. You're automatically logged in!

### Add Tasks
1. On home page, type task in the text field
2. Press Enter or click the "+" button
3. Task appears in the list instantly

### Manage Tasks
- **Complete**: Click checkbox to mark done
- **Delete**: Click trash icon to remove
- **View**: Tasks list updates in real-time

### Logout
- Click the logout button (↪️) in top-right corner
- Returns to login page

---

## 📁 Project Structure

```
my_flutter_app/
├── lib/
│   ├── main.dart              ← App entry point & Firebase init
│   ├── firebase_options.dart  ← Firebase config (auto-generated)
│   └── pages/
│       ├── login_page.dart    ← Auth UI
│       └── home_page.dart     ← Task management UI
├── android/                   ← Android configuration
├── ios/                       ← iOS configuration
├── windows/                   ← Windows configuration
├── web/                       ← Web configuration
├── pubspec.yaml              ← Dependencies
└── SETUP_AND_RUN.md          ← Detailed setup guide
```

---

## 🛠️ Key Technologies

| Technology | Purpose |
|-----------|---------|
| **Flutter** | UI Framework |
| **Firebase Core** | Firebase initialization |
| **Firebase Auth** | User authentication |
| **Cloud Firestore** | Real-time database |
| **StreamBuilder** | Real-time data updates |
| **Material Design** | Modern UI components |

---

## 🔐 Security Features

✅ **Authentication**: Email/password with Firebase Auth
✅ **Data Privacy**: Each user sees only their tasks
✅ **Firestore Rules**: Enforce user-level access control
✅ **Input Validation**: Email and password checks
✅ **Error Handling**: Graceful error messages

---

## 📊 Database Schema

```
Firestore Structure:
├── users
│   └── {userId}
│       └── tasks
│           └── {taskId}
│               ├── title: String
│               ├── completed: Boolean
│               └── createdAt: Timestamp
```

**Example:**
```
users/
└── abc123xyz (Firebase UID)
    └── tasks/
        ├── task001
        │   ├── title: "Buy groceries"
        │   ├── completed: false
        │   └── createdAt: 2025-02-09
        └── task002
            ├── title: "Study Flutter"
            ├── completed: true
            └── createdAt: 2025-02-08
```

---

## 🎨 UI Design

### Color Scheme
- **Primary**: Deep Purple (`Colors.deepPurple`)
- **Accent**: White
- **Background**: Gradient (Deep Purple to Dark Purple)

### Components
- Gradient backgrounds
- Modern input fields
- Rounded corners (radius: 12px)
- Smooth animations
- Loading indicators
- Empty states

---

## 🧪 Testing the App

### Test Account (After Setup)
```
Email: test@example.com
Password: password123

(Create your own account for testing)
```

### Test Scenarios
1. ✅ Sign up with new email
2. ✅ Sign in with valid credentials
3. ✅ Try signing in with wrong password (should error)
4. ✅ Add task and verify it appears
5. ✅ Complete task (checkbox)
6. ✅ Delete task
7. ✅ Logout and verify redirect to login
8. ✅ Sign in again to verify tasks persist

---

## ⚠️ Common Issues & Solutions

| Issue | Solution |
|-------|----------|
| `firebase_options.dart not found` | Run `flutterfire configure` |
| `Permission denied on Firestore` | Check security rules, ensure logged in |
| `Invalid credentials` | Verify email/password in Firebase Console |
| `No connected devices` | Run `flutter run -d chrome` for web |
| `Build fails` | Run `flutter pub get` and `flutter clean` |

---

## 💡 Pro Tips

1. **Test Mode Duration**: Firestore test mode expires after 30 days
2. **Real-time Sync**: Every task change syncs instantly
3. **Offline**: Flutter apps can cache data for offline use
4. **Scaling**: For production, switch from test mode to proper rules
5. **Analytics**: Enable Firebase Analytics for user insights

---

## 🔄 App Flow Diagram

```
START
  ↓
Firebase Initialized?
  ├─ Yes → Is User Logged In?
  │         ├─ Yes → HOME PAGE (Task Manager)
  │         └─ No → LOGIN PAGE
  └─ No → Initialize Firebase

HOME PAGE
  ├─ Add Task → Firestore
  ├─ Complete Task → Update Firestore
  ├─ Delete Task → Remove from Firestore
  └─ Logout → Sign out & return to LOGIN PAGE
```

---

## 📚 Code Examples

### Login with Firebase
```dart
await FirebaseAuth.instance.createUserWithEmailAndPassword(
  email: email,
  password: password,
);
```

### Add Task to Firestore
```dart
await _firestore
    .collection('users')
    .doc(_auth.currentUser!.uid)
    .collection('tasks')
    .add({
      'title': taskTitle,
      'completed': false,
      'createdAt': Timestamp.now(),
    });
```

### Real-time Task Updates
```dart
StreamBuilder<QuerySnapshot>(
  stream: _firestore
      .collection('users')
      .doc(_auth.currentUser!.uid)
      .collection('tasks')
      .orderBy('createdAt', descending: true)
      .snapshots(),
  builder: (context, snapshot) {
    // Build UI with real-time data
  },
)
```

---

## 🚀 Next Steps After Setup

1. Run the app successfully ✓
2. Create a Firebase project ✓
3. Set up authentication ✓
4. Configure Firestore ✓
5. Test all features
6. Demo for exam

### Optional Enhancements
- Add task categories/labels
- Add due dates and notifications
- Add task priority levels
- Add search functionality
- Add task descriptions
- Dark mode support

---

## 📞 Quick Reference

**Commands to Remember:**
```powershell
# Get dependencies
flutter pub get

# Check code quality
flutter analyze

# Run app
flutter run -d chrome          # Web
flutter run -d windows         # Desktop

# Clean build
flutter clean
flutter pub get
```

---

## ✅ Pre-Exam Checklist

- [ ] Firebase project created
- [ ] Authentication enabled
- [ ] Firestore database created
- [ ] Security rules deployed
- [ ] `flutterfire configure` ran successfully
- [ ] App runs without errors
- [ ] Can sign up with new account
- [ ] Can add/complete/delete tasks
- [ ] Tasks persist after logout/login
- [ ] Can log out successfully

---

## 🎓 Exam Tips

**What to Demonstrate:**
1. ✅ App architecture (separate pages, organized code)
2. ✅ Authentication flow (login/signup)
3. ✅ Real-time database (Firestore)
4. ✅ CRUD operations (Create, Read, Update, Delete)
5. ✅ UI/UX design (Material Design, responsive)
6. ✅ Error handling (try-catch, user feedback)
7. ✅ Security (Firestore rules, user isolation)

**Talking Points:**
- "Used Flutter for cross-platform development"
- "Firebase for scalable backend"
- "Real-time Firestore for instant data sync"
- "StreamBuilder for reactive UI updates"
- "Material Design for professional UI"
- "Security rules to protect user data"

---

## 📞 Support

If you encounter issues:

1. **Check SETUP_AND_RUN.md** for detailed troubleshooting
2. **Review Firestore rules** - most issues are here
3. **Ensure Firebase project is properly configured**
4. **Run `flutter analyze`** to check code
5. **Check Firebase Console** for authentication status

---

**You're all set! 🎉 Follow the setup steps and your app will be running. Good luck with your exam!**

