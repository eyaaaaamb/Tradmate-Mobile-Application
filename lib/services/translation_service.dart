import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  // LibreTranslate free demo endpoint
  final String apiUrl = 'https://libretranslate.com/translate';

  // Translate a given text to a target language
  Future<String> translate(String text, String targetLang) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "q": text,
          "source": "en",
          "target": targetLang
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['translatedText'];
      } else {
        throw Exception('Failed to translate. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print("Translation error: $e");
      return text; // fallback: return original text if API fails
    }
  }
}
