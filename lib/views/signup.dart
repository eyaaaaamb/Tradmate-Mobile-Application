import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/customBtn.dart';
import '../widgets/CustomInput.dart';
import '../theme.dart';
import 'package:country_code_picker/country_code_picker.dart';


class SignUpPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController countryController = TextEditingController();



  SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            // Main content
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
                  CustomTextField(
                    controller: emailController,
                    label: "Email",
                    hint: "Enter your email",
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      CountryCodePicker(
                        onChanged: (country) {
                          print(country.dialCode); // save the selected code if needed
                        },
                        initialSelection: 'TN',
                        favorite: ['+216','TN'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                      ),
                      Expanded(
                        child: TextField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: "Phone number",
                            hintText: "Enter your phone number",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    controller: passwordController,
                    label: "Password",
                    hint: "Enter your password",
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    controller: passwordController,
                    label: "Confirm Password",
                    hint: "Confirm your password",
                  ),
                  SizedBox(height: 40),
                  CustomButton(
                    text: "Sign Up",
                    onPressed: () {
                      // TODO: Add signup logic
                      print(
                          "Name: ${nameController.text}, Email: ${emailController.text}");
                    },
                  ),
                  SizedBox(height: 80), // leave space for bottom text
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
