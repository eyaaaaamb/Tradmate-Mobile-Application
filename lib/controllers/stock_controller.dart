import 'package:get/get.dart';
import '../model/purchase_model.dart';
import '../services/firestore_service.dart';

class StockController extends GetxController {
  // Reactive list of purchases
  var purchases = <PurchaseModel>[].obs;

  // Reactive sorting value
  var sortBy = "Category".obs;

  // Subscribe to Firestore stream on init
  @override
  void onInit() {
    super.onInit();
    FireStoreService.purchaseStream().listen((data) {
      purchases.value = data; // reactive update
    });
  }

  // Get sorted purchases
  List<PurchaseModel> get sortedProducts {
    List<PurchaseModel> sortedList = List.from(purchases); // copy to avoid modifying original
    if (sortBy.value == "Category") {
      sortedList.sort((a, b) => a.category.compareTo(b.category));
    } else if (sortBy.value == "Month") {
      sortedList.sort((a, b) => a.purchaseDate.month.compareTo(b.purchaseDate.month));
    } else if (sortBy.value == "Year") {
      sortedList.sort((a, b) => a.purchaseDate.year.compareTo(b.purchaseDate.year));
    }
    return sortedList;
  }
}
