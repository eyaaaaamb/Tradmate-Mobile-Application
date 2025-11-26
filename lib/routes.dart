import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "./views/welcome.dart";
import "./views/login.dart";
import "./views/signup.dart";
import "./views/home.dart";
import "./views/addPurchase.dart";
import "./views/addSale.dart";
import "./views/Stock.dart";
import "./views/SalesHistory.dart";
import "./views/profile.dart";
import "./views/settings.dart";




class AppRoutes{
  static final routes = [
    GetPage(name: "/" ,page: () => WelcomePage()),
    GetPage(name: "/login", page: () => LoginPage()),
    GetPage(name: "/signup", page: () => SignUpPage()),
    GetPage(name: "/home", page: () => HomePage()),
    GetPage(name: "/add", page: () => AddPage()),
    GetPage(name: "/sales", page: () => SalesPage()),
    GetPage(name: "/stock", page: () => StockPage()),
    GetPage(name: "/history", page: () =>IncomePage()),
    GetPage(name: "/profile", page: () => ProfilePage()),
    GetPage(name: "/setting", page: () => SettingPage()),




  ];
}