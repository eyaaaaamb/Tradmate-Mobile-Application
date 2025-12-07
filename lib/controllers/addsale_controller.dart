import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';
import '../services/firestore_service.dart';

class SaleController extends GetxController {
  var isLoading = false.obs;
  var purchases = <PurchaseModel>[].obs;
  var selectedPurchase = Rxn<PurchaseModel>();
  Rx<DateTime?> selectedSaleDate = Rx<DateTime?>(null);

  var quantityController = TextEditingController();
  var salePriceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadPurchases();
  }

  Future<void> loadPurchases() async {
    isLoading.value = true;
    final available = await FireStoreService.getAvailableStock();
    purchases.assignAll(available);
    if (available.isNotEmpty) selectedPurchase.value = available.first;
    isLoading.value = false;
  }

  /// Show calendar to pick a sale date
  Future<void> pickSaleDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 1),
    );

    if (picked != null) {
      selectedSaleDate.value = picked;
    }
  }

  Future<void> saveSale() async {
    if (selectedPurchase.value == null) {
      Get.snackbar('Error', 'Please select a product');
      return;
    }

    final quantity = int.tryParse(quantityController.text) ?? 0;
    final price = double.tryParse(salePriceController.text) ?? 0;
    final saleDate = selectedSaleDate.value ?? DateTime.now();
    final purchase = selectedPurchase.value!;

    if (quantity <= 0 || quantity > purchase.quantity) {
      Get.snackbar('Error', 'Quantity must be > 0 and ≤ available stock');
      return;
    }

    final remaining = await FireStoreService.getRemainingQuantity(purchase.id);
    if (quantity > remaining) {
      Get.snackbar('Error', 'Not enough stock available');
      return;
    }

    final profit = (price - purchase.price) * quantity;

    final sale = SaleModel(
      id: '', // Firestore generates
      purchaseId: purchase.id,
      name: purchase.name,
      category: purchase.category,
      saleDate: saleDate,
      quantity: quantity,
      price: price,
      profit: profit,
      userId: purchase.userId,
    );

    await FireStoreService.addSale(sale);

    // Clear controllers
    quantityController.clear();
    salePriceController.clear();
    selectedSaleDate.value = null;

    await loadPurchases();

    Get.snackbar('Success', 'Sale added successfully');
  }
}
