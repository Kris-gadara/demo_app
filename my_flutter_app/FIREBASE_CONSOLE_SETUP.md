# 🔥 Firebase Console Setup - Step by Step with Screenshots

## Step 1: Create Firebase Project

### 1a. Go to Firebase Console
```
URL: https://console.firebase.google.com/
Click: "Create a project" button
```

### 1b. Enter Project Details
- **Project Name:** Task Manager App (or your choice)
- **Enable Analytics:** Yes (optional)
- Click: "Continue" button

### 1c. Configure Analytics
- Select: "Default Account for Firebase"
- Click: "Create project" button

### 1d. Wait for Creation
- Firebase will create your project (~1-2 minutes)
- You'll see "Your new cloud project is ready"

---

## Step 2: Enable Authentication

### 2a. Navigate to Authentication
```
Left Sidebar → Authentication
Click: "Get Started" button
```

### 2b. Enable Email/Password Provider
```
Available Sign-in methods section
Click: "Email/Password" option
Toggle: "Enable" switch
(Optional) Enable "Email link (passwordless sign-in)"
Click: "Save" button
```

### 2c. Verify Authentication is Enabled
```
You should see:
✓ Email/Password   ENABLED
```

---

## Step 3: Create Firestore Database

### 3a. Navigate to Firestore
```
Left Sidebar → Build → Firestore Database
Click: "Create database" button
```

### 3b. Database Settings
```
Location: us-central1 (default is fine)
Click: "Next" button
```

### 3c. Security Rules
```
Choose: "Start in test mode"
(This allows full read/write for development)
Click: "Enable" button
```

**Important:** Remember to change rules before deployment!

### 3d. Wait for Creation
```
Firestore will initialize (~30 seconds)
You'll see "Database created successfully"
```

---

## Step 4: Get Firebase Credentials

### 4a. Access Project Settings
```
Top-left corner: Click gear icon ⚙️
Click: "Project settings"
```

### 4b. View Credentials
```
Tab: "General"
Scroll down: Find "Your apps" section
Click: "Add app" button
```

### 4c. Select Platform
```
For Flutter, you can skip this because:
FlutterFire CLI will handle credential generation automatically
```

---

## Step 5: Configure Flutter with Firebase

### 5a. Open PowerShell
```
Navigate to project:
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
```

### 5b. Run FlutterFire Configure
```powershell
flutterfire configure
```

### 5c. Follow Interactive Prompts
```
? Which Firebase project do you want to use?
  → Select: "Task Manager App" (or your project name)

? Which platforms should be configured?
  ☑ android
  ☑ ios
  ☑ macos
  ☑ windows
  ☑ web
  (Select all or your target platforms)

? Continue? (y/N)
  → Type: y (yes)
```

### 5d. Configuration Complete
```
FlutterFire will:
✓ Generate firebase_options.dart
✓ Configure all platforms
✓ Download Google services files
✓ Update build configuration files
```

---

## Step 6: Set Up Firestore Security Rules

### 6a. Navigate to Firestore Rules
```
Firestore Database → Rules tab
```

### 6b. Replace Rules
```
You'll see default test mode rules
Click: Edit button
Delete all existing content
```

### 6c. Paste New Rules
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

### 6d. Publish Rules
```
Click: "Publish" button
Confirm: Click "Publish" in dialog
```

### 6e. Verify Rules
```
You should see:
"Rules updated successfully"
```

---

## Step 7: Verify Everything is Set Up

### 7a. Check Authentication
```
Firebase Console → Authentication
You should see:
  ✓ Email/Password enabled
  ✓ "Users" tab (empty for now)
```

### 7b. Check Firestore
```
Firebase Console → Firestore Database
You should see:
  ✓ "Start collection" option
  ✓ Rules tab showing your rules
```

### 7c. Check Project Settings
```
Firebase Console → Settings → Project settings
Verify:
  ✓ Project name: "Task Manager App"
  ✓ Google Cloud Platform: (linked project)
```

---

## Step 8: Verify Flutter Configuration

### 8a. Check Generated Files
```
Open: lib/firebase_options.dart

You should see:
- Web configuration
- Android configuration
- iOS configuration
- Windows configuration
- macOS configuration

All with real credentials!
```

### 8b. Check pubspec.yaml
```
You should have:
dependencies:
  firebase_core: ^3.0.0
  firebase_auth: ^5.0.0
  cloud_firestore: ^5.0.0
```

---

## Step 9: Run and Test the App

### 9a. Get Dependencies
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter pub get
```

### 9b. Run the App
```powershell
flutter run -d chrome
```

### 9c. Test Sign-up
```
1. App opens → Login page appears
2. Click "Sign Up" link
3. Enter email: test@example.com
4. Enter password: Test@123456
5. Click "Sign Up" button
6. Home page appears → SUCCESS!
```

### 9d. Test Firestore
```
Go to Firebase Console → Firestore Database
You should see:
  users/
  └── {new user ID}
```

---

## ✅ Verification Checklist

```
Authentication Setup:
  ☑ Email/Password enabled
  ☑ Test user can sign up
  ☑ Test user can login

Firestore Setup:
  ☑ Database created in test mode
  ☑ Security rules published
  ☑ Collections structure visible

Flutter Integration:
  ☑ firebase_options.dart generated
  ☑ Dependencies installed
  ☑ App runs without errors
  ☑ Sign up/login works
  ☑ Data appears in Firestore
```

---

## 🚨 Common Issues During Setup

### Issue: "Project not found"
**Solution:** Reload page or refresh Firebase Console

### Issue: "Authentication not working"
**Solution:** 
1. Verify Email/Password is enabled
2. Check security rules
3. Run `flutterfire configure` again

### Issue: "Firestore rules error"
**Solution:**
1. Copy-paste rules exactly (check quotes)
2. Ensure no syntax errors
3. Click "Publish" instead of just "Save"

### Issue: "firebase_options.dart not found"
**Solution:**
1. Run `flutterfire configure` again
2. Select your project and platforms
3. File will be auto-generated

---

## 🔄 Testing the Full Flow

After setup, test this flow:

```
1. App starts → See Login Page
2. Click "Sign Up"
3. Enter: test@example.com / password123
4. Click "Sign Up" button
5. Redirects to Home Page (auto-login)
6. Type "My First Task"
7. Click "+" button
8. Task appears in list
9. Go to Firebase Console → Firestore
10. See: users/{yourUID}/tasks/{taskID}
11. Go back to app, click logout
12. Login again with same credentials
13. See task still there ✓
```

---

## 📞 Firebase Console Quick Links

| Feature | Path |
|---------|------|
| Authentication | `Authentication` > `Users` |
| Firestore Data | `Firestore Database` > `Data` |
| Security Rules | `Firestore Database` > `Rules` |
| Project Settings | ⚙️ > `Project settings` |
| Firebase Console | https://console.firebase.google.com/ |

---

## 💡 Pro Tips

1. **Keep Firebase Console open** - Useful for monitoring during development
2. **Test mode expires in 30 days** - Switch to proper rules before then
3. **Use web emulator** - `firebase emulators:start` for local testing (advanced)
4. **Enable logging** - Helps debug Firebase issues
5. **Monitor usage** - Firebase shows real-time data in dashboard

---

## 🎯 You're Done with Firebase Setup!

Once verified, you're ready to:
- ✅ Run the app
- ✅ Sign up users
- ✅ Manage tasks
- ✅ Demo for exams

**All Firebase configuration is automatic after this! 🎉**

