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
    // Listen to purchases in real-time
    FireStoreService.purchaseRef.snapshots().listen((purchaseSnap) async {
      List<Map<String, dynamic>> updatedHistory = [];

      for (var pDoc in purchaseSnap.docs) {
        final purchase = pDoc.data() as PurchaseModel;

        // await is allowed here
        final remaining = await FireStoreService.getRemainingQuantity(purchase.id);

        if (remaining == 0) {
          // get all sales linked to this purchase
          final saleSnap = await FireStoreService.saleRef
              .where('purchaseId', isEqualTo: purchase.id)
              .get();
          for (var sDoc in saleSnap.docs) {
            final sale = sDoc.data() as SaleModel;

            updatedHistory.add({
              "name": purchase.name,
              "category": purchase.category,
              "quantity": sale.quantity,
              "purchasePrice": purchase.price,
              "purchaseDate": purchase.purchaseDate,
              "salePrice": sale.price,
              "saleDate": sale.saleDate,
              "profit": sale.profit,
            });
          }
        }
      }

      // update observable list
      sales.value = updatedHistory;
    });
  }

  List<Map<String, dynamic>> get sortedSales {
    List<Map<String, dynamic>> sorted = List.from(sales);

    switch (sortBy.value) {
      case "Price":
        sorted.sort((a, b) => (b["salePrice"] as double).compareTo(a["salePrice"]));
        break;

      case "Category":
        sorted.sort((a, b) => (a["category"] as String).compareTo(b["category"]));
        break;

      default:
        sorted.sort((a, b) => (b["saleDate"] as DateTime).compareTo(a["saleDate"]));
        break;
    }

    return sorted;
  }
}
