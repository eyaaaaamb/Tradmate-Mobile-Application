import 'package:flutter/material.dart';
import '../widgets/menu.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: const Center(
        child: Text(
          "profile Page",
          style: TextStyle(fontSize: 20),
        ),
      ),

      bottomNavigationBar:  CustomBottomBar(),
    );
  }
}
