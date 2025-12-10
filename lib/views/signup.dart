import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/customBtn.dart';
import '../widgets/CustomInput.dart';
import '../theme.dart';
import '../controllers/auth_controller.dart';

class SignUpPage extends StatelessWidget {
  final controller = Get.put(AuthController());
  // Controllers
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main scrollable content
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80), // space for top icons
                  Text(
                    "Hey ,",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Sign up now",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  SizedBox(height: 50),

                  // First & Last Name
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: fnameController,
                          label: "Fname",
                          hint: "First name",
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: CustomTextField(
                          controller: lnameController,
                          label: "Lname",
                          hint: "Last name",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),

                  // Email
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    hint: "Enter your email",
                  ),

                  SizedBox(height: 30),

                  // Password
                  CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    hint: "Enter your password",
                  ),
                  SizedBox(height: 30),

                  // Confirm Password
                  CustomTextField(
                    controller: confirmPasswordController,
                    label: "Confirm Password",
                    hint: "Confirm your password",
                  ),
                  SizedBox(height: 40),

                  // Sign Up Button
                  CustomButton(
                    text: "Sign Up",
                    onPressed: () {
                      controller.signup(
                        firstName: fnameController.text.trim(),
                        lastName: lnameController.text.trim(),
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        confirmPassword: confirmPasswordController.text.trim(),

                      );

                    },
                  ),

                  SizedBox(height: 80), // space for bottom text
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
                  Get.back();
                },
              ),
            ),

            // Logo top-right
            Positioned(
              top: 16,
              right: 16,
              child: Image.asset(
                'assets/images/logo.png',
                height: 50,
              ),
            ),

            // Bottom text
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: GestureDetector(
                onTap: () {
                  Get.toNamed('/login');
                },
                child: Text(
                  "Already have an account? Login",
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
