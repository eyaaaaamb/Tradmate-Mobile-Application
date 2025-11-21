import 'package:flutter/material.dart';
import '../widgets/menu.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: const Center(
        child: Text(
          "History Page",
          style: TextStyle(fontSize: 20),
        ),
      ),

      bottomNavigationBar:  CustomBottomBar(),
    );
  }
}
