import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class FireStoreService {
  static final purchaseRef = FirebaseFirestore.instance
      .collection('purchase')
      .withConverter<PurchaseModel>(
    fromFirestore: (snap, _) => PurchaseModel.fromMap(snap.data()!, snap.id),
    toFirestore: (purchase, _) => purchase.toMap(),
  );

  static final saleRef = FirebaseFirestore.instance
      .collection('sale')
      .withConverter<SaleModel>(
    fromFirestore: (snap, _) => SaleModel.fromMap(snap.data()!, snap.id),
    toFirestore: (sale, _) => sale.toMap(),
  );


  // ---------------- ADD PURCHASE ----------------
  static Future<void> addPurchase(PurchaseModel purchase) async {
    if (purchase.id.isEmpty) {
      await purchaseRef.add(purchase);
    } else {
      await purchaseRef.doc(purchase.id).set(purchase);
    }
  }

  // ---------------- REMAINING QUANTITY ----------------
  static Future<int> getRemainingQuantity(String purchaseId) async {
    final purchaseSnap = await purchaseRef.doc(purchaseId).get();
    final purchase = purchaseSnap.data();
    if (purchase == null) return 0;

    final purchasedQty = purchase.quantity;

    final salesSnap = await saleRef.where('purchaseId', isEqualTo: purchaseId).get();

    int soldQty = 0;
    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      soldQty += sale.quantity;
    }

    return purchasedQty - soldQty;
  }

  // ---------------- SOLD OUT HISTORY ----------------
  static Stream<List<Map<String, dynamic>>> getSoldOutHistoryStream() {
    return purchaseRef.snapshots().asyncMap((purchasesSnap) async {
      final salesSnap = await saleRef.get(); // sales could also be a stream if you want fully real-time

      List<Map<String, dynamic>> history = [];

      for (var doc in purchasesSnap.docs) {
        final purchase = doc.data();
        final remaining = await getRemainingQuantity(purchase.id);

        if (remaining == 0) {
          final productSales = salesSnap.docs
              .map((e) => e.data())
              .where((sale) => sale.purchaseId == purchase.id)
              .toList();

          for (var sale in productSales) {
            history.add({
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

      return history;
    });
  }


  // ---------------- AVAILABLE STOCK ----------------
  static Future<List<PurchaseModel>> getAvailableStock() async {
    final snapshot = await purchaseRef.get();
    List<PurchaseModel> result = [];

    for (var doc in snapshot.docs) {
      final purchase = doc.data();
      final remaining = await getRemainingQuantity(purchase.id);

      if (remaining > 0) {
        result.add(purchase.copyWith(quantity: remaining));
      }
    }
    return result;
  }

  // ---------------- ADD SALE ----------------
  static Future<void> addSale(SaleModel sale) async {
    if (sale.id.isEmpty) {
      await saleRef.add(sale);
    } else {
      await saleRef.doc(sale.id).set(sale);
    }
  }

  // ---------------- GET ALL SALES ----------------
  static Future<List<SaleModel>> getSales() async {
    final sales = await saleRef.get();
    return sales.docs.map((doc) => doc.data()).toList();
  }

  // ---------------- PROFIT FUNCTIONS ----------------

  // Monthly profit
  static Future<Map<String, double>> getMonthlyProfit() async {
    final salesSnap = await saleRef.get();
    Map<String, double> monthlyProfit = {};

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      final key = "${sale.saleDate.year}-${sale.saleDate.month.toString().padLeft(2, '0')}";
      monthlyProfit[key] = (monthlyProfit[key] ?? 0) + sale.profit;
    }

    return monthlyProfit;
  }

  // Yearly profit
  static Future<Map<int, double>> getYearlyProfit() async {
    final salesSnap = await saleRef.get();
    Map<int, double> yearlyProfit = {};

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      final year = sale.saleDate.year;
      yearlyProfit[year] = (yearlyProfit[year] ?? 0) + sale.profit;
    }

    return yearlyProfit;
  }
  static Future<double> getThisMonthIncome() async {
    final salesSnap = await saleRef.get();
    double total = 0.0;

    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      final saleDate = sale.saleDate;
      print(saleDate); // DateTime field

      if (saleDate.year == currentYear && saleDate.month == currentMonth) {
        total += sale.profit;
        print(total);
      }
    }

    return total;
  }



  // Best seller by profit
  static Future<Map<String, dynamic>> getBestSeller() async {
    final salesSnap = await saleRef.get();
    Map<String, double> productProfit = {};

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      productProfit[sale.name] = (productProfit[sale.name] ?? 0) + sale.profit;
    }

    if (productProfit.isEmpty) return {};

    final best = productProfit.entries.reduce((a, b) => a.value > b.value ? a : b);
    return {'name': best.key, 'profit': best.value};
  }

  // Least seller by profit
  static Future<Map<String, dynamic>> getLeastSeller() async {
    final salesSnap = await saleRef.get();
    Map<String, double> productProfit = {};

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      productProfit[sale.name] = (productProfit[sale.name] ?? 0) + sale.profit;
    }

    if (productProfit.isEmpty) return {};

    final least = productProfit.entries.reduce((a, b) => a.value < b.value ? a : b);
    return {'name': least.key, 'profit': least.value};
  }
}
