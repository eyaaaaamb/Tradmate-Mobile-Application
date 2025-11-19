// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart'; // GetX for routing
import 'firebase_options.dart';
import './views/welcome.dart';
import './theme.dart';
import './routes.dart';   // centralized routes

void main() async {
  // Ensure Flutter binding is initialized before using async code
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'TradeMate',
      theme: appTheme,                // your custom theme
      debugShowCheckedModeBanner: false,
      initialRoute: '/',              // starting page
      getPages: AppRoutes.routes,     // centralized routes from AppRoutes
    );
  }
}
