# RS-Wallpaper (Flutter)

A dynamic, automated wallpaper management application built with **Flutter** and **Bloc Architecture**, inspired by the concept of **Bing Daily Wallpaper**. The project was migrated and modernized from native Android to Flutter to offer seamless high-resolution photo browsing and automated wallpaper rotation.

---

## 🚀 Key Highlights & Features

- **Bing-Inspired Automated Rotation:** Automatically fetches and sets new wallpapers at specific scheduled intervals for the Home Screen, Lock Screen, or both.
- **Background Task Scheduling:** Utilizes **Android WorkManager** / background scheduling services to handle automated wallpaper updates even when the app is closed.
- **Curated High-Resolution Library:** Access to a vast collection of curated, high-definition photographs categorized across multiple genres.
- **Native Platform Channels:** Communicates directly with Android's native `WallpaperManager` API via Flutter Method Channels to handle lock/home screen overrides reliably.
- **Offline Caching:** Smart local caching using local storage to minimize redundant network bandwidth.

---

## 🛠 Tech Stack

- **Framework:** Flutter (Dart)
- **State Management:** BLoC (Business Logic Component) Pattern
- **Networking:** Dio, Retrofit, REST API
- **Background Execution:** Android WorkManager / Background Scheduling
- **Native Bridge:** Flutter Method Channels (Android WallpaperManager API)
- **Local Persistence:** SharedPreferences & Cached Network Storage

---

## 💡 Engineering Insights & Limitations

- **Background Execution Handling:** Implementing reliable periodic tasks on modern Android platforms requires navigating aggressive OS-level battery optimization (Doze mode, OEM restrictions). The project explores WorkManager constraints, periodic task triggers, and native fallback mechanisms to keep automated updates active across device sleep cycles.

---

## 📥 Setup & Run

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/shakibhoseen/rs-wallpaper.git](https://github.com/shakibhoseen/rs_wallpaper.git)
