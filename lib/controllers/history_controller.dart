import 'package:get/get.dart';

class HistoryController extends GetxController {
  // Sorting criterion: Date, SalePrice, or Category
  RxString sortBy = "Date".obs;

  // Example sales data including purchase and sale info
  RxList<Map<String, dynamic>> sales = <Map<String, dynamic>>[
    {
      "name": "Notebook",
      "quantity": 3,
      "category": "Stationery",
      "purchasePrice": 10.0,
      "purchaseDate": DateTime(2025, 10, 28),
      "salePrice": 15.0,
      "saleDate": DateTime(2025, 11, 1),
    },
    {
      "name": "Pen",
      "quantity": 10,
      "category": "Stationery",
      "purchasePrice": 1.5,
      "purchaseDate": DateTime(2025, 10, 20),
      "salePrice": 2.5,
      "saleDate": DateTime(2025, 11, 5),
    },
    {
      "name": "Sticker",
      "quantity": 5,
      "category": "Decor",
      "purchasePrice": 1.0,
      "purchaseDate": DateTime(2025, 10, 15),
      "salePrice": 1.5,
      "saleDate": DateTime(2025, 10, 28),
    },
  ].obs;

  // Returns the sorted list according to the criterion
  List<Map<String, dynamic>> get sortedSales {
    List<Map<String, dynamic>> sorted = List.from(sales);

    switch (sortBy.value) {
      case "Date":
        sorted.sort((a, b) => (b["saleDate"] as DateTime).compareTo(a["saleDate"] as DateTime));
        break;
      case "Price":
        sorted.sort((a, b) => (b["salePrice"] as double).compareTo(a["salePrice"] as double));
        break;
      case "Category":
        sorted.sort((a, b) => (a["category"] as String).compareTo(b["category"] as String));
        break;
    }

    return sorted;
  }

}
