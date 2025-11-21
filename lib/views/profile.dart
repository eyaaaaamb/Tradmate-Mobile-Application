import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../theme.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      // Correct place for bottomNavigationBar
      bottomNavigationBar: CustomBottomBar(),

      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding:EdgeInsetsGeometry.all(20),
              child: Container(), // required child, empty
            ),

            Positioned(
              top: 16,
              right: 16,
              child: Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
            ),

            Positioned(
              top: 30,
              left: 20,
              right: 0,
              child: Text("Your profile : ",
                  style:TextStyle(fontSize: 24,color: AppColors.primary,fontWeight:FontWeight.bold )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
