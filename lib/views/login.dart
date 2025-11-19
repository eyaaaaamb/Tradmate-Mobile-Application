import 'package:flutter/material.dart';
import '../widgets/CustomInput.dart' ;
import 'package:get/get.dart';
import '../theme.dart';

class LoginPage extends StatelessWidget {

  final TextEditingController Controller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hey"),
            SizedBox(height:10),
            Text("Login now"),
            SizedBox(height:40),
            CustomTextField(
              controller: Controller,
              label: 'Email',
              hint: 'Enter your email',
            ),
            SizedBox(height:40),
            CustomTextField(
              controller: Controller,
              label: 'Password',
              hint: 'Enter your password',

            ),
            SizedBox(height:40),
          ],
        ),
      ),
    );
  }
}
