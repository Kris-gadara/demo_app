# ⚡ Quick Command Reference

## 🚀 Getting Started (First Time Only)

```powershell
# 1. Navigate to project
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"

# 2. Get dependencies
flutter pub get

# 3. Install FlutterFire CLI
dart pub global activate flutterfire_cli

# 4. Configure Firebase (follow interactive prompts)
flutterfire configure

# 5. Run the app
flutter run -d chrome
```

---

## 🎯 Running the App

### Web (Chrome) - Recommended
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter run -d chrome
```

### Web (Edge)
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter run -d edge
```

### Windows Desktop
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter run -d windows
```

---

## 🔍 Development Commands

### Check Code Quality
```powershell
flutter analyze
```

### Format Code
```powershell
flutter format .
```

### Run Tests
```powershell
flutter test
```

### Check Dependencies
```powershell
flutter pub outdated
```

### Clean Build
```powershell
flutter clean
flutter pub get
flutter run -d chrome
```

---

## 🛠️ Troubleshooting Commands

### See all connected devices
```powershell
flutter devices
```

### Check Flutter installation
```powershell
flutter doctor
```

### Full doctor report
```powershell
flutter doctor -v
```

### Clear cache and rebuild
```powershell
flutter clean
flutter pub get
flutter pub cache repair
```

---

## 📦 Dependency Management

### Add new package
```powershell
flutter pub add package_name
```

### Update all dependencies
```powershell
flutter pub upgrade
```

### Install locked versions
```powershell
flutter pub get
```

---

## 🔥 Firebase-Specific Commands

### Reconfigure Firebase
```powershell
flutterfire configure --platforms=windows,web,android
```

### View Firebase CLI info
```powershell
flutterfire --version
```

---

## 📁 File Locations

```
Project Root: C:\K\Semester 6\MAD\demo_app\my_flutter_app\

Key Files:
├── lib/main.dart                 # App entry point
├── lib/firebase_options.dart     # Firebase config (auto-generated)
├── lib/pages/login_page.dart     # Login UI
├── lib/pages/home_page.dart      # Task management UI
├── pubspec.yaml                  # Dependencies
└── SETUP_AND_RUN.md             # Setup guide
```

---

## 💻 VS Code Shortcuts

```
Ctrl + Shift + P  → Command palette
Ctrl + K, Ctrl + F → Format document
F5               → Start debugging
Shift + F5       → Stop debugging
Ctrl + Shift + L → Select all occurrences
```

---

## 🐛 Common Issues Quick Fix

| Issue | Command |
|-------|---------|
| Dependencies not found | `flutter pub get` |
| Build errors | `flutter clean && flutter pub get` |
| Analyze code | `flutter analyze` |
| Update packages | `flutter pub upgrade` |
| Reconfigure Firebase | `flutterfire configure` |

---

## 📊 Checking Status

### See app logs
```powershell
# While running app, press 'l' for logs
```

### Exit running app
```
Press 'q' in terminal
```

### Hot reload
```
Press 'r' in terminal while app is running
```

### Hot restart
```
Press 'R' in terminal while app is running
```

---

## 🎯 Daily Workflow

```powershell
# 1. Navigate to project
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"

# 2. Get latest changes/dependencies
flutter pub get

# 3. Run the app
flutter run -d chrome

# 4. Make changes in VS Code

# 5. Save file (auto hot-reload in debug mode)

# 6. Check for errors
flutter analyze
```

---

## 📱 Testing Scenarios Commands

### Sign up test
```
Email: testuser@example.com
Password: Test@123456
```

### Login test
```
Use same credentials as above
```

### Add task test
```
Type: "Test Task"
Press Enter or click +
```

---

## 🎓 Before Exam

```powershell
# 1. Clean everything
flutter clean

# 2. Get fresh dependencies
flutter pub get

# 3. Analyze code
flutter analyze

# 4. Run and test
flutter run -d chrome

# 5. Create test account
# 6. Test all features
# 7. Take screenshots for backup
```

---

## 🚨 Emergency Reset

If everything breaks:
```powershell
cd "C:\K\Semester 6\MAD\demo_app\my_flutter_app"
flutter clean
flutter pub get
flutter pub cache repair
flutterfire configure
flutter run -d chrome
```

---

## 📞 Help Commands

```powershell
# Flutter help
flutter --help

# Specific command help
flutter run --help

# Check version
flutter --version

# Check installation
flutter doctor
```

---

## 🎯 Final Checklist

- [ ] Can run `flutter run -d chrome` successfully
- [ ] App shows login page on startup
- [ ] Can sign up with email/password
- [ ] Can add tasks
- [ ] Can complete tasks
- [ ] Can delete tasks
- [ ] Can logout
- [ ] Can login again
- [ ] No console errors
- [ ] `flutter analyze` shows no major issues

---

**💡 Pro Tip:** Keep this file open in a terminal window during development for quick reference!

