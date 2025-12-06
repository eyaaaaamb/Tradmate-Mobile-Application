import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';
import '../widgets/menu.dart';
import '../widgets/ProductCard.dart';
import '../controllers/stock_controller.dart';

class StockPage extends StatelessWidget {
  StockPage({super.key});

  final StockController controller = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    controller.loadStock();

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ---------- HEADER ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Stock",
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primary,
                      letterSpacing: .5,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.toNamed('/historySale'),
                    child: const Text(
                      "Sales History",
                      style: TextStyle(
                        fontSize: 14,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // ---------- FILTER LABEL + DROPDOWN ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sort by",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: AppColors.primary.withOpacity(.3)),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          offset: Offset(0, 2),
                          color: AppColors.primary.withOpacity(.05),
                        )
                      ],
                    ),
                    child: Obx(() => DropdownButton<String>(
                      value: controller.sortBy.value,
                      underline: Container(),
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                      items: const [
                        DropdownMenuItem(
                            value: "Category", child: Text("Category")),
                        DropdownMenuItem(
                            value: "Month", child: Text("Month")),
                        DropdownMenuItem(
                            value: "Year", child: Text("Year")),
                      ],
                      onChanged: (val) {
                        if (val != null) controller.sortBy.value = val;
                      },
                    )),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // ---------- PRODUCT GRID ----------
              Expanded(
                child: Obx(() {
                  final sorted = controller.sortedProducts;

                  if (sorted.isEmpty) {
                    return const Center(
                      child: Text(
                        "No products in stock",
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  }

                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 20),
                    itemCount: sorted.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 18,
                      childAspectRatio: 2.2,
                    ),
                    itemBuilder: (context, index) {
                      final product = sorted[index];
                      return ProductCard(
                        name: product.name,
                        category: product.category,
                        quantity: product.quantity,
                        price: product.price,
                        date: "${product.purchaseDate.day}/${product.purchaseDate.month}/${product.purchaseDate.year}",
                        purchasePrice: product.price,
                        purchaseDate:
                        "${product.purchaseDate.day}/${product.purchaseDate.month}/${product.purchaseDate.year}",
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
