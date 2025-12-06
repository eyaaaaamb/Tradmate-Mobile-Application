import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/income_controllers.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final IncomeController controller = Get.put(IncomeController());

    return Scaffold(
      appBar: AppBar(title: const Text("Income")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Obx(() => DropdownButton<String>(
              value: controller.category.value,
              items: const [
                DropdownMenuItem(value: "month", child: Text("Monthly")),
                DropdownMenuItem(value: "year", child: Text("Yearly")),
              ],
              onChanged: (val) {
                if (val != null) controller.category.value = val;
              },
            )),
            const SizedBox(height: 20),
            Expanded(
              child: Obx(() {
                final data = controller.category.value == "month"
                    ? controller.monthlyIncome
                    : controller.yearlyIncome;

                return ListView.separated(
                  itemCount: data.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = data[index];
                    return ListTile(
                      title: Text(controller.category.value == "month"
                          ? item["month"]
                          : item["year"].toString()),
                      trailing: Text("\$${item["income"].toStringAsFixed(2)}"),
                    );
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
