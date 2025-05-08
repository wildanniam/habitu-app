import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Habitu',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}
