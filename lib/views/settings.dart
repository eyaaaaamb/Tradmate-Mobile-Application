import 'package:flutter/material.dart';
import '../widgets/menu.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: const Center(
        child: Text(
          "setting Page",
          style: TextStyle(fontSize: 20),
        ),
      ),

      bottomNavigationBar:  CustomBottomBar(),
    );
  }
}
