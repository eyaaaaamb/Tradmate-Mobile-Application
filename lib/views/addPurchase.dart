import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../theme.dart';
import '../controllers/addpurchase_controller.dart';
import 'package:get/get.dart';
import '../widgets/custom_text_field.dart';

class AddPage extends StatelessWidget {
  AddPage({super.key});

  final AddPurchaseController controller = Get.put(AddPurchaseController());

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
                // Logo
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset('assets/images/logo.png', height: 50),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  "Add Purchase",
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Form card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product
                      CustomTextField(
                        label: "Product",
                        controller: controller.productController,
                      ),
                      const SizedBox(height: 15),

                      // Category
                      CustomTextField(
                        label: "Category",
                        controller: controller.categoryController,
                      ),
                      const SizedBox(height: 15),

                      // Purchase Date
                      Obx(() => TextButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: now,
                            firstDate: DateTime(now.year - 5),
                            lastDate: DateTime(now.year + 5),
                          );
                          if (picked != null) {
                            controller.selectedPurchaseDate.value = picked;
                          }
                        },
                        child: Text(
                          controller.selectedPurchaseDate.value == null
                              ? "Pick purchase date"
                              : "${controller.selectedPurchaseDate.value!.day}/${controller.selectedPurchaseDate.value!.month}/${controller.selectedPurchaseDate.value!.year}",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      )),
                      const SizedBox(height: 15),

                      // Purchase Price
                      CustomTextField(
                        label: "Purchase Price",
                        controller: controller.priceController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 15),

                      // Quantity
                      CustomTextField(
                        label: "Quantity",
                        controller: controller.quantityController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 25),

                      // Save button
                      Center(
                        child: Obx(() => ElevatedButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : controller.savePurchase,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade300,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: controller.isLoading.value
                              ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : const Text(
                            "Save",
                            style: TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
