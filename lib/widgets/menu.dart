import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 95,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background bar
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFDCE8FF),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
            ),
          ),

          // Floating center button
          Positioned(
            top: -25,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Show popup
                  Get.bottomSheet(
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                      ),
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.shopping_cart),
                            title: const Text('Add Purchase'),
                            onTap: () {
                              Get.back(); // Close the bottom sheet
                              Get.toNamed('/add');
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.attach_money),
                            title: const Text('Add Sale'),
                            onTap: () {
                              Get.back();
                              Get.toNamed('/sales');
                            },
                          ),
                        ],
                      ),
                    ),
                    isScrollControlled: true,
                  );
                },
                child: Container(
                  height: 85,
                  width: 85,
                  decoration: BoxDecoration(
                    color: const Color(0xFF6366F1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
          ),

          // Icons row
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.dashboard_outlined, size: 30),
                    onPressed: () => Get.toNamed('/home'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.list_alt_rounded, size: 30),
                    onPressed: () => Get.toNamed('/stock'),
                  ),
                  const SizedBox(width: 55),
                  IconButton(
                    icon: const Icon(Icons.monetization_on_outlined, size: 30),
                    onPressed: () => Get.toNamed('/history'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_outline, size: 30),
                    onPressed: () => Get.toNamed('/profile'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
