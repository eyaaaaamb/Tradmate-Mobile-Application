import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../services/translation_service.dart';

class LangController extends GetxController {
  // Default locale = English
  final Rx<Locale> _locale = const Locale('en').obs;

  Locale get locale => _locale.value; // required by GetMaterialApp

  final TranslationService _service = TranslationService();

  // Change language for both App locale + API translation
  void changeLanguage(String langCode) {
    _locale.value = Locale(langCode);

    // Update GetX locale system
    Get.updateLocale(Locale(langCode));
  }

  // API translation (optional)
  Future<String> translate(String text) async {
    if (_locale.value.languageCode == 'en') return text;
    return await _service.translate(text, _locale.value.languageCode);
  }

  // Language dialog (works the same)
  void showLanguageDialog() {
    Get.defaultDialog(
      title: "Select Language",
      content: Column(
        children: [
          _languageOption("English", "en"),
          _languageOption("Italian", "it"),
          _languageOption("French", "fr"),
          _languageOption("Arabic", "ar"),
        ],
      ),
    );
  }

  Widget _languageOption(String name, String code) {
    return ListTile(
      title: Text(name),
      onTap: () {
        changeLanguage(code);
        Get.back();
      },
    );
  }
}
