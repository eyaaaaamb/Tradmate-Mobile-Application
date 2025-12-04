import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/purchase_model.dart';
import '../model/sale_model.dart';
import '../services/firestore_service.dart';

class SaleController extends GetxController {
  var isLoading = false.obs;

  // Purchases for dropdown
  var purchases = <PurchaseModel>[].obs;

  // Selected purchase
  var selectedPurchase = Rxn<PurchaseModel>();

  // Controllers
  final quantityController = TextEditingController();
  final salePriceController = TextEditingController();
  final saleDateController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPurchases();
  }

  void fetchPurchases() {
    FireStoreService.purchaseStream().listen((data) {
      // Only show purchases with stock
      purchases.value = data.where((p) => p.quantity > 0).toList();
    });
  }

  bool validateInputs() {
    if (selectedPurchase.value == null) {
      Get.snackbar("Error", "Please select a product");
      return false;
    }

    if (quantityController.text.isEmpty || int.tryParse(quantityController.text) == null) {
      Get.snackbar("Error", "Quantity must be a number");
      return false;
    }

    if (salePriceController.text.isEmpty || double.tryParse(salePriceController.text) == null) {
      Get.snackbar("Error", "Sale price must be a number");
      return false;
    }

    final quantity = int.parse(quantityController.text);
    if (quantity > selectedPurchase.value!.quantity) {
      Get.snackbar("Error", "Not enough stock");
      return false;
    }

    final parts = saleDateController.text.split('/');
    if (parts.length != 3) {
      Get.snackbar("Error", "Date format should be DD/MM/YYYY");
      return false;
    }

    try {
      int.parse(parts[0]);
      int.parse(parts[1]);
      int.parse(parts[2]);
    } catch (_) {
      Get.snackbar("Error", "Invalid date");
      return false;
    }

    return true;
  }

  Future<void> saveSale() async {
    if (!validateInputs()) return;

    try {
      isLoading.value = true;
      final purchase = selectedPurchase.value!;
      final int quantity = int.parse(quantityController.text);
      final double salePrice = double.parse(salePriceController.text);

      final parts = saleDateController.text.split('/');
      final DateTime saleDate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );

      final sale = SaleModel(
        id: "",
        purchaseId: purchase.id,
        name: purchase.name,
        category: purchase.category,
        saleDate: saleDate,
        quantity: quantity,
        price: salePrice,
      );

      await FireStoreService.addSale(sale);

      // Update stock using copyWith
      final updatedPurchase = purchase.copyWith(quantity: purchase.quantity - quantity);
      await FireStoreService.updatePurchase(updatedPurchase);

      Get.snackbar("Success", "Sale recorded successfully");

      // Clear form
      selectedPurchase.value = null;
      quantityController.clear();
      salePriceController.clear();
      saleDateController.clear();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
