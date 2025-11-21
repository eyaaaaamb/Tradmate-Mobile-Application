import 'package:flutter/material.dart';
import '../widgets/menu.dart';

class SalesPage extends StatelessWidget {
  const SalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: const Center(
        child: Text(
          "Home Page",
          style: TextStyle(fontSize: 20),
        ),
      ),

      bottomNavigationBar:  CustomBottomBar(),
    );
  }
}
