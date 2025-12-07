import 'package:get/get.dart';
import "./views/welcome.dart";
import "./views/login.dart";
import "./views/signup.dart";
import "./views/home.dart";
import "./views/addPurchase.dart";
import "./views/addSale.dart";
import "./views/Stock.dart";
import "./views/income.dart";
import "./views/profile.dart";
import "./views/settings.dart";
import "./views/history.dart";

import "../bindings/home_bindings.dart";




class AppRoutes{
  static final routes = [
    GetPage(name: "/" ,page: () => WelcomePage()),
    GetPage(name: "/login", page: () => LoginPage()),
    GetPage(name: "/signup", page: () => SignUpPage()),
    GetPage(name: "/home", page: () => HomePage(), binding: HomeBinding(),),
    GetPage(name: "/add", page: () => AddPage()),
    GetPage(name: "/sales", page: () => SalePage()),
    GetPage(name: "/stock", page: () => StockPage()),
    GetPage(name: "/history", page: () =>IncomePage()),
    GetPage(name: "/historySale", page: () =>HistoryPage()),
    GetPage(name: "/profile", page: () => ProfilePage()),
    GetPage(name: "/setting", page: () => SettingPage()),





  ];
}