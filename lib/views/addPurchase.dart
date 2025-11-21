import 'package:flutter/material.dart';
import '../widgets/menu.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: const Center(
        child: Text(
          "add Page",
          style: TextStyle(fontSize: 20),
        ),
      ),

      bottomNavigationBar:  CustomBottomBar(),
    );
  }
}
