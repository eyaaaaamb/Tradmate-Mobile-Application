import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              // Logo at top-right
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                ),
              ),

              const SizedBox(height: 20),

              // "Your sales insights" text
              Text(
                "Your sales insights :",
                style: TextStyle(
                  fontSize: 24,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.lightBlue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("This month's income  :", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color:Colors.black)),
                        SizedBox(height: 8),
                        Text("3000 \$", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color:Colors.deepPurple)),
                      ],
                    ),
                    Column(
                      children: const [
                        Text("+ 32 % " ,style: TextStyle(color:AppColors.error,fontSize: 22)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Chart container placeholder
              Container(
                width: double.infinity,
                height: 200, // placeholder height
                decoration: BoxDecoration(
                  color: AppColors.lightBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text("Chart will go here"),
                ),
              ),

              const SizedBox(height: 20),

              // Income container

              const SizedBox(height: 20),

              // Row with best and least sold products
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Best product"),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 120,
                      margin: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: AppColors.lightBlue.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text("Least sold product"),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
