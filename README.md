Anime Center App - UTS Mobile Application Development
Aplikasi Anime Center adalah proyek ujian tengah semester (UTS) yang dikembangkan menggunakan Flutter. Aplikasi ini memungkinkan pengguna untuk menjelajahi daftar anime berdasarkan musim dan tahun secara real-time dengan integrasi Jikan API.

📱 Fitur Utama
Filter Musim & Tahun: Menampilkan anime berdasarkan kategori waktu yang spesifik.
Pencarian Real-time: Mencari judul anime tanpa menghambat kinerja UI (Asynchronous).
Sistem Favorit Global: Menyimpan anime favorit yang tetap tersimpan meskipun aplikasi ditutup (Persistent Storage).
Offline Readiness: Menampilkan data terakhir yang berhasil dimuat saat tidak ada koneksi internet.
Shimmer Effect: Transisi loading yang halus untuk meningkatkan User Experience.

🏗️ Struktur Folder (Modular Structure)
Proyek ini menggunakan pola arsitektur MVVM (Model-View-ViewModel) untuk memisahkan logika bisnis dari antarmuka pengguna:
lib/models/: Berisi blueprint data (Anime). Bertanggung jawab untuk parsing data dari JSON API.
lib/services/: Menangani komunikasi dengan API menggunakan Dio. Di sini juga diimplementasikan logika Deduplication untuk memastikan tidak ada ID anime yang ganda.
lib/providers/: Mengelola state aplikasi menggunakan Provider. Mengatur logika favorit, pencarian, dan penanganan error.
lib/views/: Folder untuk UI layar utama (HomeScreen) dan layar favorit (FavoritesScreen).
lib/widgets/: Berisi komponen UI yang dapat digunakan kembali (Reusable Widgets) seperti AnimeCard untuk efisiensi kode.

🧠 Pemilihan State Management: Provider
Saya memilih Provider sebagai solusi State Management karena:
Efisiensi: Mengurangi proses rebuild widget yang tidak perlu dengan notifyListeners().
Kemudahan Maintenance: Memisahkan logika data dari UI secara bersih, sehingga fitur baru (seperti filter tahun) dapat ditambahkan tanpa merusak fitur lama.
Global State: Memudahkan sinkronisasi data favorit di berbagai halaman secara konsisten.

🛠️ Penanganan Error & Offline Readiness
Sesuai dengan prinsip Responsible Attitude (A) dan Offline Readiness (P):
Error Handling: Aplikasi tidak akan menampilkan kode error teknis yang membingungkan. Sebaliknya, aplikasi menampilkan pesan ramah pengguna dan tombol Retry jika API gagal dimuat.
Caching: Menggunakan shared_preferences untuk menyimpan data secara lokal. Jika koneksi terputus, aplikasi akan secara otomatis memuat data terakhir yang tersimpan di memori perangkat.
