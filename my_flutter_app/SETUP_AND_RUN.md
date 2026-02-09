# Task Manager Flutter App - Complete Setup & Run Guide

## ✅ What's Been Done

Your Flutter project has been set up with:
- **Login/Sign-up page** with Firebase Authentication
- **Task Management home page** with Firestore integration
- **Firebase dependencies** installed
- **Material Design** UI with modern styling

## 🚀 How to Run the Project

### Important: Firebase Configuration Required First!

Before running the app, you MUST configure Firebase:

### Step 1: Create Firebase Project
1. Go to https://console.firebase.google.com/
2. Click "Create a project" 
3. Name it (e.g., "Task Manager App")
4. Enable Google Analytics (optional but recommended)
5. Click "Create project"

### Step 2: Set Up Firebase Services

#### 2a. Enable Authentication
- In Firebase Console, go to **Authentication**
- Click **Get Started**
- Click **Email/Password** provider
- Toggle **Enable**
- Click **Save**

#### 2b. Create Firestore Database
- In Firebase Console, go to **Firestore Database**
- Click **Create database**
- Start in **Test mode** (for development)
- Choose your database location
- Click **Create**

### Step 3: Configure Flutter with Firebase

Open PowerShell and run:

```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
dart pub global activate flutterfire_cli
flutterfire configure
```

This will:
- Show you your Firebase projects
- Select the one you just created
- Automatically update `firebase_options.dart` with your credentials
- Configure it for all platforms (Android, iOS, Web, Windows, etc.)

### Step 4: Run the App

Choose your platform:

**Windows Desktop:**
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter run -d windows
```

**Web Browser (Chrome/Edge):**
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter run -d chrome
# or
flutter run -d edge
```

## 🔒 Set Up Firestore Security Rules

1. In Firebase Console, go to **Firestore Database** > **Rules**
2. Replace the existing rules with:

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

3. Click **Publish**

## 📱 How to Use the App

1. **Create Account**: Enter email and password, click "Sign Up"
2. **Login**: Enter your credentials and click "Sign In"
3. **Add Task**: Type task name and press Enter or click the "+" button
4. **Mark Complete**: Check the checkbox next to task
5. **Delete Task**: Click the trash icon
6. **Logout**: Click logout button in top-right corner

## 📁 Project Files

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase config (auto-generated)
└── pages/
    ├── login_page.dart      # Authentication UI
    └── home_page.dart       # Task management UI
```

## 🛠️ If Something Goes Wrong

### Error: "flutter command not found"
- Add Flutter to PATH: https://flutter.dev/docs/get-started/install/windows

### Error: "No connected devices"
- Run on web: `flutter run -d chrome`
- Or enable Windows desktop in Flutter

### Error: "firebase_options.dart not found"
- Run: `flutterfire configure`

### Error: "Permission denied" on Firestore
- Check Firestore security rules (see above)
- Make sure you're logged in as the user

### Error: "Invalid credentials"
- Verify email/password is enabled in Firebase Authentication
- Check that your email address is correct

## 📚 Architecture

The app uses:
- **Firebase Authentication**: User login/signup
- **Cloud Firestore**: Database for storing tasks
- **StreamBuilder**: Real-time updates
- **Provider pattern**: State management

Database Structure:
```
Firestore
└── users/{userId}
    └── tasks/{taskId}
        ├── title: String
        ├── completed: Boolean
        └── createdAt: Timestamp
```

## 💡 Tips

- The app automatically routes to login if not authenticated
- Tasks are real-time synced from Firestore
- Each user can only see their own tasks (enforced by security rules)
- Start in Firestore test mode, switch to production rules before deployment

## 🎯 Next Steps (Optional Enhancements)

- Add task due dates
- Add task categories
- Add task search
- Add notifications
- Add offline sync
- Add profile page

---

**Ready to run?** Follow the steps above and start managing your tasks! 🎉

