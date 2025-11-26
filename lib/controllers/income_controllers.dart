import 'package:get/get.dart';

class IncomeController extends GetxController {
  // Liste de toutes les ventes avec date et montant
  var sales = <Map<String, dynamic>>[].obs;

  // Catégorie d'affichage: "month" ou "year"
  var category = "month".obs;

  @override
  void onInit() {
    super.onInit();
    // Exemple de ventes (date: yyyy-mm-dd)
    sales.addAll([
      {"date": DateTime(2024, 11, 3), "amount": 120.0},
      {"date": DateTime(2024, 11, 15), "amount": 200.0},
      {"date": DateTime(2024, 12, 5), "amount": 150.0},
      {"date": DateTime(2025, 1, 10), "amount": 300.0},
      {"date": DateTime(2025, 2, 7), "amount": 250.0},
      {"date": DateTime(2025, 2, 20), "amount": 400.0},
    ]);
  }

  // Calculer revenus par mois pour une année donnée
  List<Map<String, dynamic>> getMonthlyIncome(int year) {
    Map<String, double> monthIncome = {};
    for (var sale in sales) {
      final date = sale["date"] as DateTime;
      if (date.year == year) {
        final monthName = _monthName(date.month);
        monthIncome[monthName] = (monthIncome[monthName] ?? 0) + sale["amount"];
      }
    }
    return monthIncome.entries
        .map((e) => {"month": e.key, "income": e.value})
        .toList();
  }

  // Calculer revenus par année
  List<Map<String, dynamic>> getYearlyIncome() {
    Map<int, double> yearIncome = {};
    for (var sale in sales) {
      final date = sale["date"] as DateTime;
      yearIncome[date.year] = (yearIncome[date.year] ?? 0) + sale["amount"];
    }
    return yearIncome.entries
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
