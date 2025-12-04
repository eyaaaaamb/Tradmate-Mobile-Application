import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';
import '../widgets/menu.dart';
import '../controllers/addsale_controller.dart';
import '../model/purchase_model.dart';

class SalePage extends StatelessWidget {
  SalePage({super.key});

  final SaleController controller = Get.put(SaleController());

  Widget buildTextField(String label, TextEditingController ctrl, {String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        TextFormField(
          controller: ctrl,
          keyboardType: label == "Quantity" ? TextInputType.number : TextInputType.text,
          decoration: InputDecoration(
            hintText: hint ?? "Enter $label",
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add a Sale",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
                ),
                const SizedBox(height: 20),

                // --- Purchase Dropdown ---
                Obx(() {
                  return DropdownButton<PurchaseModel>(
                    hint: const Text("Select product"),
                    value: controller.selectedPurchase.value,
                    isExpanded: true,
                    items: controller.purchases.map((purchase) {
                      return DropdownMenuItem<PurchaseModel>(
                        value: purchase,
                        child: Text("${purchase.name} (Stock: ${purchase.quantity})"),
                      );
                    }).toList(),
                    onChanged: (val) {
                      controller.selectedPurchase.value = val;
                    },
                  );
                }),
                const SizedBox(height: 15),

                // --- Quantity & Price ---
                buildTextField("Quantity", controller.quantityController),
                const SizedBox(height: 15),
                buildTextField("Sale Price", controller.salePriceController),
                const SizedBox(height: 15),
                buildTextField("Sale Date", controller.saleDateController, hint: "DD/MM/YYYY"),
                const SizedBox(height: 25),

                // --- Save Button ---
                Center(
                  child: Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value ? null : controller.saveSale,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade400,
                        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Save Sale", style: TextStyle(fontSize: 16)),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
