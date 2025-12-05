import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';
import '../services/firestore_service.dart';

class SaleController extends GetxController {
  // Loading state
  var isLoading = false.obs;

  // List of available purchases
  var purchases = <PurchaseModel>[].obs;

  // Selected purchase
  var selectedPurchase = Rxn<PurchaseModel>();

  // Form controllers
  var quantityController = TextEditingController();
  var salePriceController = TextEditingController();
  var saleDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadPurchases();
  }

  // Load available stock for selection
  Future<void> loadPurchases() async {
    isLoading.value = true;
    final available = await FireStoreService.getAvailableStock();
    purchases.assignAll(available);
    if (available.isNotEmpty) selectedPurchase.value = available.first;
    isLoading.value = false;
  }

  // Save a sale
  Future<void> saveSale() async {
    if (selectedPurchase.value == null) {
      Get.snackbar('Error', 'Please select a product');
      return;
    }

    final quantity = int.tryParse(quantityController.text) ?? 0;
    final price = double.tryParse(salePriceController.text) ?? 0;
    final saleDate = DateTime.tryParse(saleDateController.text) ?? DateTime.now();

    if (quantity <= 0 || quantity > selectedPurchase.value!.quantity) {
      Get.snackbar('Error', 'Quantity must be greater than zero and less than available stock');
      return;
    }

    // Check remaining stock
    final remaining = await FireStoreService.getRemainingQuantity(selectedPurchase.value!.id);
    if (quantity > remaining) {
      Get.snackbar('Error', 'Not enough stock available');
      return;
    }

    final sale = SaleModel(
      id: '',
      purchaseId: selectedPurchase.value!.id,
      name: selectedPurchase.value!.name,
      category: selectedPurchase.value!.category,
      saleDate: saleDate,
      quantity: quantity,
      price: price,
    );

    await FireStoreService.addSale(sale);

    // Clear form
    quantityController.clear();
    salePriceController.clear();
    saleDateController.clear();

    // Reload stock
    await loadPurchases();

    Get.snackbar('Success', 'Sale added successfully');
  }

}
