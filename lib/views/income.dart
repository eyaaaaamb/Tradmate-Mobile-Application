import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/income_controllers.dart';
import '../widgets/menu.dart';
import '../theme.dart';

class IncomePage extends StatelessWidget {
  const IncomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final IncomeController controller = Get.put(IncomeController());

    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // LOGO TOP RIGHT
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                ),
              ),
              const SizedBox(height: 20),

              // PAGE TITLE
              Text(
                "Income overview",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // DROPDOWN CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View by:",
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Obx(() => DropdownButton<String>(
                      value: controller.category.value,
                      dropdownColor: Colors.white,
                      underline: SizedBox(),
                      items: const [
                        DropdownMenuItem(
                            value: "month", child: Text("Monthly")),
                        DropdownMenuItem(
                            value: "year", child: Text("Yearly")),
                      ],
                      onChanged: (val) {
                        if (val != null) controller.category.value = val;
                      },
                    )),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // LIST OF INCOME CARDS
              Obx(() {
                final data = controller.category.value == "month"
                    ? controller.monthlyIncome
                    : controller.yearlyIncome;

                return Column(
                  children: List.generate(data.length, (index) {
                    final item = data[index];

                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // TITLE
                          Text(
                            controller.category.value == "month"
                                ? item["month"]
                                : item["year"].toString(),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          // AMOUNT
                          Text(
                            "${item["income"].toStringAsFixed(2)} Dt",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
