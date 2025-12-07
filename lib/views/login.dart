import 'package:flutter/material.dart';
import '../widgets/CustomInput.dart';
import 'package:get/get.dart';
import '../theme.dart';
import '../widgets/customBtn.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main column content
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80), // leave space for top icons
                  Text(
                    "Hey ,",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color:AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Login now",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color:AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 50),
                  CustomTextField(
                    controller: emailController,
                    label: 'Email',
                    hint: 'Enter your email',
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    controller: passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    text: "Login",
                    onPressed: () {
                     controller.login(
                         email: emailController.text.trim(),
                         password: passwordController.text.trim(),
                     );



                    },
                  ),
                  Spacer(),
                ],
              ),
            ),

            // Back arrow top-left
            Positioned(
              top: 16,
              left: 16,
              child: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Get.toNamed('/'); // navigate back to welcome page
                },
              ),
            ),

            // Logo top-right
            Positioned(
              top: 16,
              right: 16,
              child: Image.asset(
                'assets/images/logo.png', // replace with your logo path
                height: 50,
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/signup');
                },
                child: Text(
                  "Don't have an account? Sign up",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
