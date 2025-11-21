import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../theme.dart';

class StockPage extends StatelessWidget {
  const StockPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: Text("heelo"));
  }
}
