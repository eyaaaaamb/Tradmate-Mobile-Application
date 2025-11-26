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
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Stock",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // --- Dropdown pour trier ---
              Obx(() => DropdownButton<String>(
                value: controller.sortBy.value,
                items: const [
                  DropdownMenuItem(value: "Category", child: Text("Category")),
                  DropdownMenuItem(value: "Month", child: Text("Month")),
                  DropdownMenuItem(value: "Year", child: Text("Year")),
                ],
                onChanged: (val) {
                  if (val != null) controller.sortBy.value = val;
                },
              )),

              const SizedBox(height: 20),

              // --- Liste des produits ---
              Expanded(
                child: Obx(() {
                  final sorted = controller.sortedProducts;
                  return GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: sorted.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 15,
                      childAspectRatio: 2,
                    ),
                    itemBuilder: (context, index) {
                      final product = sorted[index];
                      return ProductCard(
                        name: product["name"],
                        quantity: product["quantity"],
                        price: product["price"],
                        category: product["category"],
                        date:
                        "${(product["date"] as DateTime).day}/${(product["date"] as DateTime).month}/${(product["date"] as DateTime).year}",
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
