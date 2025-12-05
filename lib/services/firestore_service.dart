import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';

class FireStoreService {
  static final purchaseRef = FirebaseFirestore.instance
      .collection('purchase')
      .withConverter<PurchaseModel>(
    fromFirestore: (snap, _) => PurchaseModel.fromMap(snap.data()!, snap.id),
    toFirestore: (purchase, _) => purchase.toMap(),
  );

  static final saleRef = FirebaseFirestore.instance
      .collection('sale').withConverter<SaleModel>(
    fromFirestore: (snap, _) => SaleModel.fromMap(snap.data()!, snap.id),
    toFirestore: (sale, _) => sale.toMap(),


  );

  // Add purchase
  static Future<void> addPurchase(PurchaseModel purchase) async {
    if (purchase.id.isEmpty) {
      await purchaseRef.add(purchase);
    } else {
      await purchaseRef.doc(purchase.id).set(purchase);
    }
  }

  // Get remaining quantity of a purchase

  static Future<int> getRemainingQuantity(String purchaseId) async {
    final purchaseSnap = await purchaseRef.doc(purchaseId).get();
    final purchase = purchaseSnap.data();
    if (purchase == null) return 0;

    final purchasedQty = purchase.quantity;

    // Load all sales for this purchase
    final salesSnap = await saleRef
        .where('purchaseId', isEqualTo: purchaseId)
        .get();

    int soldQty = 0;

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      soldQty += sale.quantity;  // <-- FIX: accumulate sold quantity
    }

    return purchasedQty - soldQty;
  }
// Get products where remaining quantity = 0
  static Future<List<Map<String, dynamic>>> getSoldOutHistory() async {
    final purchasesSnap = await purchaseRef.get();
    final salesSnap = await saleRef.get();

    List<Map<String, dynamic>> history = [];

    for (var doc in purchasesSnap.docs) {
      final purchase = doc.data();

      // Calculate remaining
      final remaining = await getRemainingQuantity(purchase.id);

      if (remaining == 0) {
        // Collect all sales for this purchase
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
          });
        }
      }
    }

    return history;
  }

  // Get available stock (quantity > 0)
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

  // Add sale
  static Future<void> addSale(SaleModel sale) async {
    if (sale.id.isEmpty) {
      await saleRef.add(sale);
    } else {
      await saleRef.doc(sale.id).set(sale);
    }
  }

  // Get all sales
  static Future<List<SaleModel>> getSales() async {
    final sales = await saleRef.get();
    return sales.docs.map((doc) => doc.data()).toList();
  }
}
