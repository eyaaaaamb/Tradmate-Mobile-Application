import 'package:get/get.dart';
import '../services/firestore_service.dart';
import '../model/sale_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
class IncomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var category = "month".obs; // month/year
  var sales = <SaleModel>[].obs; // reactive sales list
  var monthlyIncome = <Map<String, dynamic>>[].obs;
  var yearlyIncome = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    listenToSales();
  }

  void listenToSales() {
    final userId = _auth.currentUser?.uid;
    FireStoreService.saleRef.where('userId',isEqualTo : userId).snapshots().listen((saleSnap) {
      final loadedSales = saleSnap.docs.map((doc) => doc.data()).toList();
      sales.value = loadedSales;

      calculateMonthlyIncome();
      calculateYearlyIncome();
    });
  }

  void calculateMonthlyIncome({int year = -1}) {
    if (year == -1 && sales.isNotEmpty) {
      year = sales.first.saleDate.year;
    }

    Map<String, double> monthIncome = {};
    for (var sale in sales) {
      final date = sale.saleDate;
      if (date.year == year) {
        final monthName = _monthName(date.month);
        monthIncome[monthName] = (monthIncome[monthName] ?? 0) + sale.price;
      }
    }

    monthlyIncome.value = monthIncome.entries
        .map((e) => {"month": e.key, "income": e.value})
        .toList();
  }

  void calculateYearlyIncome() {
    Map<int, double> yearIncome = {};
    for (var sale in sales) {
      final date = sale.saleDate;
      yearIncome[date.year] = (yearIncome[date.year] ?? 0) + sale.price;
    }

    yearlyIncome.value = yearIncome.entries
        .map((e) => {"year": e.key, "income": e.value})
        .toList();
  }

  String _monthName(int month) {
    const names = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    ];
    return names[month - 1];
  }
}
