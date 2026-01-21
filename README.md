# 🚀 Gaming Hub Android 2026

Gaming Hub adalah aplikasi pusat kontrol game modern untuk Android yang dibangun dengan **Flutter**. Aplikasi ini mengintegrasikan manajemen library game, pemantauan performa real-time, dan berita diskon game menggunakan Firebase.

## ✨ Fitur Utama
- **Game Library Manager:** Deteksi otomatis dan peluncuran game yang terinstal di perangkat.
- **Performance Dashboard:** Monitoring suhu baterai, penggunaan RAM, dan status sistem secara real-time.
- **Playtime Tracker:** Mencatat durasi sesi bermain menggunakan database lokal SQLite.
- **Smart Notifications:** Integrasi Firebase Cloud Messaging (FCM) untuk info diskon game (Steam/PlayStore).
- **Game Discovery:** Menampilkan tren game terbaru menggunakan [RAWG API](https://rawg.io).

## 🛠️ Teknologi yang Digunakan
- **Framework:** Flutter (2026 Version)
- **Database:** [SQLite](https://pub.dev)
- **Backend:** [Firebase](https://firebase.google.com) (Cloud Messaging & Analytics)
- **API:** RAWG Video Games Database
- **UI Style:** Glassmorphism & Dark Gaming Theme

## 📦 Instalasi & Penggunaan
1. **Clone repositori:**
   ```bash
   git clone https://github.com

## Setup Firebase:
Tambahkan google-services.json milik Anda ke android/app/.
### Instal dependencies:
flutter pub get

### Jalankan aplikasi:
flutter run

## 📝 Catatan Keamanan
API Key dan konfigurasi Firebase tidak disertakan dalam repositori ini. Silakan gunakan kunci API Anda sendiri dari RAWG.io.

### Langkah Push ke GitHub (Terminal)
Gunakan perintah ini untuk mengunggah proyek pertama kali:

```bash
git init
git add .
git commit -m "Initial commit: Gaming Hub 2026 with Firebase & SQLite"
git branch -M main
git remote add origin https://github.com
git push -u origin main
