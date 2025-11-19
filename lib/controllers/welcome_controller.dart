import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// WelcomeController handles the arrow pulse animation on the WelcomePage.
/// It keeps the arrow icon scaling in and out continuously while the page is visible.
class WelcomeController extends GetxController with GetTickerProviderStateMixin {
  // -----------------------------
  // 1️⃣ Animation controller
  // -----------------------------
  // This is the "engine" of the animation.
  // It tells Flutter how long the animation lasts and manages the time.
  late AnimationController animationController;

  // -----------------------------
  // 2️⃣ Tween animation
  // -----------------------------
  // Tween defines the range of values for the animation.
  // Here we animate a scale from 1.0 (normal size) to 1.2 (slightly bigger).
  late Animation<double> scaleAnimation;

  // -----------------------------
  // 3️⃣ Reactive variable
  // -----------------------------
  // RxDouble is a "reactive" variable from GetX.
  // Whenever it changes, widgets that use Obx will rebuild automatically.
  var animationValue = 1.0.obs;

  // -----------------------------
  // 4️⃣ onInit
  // -----------------------------
  // This function runs automatically when the controller is created.
  // We set up and start the animation here.
  @override
  void onInit() {
    super.onInit();

    // -----------------------------
    // Step 1: Initialize the AnimationController
    // -----------------------------
    animationController = AnimationController(
      vsync: this,                // required for animations
      duration: Duration(seconds: 1), // how long one pulse takes
    );

    // -----------------------------
    // Step 2: Create the Tween (scale animation)
    // -----------------------------
    scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(
        parent: animationController, // animationController drives the tween
        curve: Curves.easeInOut,     // makes the animation smooth
      ),
    )
    // -----------------------------
    // Step 3: Listen to animation changes
    // -----------------------------
    // Every time the animation value changes, we update our reactive variable.
    // Obx in the widget will automatically rebuild the icon with the new scale.
      ..addListener(() {
        animationValue.value = scaleAnimation.value;
      });

    // -----------------------------
    // Step 4: Repeat the animation forever (in and out)
    // -----------------------------
    // reverse: true means it will grow -> shrink -> grow -> shrink continuously
    animationController.repeat(reverse: true);
  }

  // -----------------------------
  // 5️⃣ onClose
  // -----------------------------
  // This function runs automatically when the controller is removed from memory.
  // We use it to dispose the animation controller to free memory.
  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
