import 'package:get/get.dart';
import '../services/firestore_service.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';


class HomeController extends GetxController {
  RxBool isLoading =true.obs;
  RxDouble thisMonthIncome = 0.0.obs;
  RxString bestSeller = ''.obs;
  RxString lowSeller = ''.obs;
  Future<void> loadHomeData() async {
    isLoading.value = true;
    final income = await FireStoreService.getThisMonthIncome();
    final best= await FireStoreService.getBestSeller();
    final low= await FireStoreService.getLeastSeller();
    final now=DateTime.now();
    final key = "${now.year}-${now.month.toString().padLeft(2, '0')}" ;
    thisMonthIncome.value = income;
    bestSeller.value = best['name'] ?? 'No data';
    lowSeller.value = low['name'] ?? 'No data';
  }
  @override
  void onInit() {
    super.onInit();
    FireStoreService.saleRef.snapshots().listen((_) {
      loadHomeData(); // Refresh home stats automatically
    });
    FireStoreService.purchaseRef.snapshots().listen((_) {
      loadHomeData(); // Refresh when purchase changes
    });
    loadHomeData();
  }
  @override
  void onClose() {
    super.onClose();
  }




}