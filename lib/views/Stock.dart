import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';
import '../widgets/menu.dart';
import '../widgets/ProductCard.dart';
import '../controllers/stock_controller.dart';
import '../services/firestore_service.dart';

class StockPage extends StatelessWidget {
  StockPage({super.key});

  // Put your controller
  final StockController controller = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    // Load available stock when the page builds
    controller.loadStock();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Title and Sales History button ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Stock",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/historySale'); // navigate to sales history
                    },
                    child: const Text(
                      "Sales History",
                      style: TextStyle(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // --- Dropdown for sorting ---
              Obx(() => DropdownButton<String>(
                value: controller.sortBy.value,
                items: const [
                  DropdownMenuItem(
                    value: "Category",
                    child: Text(
                      "Category",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Month",
                    child: Text(
                      "Month",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                  DropdownMenuItem(
                    value: "Year",
                    child: Text(
                      "Year",
                      style: TextStyle(color: AppColors.error),
                    ),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) controller.sortBy.value = val;
                },
              )),
              const SizedBox(height: 20),

              // --- List of Purchases ---
              Expanded(
                child: Obx(() {
                  final sorted = controller.sortedProducts;
                  if (sorted.isEmpty) {
                    return const Center(
                        child: Text(
                          "No products in stock",
                          style: TextStyle(
                              fontSize: 16, color: AppColors.primary),
                        ));
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: sorted.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 15,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, index) {
                      final product = sorted[index];
                      return ProductCard(
                        name: product.name,
                        category: product.category,
                        quantity: product.quantity,
                        price: product.price,
                        date:
                        "${product.purchaseDate.day}/${product.purchaseDate.month}/${product.purchaseDate.year}",
                        purchasePrice: product.price,
                        purchaseDate:
                        "${product.purchaseDate.day}/${product.purchaseDate.month}/${product.purchaseDate.year}",
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
