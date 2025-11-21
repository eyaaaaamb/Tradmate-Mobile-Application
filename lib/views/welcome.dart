import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/welcome_controller.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  final controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/logo2.png',
              width: 500,
              fit: BoxFit.contain,
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/images/mask.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, right: 20),
              child: Obx(() {
                return Transform.scale(
                  scale: controller.animationValue.value,
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed('/home');

                    },
                    icon: const Icon(Icons.arrow_forward, color: Colors.white,size: 50),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
