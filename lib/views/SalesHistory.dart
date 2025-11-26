import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';
import '../widgets/menu.dart';
import '../controllers/income_controllers.dart';

class IncomePage extends StatelessWidget {
  IncomePage({super.key});

  final IncomeController controller = Get.put(IncomeController());

  final RxInt selectedYear = DateTime.now().year.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Income History",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              const SizedBox(height: 20),

              // Choix de catégorie
              Obx(() => Row(
                children: [
                  ChoiceChip(
                    label: const Text("By Month"),
                    selected: controller.category.value == "month",
                    onSelected: (_) => controller.category.value = "month",
                  ),
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: const Text("By Year"),
                    selected: controller.category.value == "year",
                    onSelected: (_) => controller.category.value = "year",
                  ),
                ],
              )),

              const SizedBox(height: 20),

              // Sélecteur d'année si catégorie "month"
              Obx(() {
                if (controller.category.value == "month") {
                  // Extraire toutes les années disponibles
                  final years = controller.sales.map((s) => (s["date"] as DateTime).year).toSet().toList()..sort();
                  return DropdownButton<int>(
                    value: selectedYear.value,
                    items: years.map((y) => DropdownMenuItem(
                      value: y,
                      child: Text(y.toString()),
                    )).toList(),
                    onChanged: (v) {
                      if (v != null) selectedYear.value = v;
                    },
                  );
                }
                return Container();
              }),

              const SizedBox(height: 20),

              // Liste des revenus
              Expanded(
                child: Obx(() {
                  final category = controller.category.value;
                  final data = category == "month"
                      ? controller.getMonthlyIncome(selectedYear.value)
                      : controller.getYearlyIncome();

                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (_, i) {
                      final item = data[i];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              category == "month" ? item["month"] : item["year"].toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            Text(
                              "${item["income"].toStringAsFixed(2)} DT",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
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
