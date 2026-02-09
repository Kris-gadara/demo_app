# 🏗️ App Architecture & Data Flow

## Overall Architecture Diagram

```
┌─────────────────────────────────────────────────────────┐
│                     Flutter App                         │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────────────────────────────────────────┐  │
│  │              Main App (main.dart)                │  │
│  │                                                  │  │
│  │  • Firebase Initialization                      │  │
│  │  • Auth State Monitoring                        │  │
│  │  • Route Navigation                            │  │
│  └──────────────────────────────────────────────────┘  │
│                        │                                │
│        ┌───────────────┴───────────────┐               │
│        │                               │               │
│  ┌─────▼──────────┐          ┌────────▼───────┐       │
│  │  Login Page    │          │   Home Page    │       │
│  │  (Unauthenticated)        │ (Authenticated)│       │
│  │                │          │                │       │
│  │ • Sign Up      │          │ • Add Task     │       │
│  │ • Sign In      │          │ • View Tasks   │       │
│  │ • Email/Pass   │          │ • Complete     │       │
│  └─────┬──────────┘          │ • Delete       │       │
│        │                      │ • Logout       │       │
│        └──────────┬───────────┴────────────────┘       │
│                   │                                    │
└───────────────────┼────────────────────────────────────┘
                    │
        ┌───────────▼──────────────┐
        │   Firebase Services      │
        ├──────────────────────────┤
        │                          │
        │  ┌─────────────────────┐ │
        │  │  Firebase Auth      │ │
        │  │ • Email/Password    │ │
        │  │ • User Management   │ │
        │  │ • Auth State        │ │
        │  └─────────────────────┘ │
        │                          │
        │  ┌─────────────────────┐ │
        │  │ Cloud Firestore     │ │
        │  │ • Real-time sync    │ │
        │  │ • Task storage      │ │
        │  │ • User isolation    │ │
        │  └─────────────────────┘ │
        │                          │
        └──────────────────────────┘
```

---

## Authentication Flow

```
START
  │
  ├─→ Is User Logged In?
  │     │
  │     ├─ YES → Show HOME PAGE
  │     │
  │     └─ NO  → Show LOGIN PAGE
  │              │
  │              ├─→ Sign Up?
  │              │    └─→ Create Account
  │              │         └─→ Firebase Auth
  │              │              └─→ Auto Login
  │              │                   └─→ HOME PAGE
  │              │
  │              └─→ Sign In?
  │                   └─→ Verify Credentials
  │                        └─→ Firebase Auth
  │                             └─→ HOME PAGE
  │
  └─→ On Logout
       └─→ Clear Session
            └─→ Sign Out
                 └─→ LOGIN PAGE
```

---

## Task Management Data Flow

```
┌──────────────────────────────────────────────────────┐
│                   HOME PAGE                          │
├──────────────────────────────────────────────────────┤
│                                                      │
│  User Input → Add Task Form                         │
│       │                                             │
│       └─→ Validate Input                           │
│            └─→ _addTask() function                 │
│                 └─→ Firestore.add({...})          │
│                      │                             │
│  ┌────────────────────┼────────────────────┐      │
│  │                    │                    │      │
│  ▼                    ▼                    ▼      │
│ CREATE             READ                  LISTEN  │
│ New Task          Get Tasks              Stream  │
│                   from DB                Update  │
│                                                   │
│  _addTask()      StreamBuilder           Rebuild │
│  .add({})        .snapshots()            UI      │
│                  .where()                        │
│                  .orderBy()                      │
│                                                   │
│  │                    │                    │     │
│  └────────────────────┼────────────────────┘     │
│                       │                          │
│                       ▼                          │
│                  Display List                   │
│                  of Tasks                       │
│                       │                          │
│       ┌───────┬───────┴───────┬────────┐         │
│       │       │               │        │         │
│       ▼       ▼               ▼        ▼         │
│    Complete Delete   Check      Update          │
│    _toggleTask  _deleteTask   Real-time        │
│                              Changes           │
│       │       │               │        │         │
│       └───────┼───────────────┼────────┘         │
│               │                                 │
│               └─→ Firestore Update              │
│                    └─→ StreamBuilder Listens   │
│                         └─→ UI Auto-Updates    │
│                                                 │
└──────────────────────────────────────────────────┘
```

---

## Database Structure

```
Firestore Collections:

users/ ─────────────────────────────┐
  ├── {userId1}                      │
  │   ├── tasks/                     │
  │   │   ├── {taskId1}              │
  │   │   │   ├── title: String      │
  │   │   │   ├── completed: Boolean │
  │   │   │   └── createdAt: Time    │
  │   │   │                          │
  │   │   └── {taskId2}              │
  │   │       ├── title: String      │
  │   │       ├── completed: Boolean │
  │   │       └── createdAt: Time    │
  │   │                              │
  │   └── (other user collections)   │
  │                                  │
  └── {userId2}                      │
      ├── tasks/                     │
      │   ├── {taskId3}              │
      │   │   ├── title: String      │
      │   │   ├── completed: Boolean │
      │   │   └── createdAt: Time    │
      │   │                          │
      │   └── ...                    │
      │                              │
      └── (other user collections)   │
                                     │
Example Data:                        │
├── User: abc123xyz (UID)           │
│   └── Task: task001               │
│       ├── title: "Buy groceries"  │
│       ├── completed: false        │
│       └── createdAt: 2025-02-09   │
│                                   │
└── User: def456abc (UID)           │
    └── Task: task002               │
        ├── title: "Study Flutter"  │
        ├── completed: true         │
        └── createdAt: 2025-02-08   │
```

---

## Component Hierarchy

```
MyApp (Root)
│
├─ StreamBuilder<User?>
│  │  Listens to: FirebaseAuth.authStateChanges()
│  │
│  ├─ If user is NULL
│  │  └─ LoginPage
│  │     ├─ TextFields (email, password)
│  │     ├─ Toggle Button (Sign In/Sign Up)
│  │     └─ Submit Button
│  │
│  └─ If user is NOT NULL
│     └─ HomePage
│        ├─ AppBar
│        │  ├─ Title: "My Tasks"
│        │  └─ Logout Button
│        │
│        ├─ Task Input Section
│        │  ├─ TextField (task input)
│        │  └─ Add Button
│        │
│        └─ Tasks ListView
│           ├─ StreamBuilder<QuerySnapshot>
│           │  Listens to: Firestore tasks stream
│           │
│           └─ TaskCard (repeated for each task)
│              ├─ Checkbox (toggle complete)
│              ├─ Task Title (text)
│              └─ Delete Button (icon)
```

---

## State Management Flow

```
┌──────────────────────────────────────────────────┐
│         State Management Layers                  │
├──────────────────────────────────────────────────┤
│                                                  │
│  ┌────────────────────────────────────────────┐ │
│  │ Firebase Auth State (Global)               │ │
│  │ • User logged in / out                     │ │
│  │ • Triggers route changes                   │ │
│  │ Monitored by: StreamBuilder<User?>         │ │
│  └────────────────────────────────────────────┘ │
│           │                                      │
│           ▼                                      │
│  ┌────────────────────────────────────────────┐ │
│  │ Firestore Data State (Per Page)            │ │
│  │ • Task list stream                         │ │
│  │ • Real-time updates                        │ │
│  │ Monitored by: StreamBuilder<QuerySnapshot> │ │
│  └────────────────────────────────────────────┘ │
│           │                                      │
│           ▼                                      │
│  ┌────────────────────────────────────────────┐ │
│  │ Page State (Local)                         │ │
│  │ • Text field controllers                   │ │
│  │ • Loading indicators                       │ │
│  │ • Error messages                           │ │
│  │ Managed by: setState()                     │ │
│  └────────────────────────────────────────────┘ │
│                                                  │
└──────────────────────────────────────────────────┘
```

---

## User Journey Map

```
STEP 1: App Launch
└─→ main.dart initializes Firebase
    └─→ StreamBuilder checks auth state
        └─→ User not logged in? Show LoginPage

STEP 2: Sign Up
└─→ User enters email & password
    └─→ Clicks "Sign Up" button
        └─→ FirebaseAuth.createUserWithEmailAndPassword()
            └─→ New account created
                └─→ Auto-logged in
                    └─→ Redirect to HomePage

STEP 3: Add First Task
└─→ User types task title
    └─→ Clicks "+" button
        └─→ _addTask() validates input
            └─→ Firestore adds document
                └─→ StreamBuilder detects change
                    └─→ UI rebuilds with new task

STEP 4: Complete Task
└─→ User clicks checkbox
    └─→ _toggleTask() updates Firestore
        └─→ StreamBuilder detects change
            └─→ UI shows task as completed

STEP 5: Delete Task
└─→ User clicks delete icon
    └─→ _deleteTask() removes from Firestore
        └─→ StreamBuilder detects change
            └─→ UI removes task from list

STEP 6: Logout
└─→ User clicks logout button
    └─→ FirebaseAuth.signOut()
        └─→ Auth state changes
            └─→ StreamBuilder detects change
                └─→ Redirect to LoginPage

STEP 7: Login Again
└─→ User enters credentials
    └─→ FirebaseAuth.signInWithEmailAndPassword()
        └─→ Auth successful
            └─→ Redirect to HomePage
                └─→ All previous tasks still there!
```

---

## Real-time Sync Mechanism

```
┌─────────────────────────────────────────────────┐
│         Real-time Data Synchronization          │
├─────────────────────────────────────────────────┤
│                                                 │
│  User Action on Device A                       │
│  └─→ Add Task                                  │
│      └─→ Call: _firestore.collection(...).add() │
│          └─→ Firebase receives request         │
│              └─→ Validates rules               │
│                  └─→ Stores in Firestore       │
│                      └─→ Generates snapshot    │
│                          │                     │
│          ┌────────────────┴───────────────┐   │
│          │                                │   │
│          ▼                                ▼   │
│    Device A                         Device B  │
│    (Same user,                      (Same     │
│    same browser/                    user,    │
│    another tab)                     different│
│                                     browser) │
│    StreamBuilder listens         StreamBuilder
│    to snapshots()                listens to  │
│    │                            snapshots()  │
│    └──→ Snapshot received       │            │
│         │                       └──→ Snapshot
│         └──→ setState() called       received│
│             │                       │        │
│             └──→ UI rebuilds  ──────┴──→ UI  │
│                 New task           rebuilds  │
│                 appears!           New task  │
│                                    appears!  │
│                                             │
│    ⏱️ Latency: ~100-500ms (network dependent)
│                                             │
└─────────────────────────────────────────────────┘
```

---

## Security Rule Execution

```
User Request:
  └─→ read/write to /users/{userId}/tasks/{taskId}

Firestore Security Engine:
  ├─→ Is user authenticated?
  │   └─ YES: Continue
  │   └─ NO: DENY (Permission denied)
  │
  ├─→ Does request.auth.uid == userId?
  │   └─ YES: Check task rule
  │   └─ NO: DENY (Cannot access other user's data)
  │
  ├─→ Task Rule: allow read, write: if request.auth.uid == userId
  │   └─ YES: ALLOW
  │   └─ NO: DENY
  │
  └─→ Firestore executes operation
      └─→ Sends response to client
```

---

## File Dependency Graph

```
main.dart (Entry Point)
├── firebase_core/firebase.dart
├── firebase_auth/firebase_auth.dart
├── pages/login_page.dart
│   └── firebase_auth/firebase_auth.dart
│
└── pages/home_page.dart
    ├── firebase_auth/firebase_auth.dart
    ├── cloud_firestore/cloud_firestore.dart
    └── material/material.dart

firebase_options.dart
└── firebase_core/firebase.dart

pubspec.yaml
├── firebase_core: ^3.0.0
├── firebase_auth: ^5.0.0
└── cloud_firestore: ^5.0.0
```

---

## Communication Layers

```
┌─────────────────────────────────┐
│      User Interface Layer       │ ← Flutter Widgets
│  (Pages, Buttons, Lists, etc)   │
└────────────┬────────────────────┘
             │ setState() / rebuild
┌────────────▼────────────────────┐
│   Business Logic Layer          │ ← Functions, Streams
│  (_addTask, _deleteTask, etc)   │
└────────────┬────────────────────┘
             │ Firestore calls
┌────────────▼────────────────────┐
│  Firebase SDK Layer             │ ← SDK methods
│ (Auth, Firestore client)        │
└────────────┬────────────────────┘
             │ REST/gRPC calls
┌────────────▼────────────────────┐
│    Network Layer                │ ← HTTPS
│  (Firebase servers)             │
└────────────┬────────────────────┘
             │ Response
┌────────────▼────────────────────┐
│  Firebase Servers               │ ← Cloud Infrastructure
│  (Auth service, Firestore DB)   │
└─────────────────────────────────┘
```

---

## Performance & Optimization

```
Optimizations Implemented:
├─ StreamBuilder
│  └─ Only rebuilds when data changes (not whole screen)
│
├─ orderBy() in query
│  └─ Sorts at database level (not in app)
│
├─ snapshots() stream
│  └─ Real-time updates (automatic sync)
│
├─ Firestore rules
│  └─ Rules prevent unnecessary data transfers
│
└─ Hot reload support
   └─ Fast development iteration
```

---

**This architecture ensures:**
✅ Scalable (Firebase handles growth)
✅ Secure (Rules enforce access control)
✅ Real-time (Streams enable instant updates)
✅ Responsive (Only rebuilds what changed)
✅ Maintainable (Clear separation of concerns)

