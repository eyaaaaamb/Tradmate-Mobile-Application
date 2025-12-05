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
    listenToHistory();
  }

  void listenToHistory() {
    // Listen to purchases AND sales together
    FireStoreService.purchaseRef.snapshots().listen((purchaseSnap) async {
      sales.clear();

      for (var p in purchaseSnap.docs) {
        final purchase = p.data();

        final remaining = await FireStoreService.getRemainingQuantity(purchase.id);

        if (remaining == 0) {
          FireStoreService.saleRef
              .where('purchaseId', isEqualTo: purchase.id)
              .snapshots()
              .listen((saleSnap) {
            for (var s in saleSnap.docs) {
              final sale = s.data();

              final item = {
                "name": sale.name,
                "quantity": sale.quantity,
                "category": sale.category,
                "salePrice": sale.price,
                "saleDate": sale.saleDate,
                "purchasePrice": purchase.price,
                "purchaseDate": purchase.purchaseDate,
              };

              // Avoid duplicates
              if (!sales.contains(item)) {
                sales.add(item);
              }
            }
          });
        }
      }
    });
  }

  List<Map<String, dynamic>> get sortedSales {
    List<Map<String, dynamic>> sorted = List.from(sales);

    switch (sortBy.value) {
      case "Price":
        sorted.sort((a, b) => (b["salePrice"] as double).compareTo(a["salePrice"]));
        break;

      case "Category":
        sorted.sort((a, b) =>
            (a["category"] as String).compareTo(b["category"]));
        break;

      default:
        sorted.sort((a, b) =>
            (b["saleDate"] as DateTime).compareTo(a["saleDate"]));
        break;
    }

    return sorted;
  }
}
