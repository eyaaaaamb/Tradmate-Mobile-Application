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
              // --- Titre et bouton en ligne ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
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
                      print("Sales History clicked");
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed('/historySale');
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        "Sales History",
                        style: TextStyle(
                          color: AppColors.primary,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // --- Dropdown pour trier ---
              Obx(() => DropdownButton<String>(
                value: controller.sortBy.value,
                items: const [
                  DropdownMenuItem(
                      value: "Category",
                      child: Text(
                        "Category",
                        style: TextStyle(color: AppColors.error),
                      )),
                  DropdownMenuItem(
                      value: "Month",
                      child: Text(
                        "Month",
                        style: TextStyle(color: AppColors.error),
                      )),
                  DropdownMenuItem(
                      value: "Year",
                      child: Text(
                        "Year",
                        style: TextStyle(color: AppColors.error),
                      )),
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
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
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
