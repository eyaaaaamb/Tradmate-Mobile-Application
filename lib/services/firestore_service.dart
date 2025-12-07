import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';
import 'package:get/get.dart';



class FireStoreService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final uid = FirebaseAuth.instance.currentUser!.uid;
  static final CollectionReference userRef = _firestore.collection('users');



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
  static Future<UserModel> getUserInfo(String id) async {
    final userSnap = await userRef.doc(id).get();
    final data = userSnap.data() as Map<String, dynamic>;
    return UserModel.fromMap(data, userSnap.id);
  }


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

    final salesSnap = await saleRef.where('purchaseId', isEqualTo: purchaseId).where('userId',isEqualTo : uid).get();

    int soldQty = 0;
    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      soldQty += sale.quantity;
    }

    return purchasedQty - soldQty;
  }




  // ---------------- AVAILABLE STOCK ----------------
  static Future<List<PurchaseModel>> getAvailableStock() async {
    final snapshot = await purchaseRef.where('userId',isEqualTo : uid).get();
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
    final sales = await saleRef.where('userId',isEqualTo : uid).get();
    return sales.docs.map((doc) => doc.data()).toList();
  }

  // ---------------- PROFIT FUNCTIONS ----------------

  // Monthly profit
  static Future<Map<String, double>> getMonthlyProfit() async {
    final salesSnap = await saleRef.where('userId',isEqualTo : uid).orderBy('saleDate').get();
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
    final salesSnap = await saleRef.where('userId',isEqualTo : uid).orderBy('saleDate').get();
    Map<int, double> yearlyProfit = {};

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      final year = sale.saleDate.year;
      yearlyProfit[year] = (yearlyProfit[year] ?? 0) + sale.profit;
    }

    return yearlyProfit;
  }
  // FireStoreService
  static String get currentUid => FirebaseAuth.instance.currentUser!.uid;

// Example usage
  static Future<double> getThisMonthIncome() async {
    final salesSnap = await saleRef.where('userId', isEqualTo: currentUid).get();
    double total = 0.0;
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      final saleDate = sale.saleDate;
      if (saleDate.year == currentYear && saleDate.month == currentMonth) {
        total += sale.profit;
      }
    }

    return total;
  }



  // Best seller by profit
  static Future<Map<String, dynamic>> getBestSeller() async {
    final salesSnap = await saleRef.where('userId',isEqualTo : uid).get();
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
    final salesSnap = await saleRef.where('userId',isEqualTo : uid).get();
    Map<String, double> productProfit = {};

    for (var doc in salesSnap.docs) {
      final sale = doc.data();
      productProfit[sale.name] = (productProfit[sale.name] ?? 0) + sale.profit;
    }

    if (productProfit.isEmpty) return {};

    final least = productProfit.entries.reduce((a, b) => a.value < b.value ? a : b);
    return {'name': least.key, 'profit': least.value};
  }
  //user related
//sign up
   Future<void> createUser({
    required UserModel user,
   required String password,
}) async {
    try{
      //s 1 create user in f auth
      final cred= await auth.createUserWithEmailAndPassword(email: user.email, password: password);
      //2save user info
      await _firestore.collection('users').doc(cred.user!.uid).set(user.toMap());
     print("Account created successfully");
    }catch (e){
    print(e);
    }
 }
  Future<UserCredential> loginUser({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


}




