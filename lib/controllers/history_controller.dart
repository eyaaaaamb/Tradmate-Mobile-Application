import 'package:get/get.dart';
import '../services/firestore_service.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';

class HistoryController extends GetxController {
  var sortBy = "Date".obs;
  var sales = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  // Load only purchases that are sold out (remaining = 0)
  Future<void> loadHistory() async {
    sales.clear();

    // Load all purchases
    final purchases = await FireStoreService.purchaseRef.get();

    for (var snap in purchases.docs) {
      final purchase = snap.data();

      // Compute remaining quantity
      final remaining = await FireStoreService.getRemainingQuantity(purchase.id);

      if (remaining == 0) {
        // Load its sales
        final saleDocs = await FireStoreService.saleRef
            .where('purchaseId', isEqualTo: purchase.id)
            .get();

        for (var saleSnap in saleDocs.docs) {
          final sale = saleSnap.data();

          sales.add({
            "name": sale.name,
            "quantity": sale.quantity,
            "category": sale.category,
            "salePrice": sale.price,
            "saleDate": sale.saleDate,
            "purchasePrice": purchase.price,
            "purchaseDate": purchase.purchaseDate,
          });
        }
      }
    }
  }

  // Sorting
  List<Map<String, dynamic>> get sortedSales {
    List<Map<String, dynamic>> sorted = List.from(sales);

    switch (sortBy.value) {
      case "Price":
        sorted.sort((a, b) => (b["salePrice"] as double).compareTo(a["salePrice"]));
        break;

      case "Category":
        sorted.sort((a, b) => (a["category"] as String).compareTo(b["category"]));
        break;

      case "Date":
      default:
        sorted.sort((a, b) =>
            (b["saleDate"] as DateTime).compareTo(a["saleDate"] as DateTime));
        break;
    }

    return sorted;
  }
}
