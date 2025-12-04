import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';

class FireStoreService {
  static final purchaseRef = FirebaseFirestore.instance.collection('purchase').withConverter<PurchaseModel>(
    fromFirestore: (snap, _) => PurchaseModel.fromMap(snap.data()!, snap.id),
    toFirestore: (purchase, _) => purchase.toMap(),
  );

  static final saleRef = FirebaseFirestore.instance.collection('sale').withConverter<SaleModel>(
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

  // Update purchase
  static Future<void> updatePurchase(PurchaseModel purchase) async {
    await purchaseRef.doc(purchase.id).set(purchase);
  }

  // Stream purchases
  static Stream<List<PurchaseModel>> purchaseStream() {
    return purchaseRef.snapshots().map(
          (snap) => snap.docs.map((doc) => doc.data()).toList(),
    );
  }

  // Add sale
  static Future<void> addSale(SaleModel sale) async {
    if (sale.id.isEmpty) {
      await saleRef.add(sale);
    } else {
      await saleRef.doc(sale.id).set(sale);
    }
  }
}
