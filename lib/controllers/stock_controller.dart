import 'package:get/get.dart';
import '../model/purchase_model.dart';
import '../services/firestore_service.dart';

class StockController extends GetxController {
  var stockList = <PurchaseModel>[].obs;
  var sortBy = "Category".obs;

  @override
  void onInit() {
    super.onInit();
    loadStock();
  }

  // Load stock (quantity > 0)
  void loadStock() async {
    final available = await FireStoreService.getAvailableStock();
    stockList.assignAll(available);
  }

  List<PurchaseModel> get sortedProducts {
    List<PurchaseModel> sorted = [...stockList];
    switch (sortBy.value) {
      case "Category":
        sorted.sort((a, b) => a.category.compareTo(b.category));
        break;
      case "Month":
        sorted.sort((a, b) => a.purchaseDate.month.compareTo(b.purchaseDate.month));
        break;
      case "Year":
        sorted.sort((a, b) => a.purchaseDate.year.compareTo(b.purchaseDate.year));
        break;
    }
    return sorted;
  }
}
