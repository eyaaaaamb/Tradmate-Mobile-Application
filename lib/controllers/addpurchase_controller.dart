import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/purchase_model.dart';
import '../services/firestore_service.dart';
import 'package:get/get.dart';

class AddPurchaseController extends GetxController {
  // Text controllers for form fields
  final productController = TextEditingController();
  final categoryController = TextEditingController();
  final priceController = TextEditingController();
  final quantityController = TextEditingController();
  final idController = TextEditingController();
  final uid = FirebaseAuth.instance.currentUser!.uid;


  // Selected purchase date
  var selectedPurchaseDate = Rxn<DateTime>();

  // Loading state
  var isLoading = false.obs;

  @override
  void onClose() {
    productController.dispose();
    categoryController.dispose();
    priceController.dispose();
    quantityController.dispose();
    idController.dispose();
    super.onClose();
  }

  // Pick purchase date using calendar
  Future<void> pickPurchaseDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedPurchaseDate.value ?? now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      selectedPurchaseDate.value = picked;
    }
  }

  // Validate inputs
  bool validateInputs() {
    if (productController.text.isEmpty ||
        categoryController.text.isEmpty ||
        priceController.text.isEmpty ||
        quantityController.text.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return false;
    }

    if (double.tryParse(priceController.text) == null) {
      Get.snackbar("Error", "Price must be a number");
      return false;
    }

    if (int.tryParse(quantityController.text) == null) {
      Get.snackbar("Error", "Quantity must be a number");
      return false;
    }

    if (selectedPurchaseDate.value == null) {
      Get.snackbar("Error", "Please pick a purchase date");
      return false;
    }

    // Optional: validate numeric ID
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

      final purchase = PurchaseModel(
        id: idController.text,
        name: productController.text,
        category: categoryController.text,
        purchaseDate: selectedPurchaseDate.value!,
        price: double.parse(priceController.text),
        quantity: int.parse(quantityController.text),
        userId: uid,
      );

      await FireStoreService.addPurchase(purchase);

      Get.snackbar("Success", "Purchase saved successfully");

      // Clear fields
      productController.clear();
      categoryController.clear();
      priceController.clear();
      quantityController.clear();
      idController.clear();
      selectedPurchaseDate.value = null;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
