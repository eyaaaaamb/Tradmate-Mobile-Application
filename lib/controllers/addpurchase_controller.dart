import 'package:flutter/material.dart';
import '../model/purchase_model.dart';
import '../services/firestore_service.dart';
import 'package:get/get.dart';

class AddPurchaseController {
  // Text controllers for form fields
  final TextEditingController productController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController idController = TextEditingController(); // optional numeric ID

  var isLoading = false.obs;

  // Dispose all controllers
  void dispose() {
    productController.dispose();
    categoryController.dispose();
    dateController.dispose();
    priceController.dispose();
    quantityController.dispose();
    idController.dispose();
  }

  // Validate form inputs
  bool validateInputs() {
    if (productController.text.isEmpty ||
        categoryController.text.isEmpty ||
        dateController.text.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return false;
    }

    // Validate numeric values
    if (double.tryParse(priceController.text) == null) {
      Get.snackbar("Error", "Price must be a number");
      return false;
    }

    if (int.tryParse(quantityController.text) == null) {
      Get.snackbar("Error", "Quantity must be a number");
      return false;
    }

    // Validate date
    final parts = dateController.text.split('/');
    if (parts.length != 3) {
      Get.snackbar("Error", "Date format should be DD/MM/YYYY");
      return false;
    }

    try {
      int.parse(parts[0]);
      int.parse(parts[1]);
      int.parse(parts[2]);
    } catch (e) {
      Get.snackbar("Error", "Date contains invalid numbers");
      return false;
    }

    // Optional: validate ID if you want numeric ID
    if (idController.text.isNotEmpty && int.tryParse(idController.text) == null) {
      Get.snackbar("Error", "ID must be a number");
      return false;
    }

    return true;
  }

  // Save purchase to Firestore
  Future<void> savePurchase() async {
    if (!validateInputs()) return;

    try {
      isLoading.value = true;

      // Parse inputs
      final String product = productController.text;
      final String category = categoryController.text;

      final parts = dateController.text.split('/');
      final DateTime purchaseDate = DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );

      final double price = double.parse(priceController.text);
      final int quantity = int.parse(quantityController.text);

      final String id = idController.text; // optional, can be empty for Firestore-generated

      // Create purchase object
      final purchase = PurchaseModel(
        id: id,
        name: product,
        category: category,
        purchaseDate: purchaseDate,
        price: price,
        quantity: quantity,
      );

      // Send to Firestore
      await FireStoreService.addPurchase(purchase);
      Get.snackbar("Success", "Purchase saved successfully");
      // --- Clear all input fields ---
      productController.clear();
      categoryController.clear();
      dateController.clear();
      priceController.clear();
      quantityController.clear();
      idController.clear();

    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
