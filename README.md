
### **Proyek UTS - Lab Mobile Application Development**

**Nama:** Jimmy 
**NPM:** 2331052
**Repositori:** [CobalFloyd/UTS-Lab-Mob-Dev](https://github.com/CobalFloyd/UTS-Lab-Mob-Dev)

-----

## 📖 Deskripsi Proyek

**Anime Center** adalah aplikasi mobile berbasis Flutter yang mengintegrasikan Jikan API (MyAnimeList) untuk menyajikan informasi anime musiman secara *real-time*. Aplikasi ini dirancang untuk memberikan pengalaman navigasi yang mulus dengan fitur pencarian dan sistem penyimpanan favorit yang persisten.

-----

## 🏗️ Struktur Folder (Modular Structure)

Proyek ini mengadopsi struktur folder modular untuk memastikan pemisahan logika (Separation of Concerns) sesuai dengan prinsip C6:

  * **`lib/models/`**: Definisi skema data `Anime`. Mengatur konversi dari JSON ke objek Dart.
  * **`lib/services/`**: Menangani permintaan HTTP ke API. Termasuk logika **Deduplication** untuk menyaring data ganda dari API.
  * **`lib/providers/`**: Pusat logika bisnis (ViewModel). Mengatur state loading, error handling, dan sinkronisasi data antar screen.
  * **`lib/views/`**: Kumpulan layar utama aplikasi (`HomeScreen`, `FavoritesScreen`).
  * **`lib/widgets/`**: Komponen UI yang dapat digunakan kembali (*Reusable Widgets*) seperti `AnimeCard`.

-----

## 🛠️ Fitur Teknis

1.  **Asynchronous Features (P)**: Menggunakan pola `async/await` untuk fetching data sehingga UI tetap responsif (tidak *freeze*).
2.  **Filter Dinamis**: Memungkinkan filter berdasarkan **Tahun** dan **Musim** secara bersamaan.
3.  **Real-time Search**: Fitur pencarian judul anime yang bekerja secara instan pada daftar yang sedang dimuat.
4.  **Visual Consistency**: Implementasi **Shimmer Effect** sebagai *placeholder* kreatif saat data sedang diambil dari server.

-----

## 🧠 State Management: Provider

Saya memilih **Provider** sebagai State Management karena:

  * **Clean Code**: Memisahkan logika data dari file UI secara total.
  * **Efisiensi**: Hanya me-*rebuild* widget yang membutuhkan data baru melalui `notifyListeners()`.
  * **Global Access**: Memudahkan akses daftar favorit dari halaman mana pun tanpa perlu mempassing data secara manual.

-----

## 🛡️ Penanganan Error & Offline Readiness

  * **Offline Access**: Menggunakan `shared_preferences` untuk menyimpan cache data terakhir. Jika koneksi internet hilang, aplikasi tetap menampilkan data terakhir yang berhasil dimuat.
  * **User-Friendly Error**: Alih-alih menampilkan kode error teknis, aplikasi menampilkan pesan ramah pengguna dan tombol **Retry** untuk mencoba kembali (Responsible Attitude).
