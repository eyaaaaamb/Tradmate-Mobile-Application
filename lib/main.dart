import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import './theme.dart';
import './routes.dart';
import './controllers/lang_controller.dart';
import './controllers/app_translations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register LangController globally so it's active everywhere
  Get.put(LangController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final LangController langController = Get.find<LangController>();

    return GetMaterialApp(
      title: 'TradeMate',
      theme: appTheme,
      debugShowCheckedModeBanner: false,

      // ⭐ IMPORTANT FOR TRANSLATIONS:
      translations: AppTranslations(),     // your map of translations
      locale: langController.locale,       // current language
      fallbackLocale: const Locale('en'),  // fallback if missing text

      initialRoute: '/',
      getPages: AppRoutes.routes,
    );
  }
}
