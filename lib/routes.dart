import 'package:flutter/material.dart';
import 'package:get/get.dart';
import "./views/welcome.dart";
import "./views/login.dart";

class AppRoutes{
  static final routes = [
    GetPage(name: "/" ,page: () => WelcomePage()),
    GetPage(name: "/login", page: () => LoginPage()),
  ];
}