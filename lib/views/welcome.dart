import 'package:flutter/material.dart';
import '../theme.dart'; // if you want to use AppColors
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background, // optional
      body: Stack(
        children: [
          // 1. Centered logo
          Center(
            child: Image.asset(
              'assets/images/logo2.png',
              width: 500, // adjust size
              fit: BoxFit.contain,
            ),
          ),

          // 2. Mask at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/mask.png',
              width: MediaQuery.of(context).size.width, // full width
              fit: BoxFit.cover, // or BoxFit.contain depending on your design
            ),
          ),
        ],
      ),
    );
  }
}
