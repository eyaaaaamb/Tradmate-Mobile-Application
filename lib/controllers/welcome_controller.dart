import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation;
  var animationValue = 1.0.obs;


  @override
  void onInit() {
    super.onInit();


    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    )

      ..addListener(() {
        animationValue.value = scaleAnimation.value;
      });
    animationController.repeat(reverse: true);
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
