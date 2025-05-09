# Habitu

Aplikasi manajemen kebiasaan (habit tracker) yang dibangun dengan Flutter dan GetX.

## Deskripsi

Habitu adalah aplikasi yang membantu pengguna untuk membangun dan melacak kebiasaan positif mereka. Aplikasi ini memungkinkan pengguna untuk:
- Membuat dan mengelola kebiasaan harian
- Melacak streak (rentang waktu) kebiasaan
- Melihat statistik kebiasaan
- Mengkategorikan kebiasaan berdasarkan jenis
- Mendapatkan notifikasi dan pengingat

## Preview Aplikasi

### Tampilan Utama
![Tampilan Utama](assets/preview/home.png)
*Tampilan utama aplikasi dengan daftar kebiasaan harian*

### Statistik
![Statistik](assets/preview/statistics.png)
*Halaman statistik untuk melihat progress kebiasaan*

### Pengaturan
![Pengaturan](assets/preview/settings.png)
*Halaman pengaturan aplikasi*

### Tambah Kebiasaan
![Tambah Kebiasaan](assets/preview/add_habit.png)
*Form untuk menambahkan kebiasaan baru*

## Fitur

- 🏠 **Home**: Tampilan utama untuk melihat dan mengelola kebiasaan harian
- 📊 **Statistik**: Visualisasi data kebiasaan dan progress
- ⚙️ **Pengaturan**: Konfigurasi aplikasi dan preferensi pengguna
- 🎯 **Kategori Kebiasaan**:
  - Kesehatan (🏥)
  - Produktivitas (📝)
  - Pembelajaran (📚)
  - Kebugaran (💪)
  - Kesadaran (🧘)
  - Lainnya (✨)

## Teknologi

- **Framework**: Flutter
- **State Management**: GetX
- **Local Storage**: GetStorage
- **Animasi**: Lottie
- **Internasionalisasi**: intl

## Struktur Proyek

```
lib/
├── app/
│   ├── core/
│   │   └── controllers/
│   │       └── theme_controller.dart
│   ├── data/
│   │   ├── models/
│   │   │   └── habit_model.dart
│   │   └── services/
│   │       └── habit_service.dart
│   ├── modules/
│   │   ├── home/
│   │   │   ├── bindings/
│   │   │   ├── controllers/
│   │   │   ├── views/
│   │   │   └── widgets/
│   │   ├── statistics/
│   │   └── settings/
│   ├── routes/
│   │   └── app_pages.dart
│   └── theme/
│       ├── light_theme.dart
│       └── dark_theme.dart
└── main.dart
```

## Instalasi

1. Pastikan Flutter sudah terinstal di sistem Anda
2. Clone repositori ini
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Pengembangan

### Prasyarat
- Flutter SDK
- Dart SDK
- IDE (VS Code atau Android Studio)

### Menjalankan Tests
```bash
flutter test
```

### Build Release
```bash
flutter build apk --release
```

## Kontribusi

1. Fork repositori
2. Buat branch fitur (`git checkout -b fitur/AmazingFeature`)
3. Commit perubahan (`git commit -m 'Menambahkan fitur Amazing'`)
4. Push ke branch (`git push origin fitur/AmazingFeature`)
5. Buat Pull Request

## Lisensi

Proyek ini dilisensikan di bawah Lisensi MIT - lihat file [LICENSE](LICENSE) untuk detailnya.

## Kontak

Wildan Niam - [@wildanniam](https://github.com/wildanniam)

Link Proyek: [https://github.com/wildanniam/habitu](https://github.com/wildanniam/habitu)
