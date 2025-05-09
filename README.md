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
<img width="328" alt="image" src="https://github.com/user-attachments/assets/c61e08dd-4b31-4e7e-8348-e5f7b7fea834" />
<img width="327" alt="image" src="https://github.com/user-attachments/assets/c2190ef3-1903-4853-8612-f8e9770a502c" />
*Tampilan utama aplikasi dengan daftar kebiasaan harian*

### Statistik
<img width="329" alt="image" src="https://github.com/user-attachments/assets/f6760496-8008-45ba-9c60-1c6fae41ebb2" />
<img width="328" alt="image" src="https://github.com/user-attachments/assets/650f7d24-a183-40d4-90ea-3d025f2f7e3a" />
*Halaman statistik untuk melihat progress kebiasaan*

### Pengaturan
<img width="326" alt="image" src="https://github.com/user-attachments/assets/48f26dec-57b9-432b-9c3c-98b9636276bc" />
<img width="327" alt="image" src="https://github.com/user-attachments/assets/ef8810ea-ecf4-4f68-9297-849f1321ce6f" />
*Halaman pengaturan aplikasi*

### Tambah Kebiasaan
<img width="326" alt="image" src="https://github.com/user-attachments/assets/1516e5da-1587-4389-a26d-831ea66e96dd" />
<img width="326" alt="image" src="https://github.com/user-attachments/assets/aabfdaf5-f64d-4f67-8422-11b757d4f156" />
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
