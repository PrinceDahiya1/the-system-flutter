# The System: Reactive State Architecture

![Status](https://img.shields.io/badge/Status-Research_&_Development-blueviolet) 
![Flutter](https://img.shields.io/badge/Tech-Flutter_|_Riverpod_|_Drift-blue)

**"The System"** is a local-first reactive mobile architecture designed to quantify personal productivity. It leverages an offline-persistent database and stream-based state management to provide real-time statistical feedback on user habits and task completion metrics.

---

### 🚧 Project Status: Active R&D Phase

**Phase 1 (Core Architecture)** of the application has been successfully implemented. The project is currently undergoing a **major architectural review** before Phase 2 development begins.

I am currently pausing feature development to conduct deep-dive research into **Advanced Flutter Patterns** and **System Security** to support the ambitious requirements of the next milestone.

**Current R&D Focus:**
* **State Management Optimization:** Moving beyond basic Providers to complex Family/AutoDispose patterns in Riverpod.
* **Security Architecture:** Researching AES-256 encryption implementation for local database hardening (preparing for the "Vault" feature).
* **Performance Engineering:** Benchmarking Drift (SQLite) vs. Isar for high-frequency write operations.

---

### 🛠️ Current Features (Phase 1 Complete)
* **Reactive UI:** Built with a custom "System" design language (Neon/Dark Mode) using Flutter & Google Fonts.
* **Local-First Database:** Fully offline capability using **Drift (SQLite)** with reactive streams.
* **State Management:** Decoupled business logic using **Riverpod 2.0**.
* **CRUD Operations:** Full Create, Read, Update, Delete lifecycle for Quests.

### 🔮 Roadmap (Phase 2)
* [ ] **The "Shop" Module:** Economy system for XP redemption.
* [ ] **Biometric Authentication:** FaceID/Fingerprint integration for secure access.
* [ ] **Data Migration Protocol:** JSON export/import for cross-device syncing.

---

### 💻 Local Setup
If you want to run the Phase 1 build:

1.  **Clone the repo**
    ```bash
    git clone [https://github.com/PrinceDahiya1/the_system.git](https://github.com/PrinceDahiya1/the_system.git)
    ```
2.  **Install dependencies**
    ```bash
    flutter pub get
    ```
3.  **Generate Database Code**
    ```bash
    dart run build_runner build
    ```
4.  **Run**
    ```bash
    flutter run
    ```
