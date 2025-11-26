import 'package:get/get.dart';
import '../app_texts.dart';
import '../services/translation_service.dart';

class AppTranslations extends Translations {
  static Map<String, String> en = appTexts; // your default map
  static Map<String, String> fr = {};       // will be filled dynamically
  static Map<String, String> ar = {};       // same

  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'fr': fr,
    'ar': ar,
  };

  // Load translations dynamically using API
  static Future<void> loadTranslations(String langCode) async {
    final service = TranslationService();
    Map<String, String> targetMap;

    if (langCode == 'fr') targetMap = fr;
    else if (langCode == 'ar') targetMap = ar;
    else return;

    for (var entry in en.entries) {
      targetMap[entry.key] = await service.translate(entry.value, langCode);
    }
  }
}
