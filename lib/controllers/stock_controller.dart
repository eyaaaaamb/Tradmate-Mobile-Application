import 'package:get/get.dart';

class StockController extends GetxController {
  // Liste de produits
  var products = <Map<String, dynamic>>[].obs;

  // Valeur du tri: "Category", "Month", "Year"
  var sortBy = "Category".obs;

  @override
  void onInit() {
    super.onInit();
    // Exemple de produits
    products.addAll(List.generate(8, (index) {
      return {
        "name": "Product $index",
        "quantity": 12,
        "price": 8.5,
        "category": index % 2 == 0 ? "Alimentation" : "Bricolage",
        "date": DateTime(2025, (index % 12) + 1, 12),
      };
    }));
  }

  // Liste triée selon sortBy
  List<Map<String, dynamic>> get sortedProducts {
    List<Map<String, dynamic>> temp = List.from(products);
    if (sortBy.value == "Category") {
      temp.sort((a, b) => a["category"].compareTo(b["category"]));
    } else if (sortBy.value == "Month") {
      temp.sort((a, b) => (a["date"] as DateTime).month.compareTo((b["date"] as DateTime).month));
    } else if (sortBy.value == "Year") {
      temp.sort((a, b) => (a["date"] as DateTime).year.compareTo((b["date"] as DateTime).year));
    }
    return temp;
  }
}
