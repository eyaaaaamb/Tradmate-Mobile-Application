import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';
import '../widgets/menu.dart';
import '../widgets/ProductCard.dart';
import '../controllers/history_controller.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.put(HistoryController());

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
                "Sales History",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 16),

              // Sorting
              Obx(() => DropdownButton<String>(
                value: controller.sortBy.value,
                items: const [
                  DropdownMenuItem(
                    value: "Date",
                    child: Text("Date", style: TextStyle(color: AppColors.error)),
                  ),
                  DropdownMenuItem(
                    value: "Price",
                    child: Text("Price", style: TextStyle(color: AppColors.error)),
                  ),
                  DropdownMenuItem(
                    value: "Category",
                    child: Text("Category", style: TextStyle(color: AppColors.error)),
                  ),
                ],
                onChanged: (val) {
                  if (val != null) controller.sortBy.value = val;
                },
              )),

              const SizedBox(height: 20),


              Expanded(
                child: Obx(() {
                  final sales = controller.sortedSales;

                  return ListView.separated(
                    itemCount: sales.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 15),
                    itemBuilder: (context, index) {
                      final sale = sales[index];

                      return ProductCard(
                        name: sale["name"],
                        quantity: sale["quantity"],
                        price: sale["salePrice"],

                        category: sale["category"],
                        date:
                        "${sale["saleDate"].day}/${sale["saleDate"].month}/${sale["saleDate"].year}",

                        purchasePrice: sale["purchasePrice"],
                        purchaseDate:
                        "${sale["purchaseDate"].day}/${sale["purchaseDate"].month}/${sale["purchaseDate"].year}",

                        salePrice: sale["salePrice"],
                        saleDate:
                        "${sale["saleDate"].day}/${sale["saleDate"].month}/${sale["saleDate"].year}",
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
