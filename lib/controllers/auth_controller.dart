import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user_model.dart';
import '../services/firestore_service.dart';


class AuthController extends GetxController {
  final firestoreService = FireStoreService();

  var user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();
    FirebaseAuth.instance.authStateChanges().listen((currentUser) {
      user.value = currentUser;
    });
  }

  void signup({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    if (password != confirmPassword) {
      Get.snackbar("Error", "Password do not match");
      return;
    }
    if (password.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters");
      return;
    }

    try {
      final newUser = UserModel(
        id: '',
        firstName: firstName,
        lastName: lastName,
        email: email,
        phone: phone,
      );
      await firestoreService.createUser(user: newUser, password: password);
      print("Email: ${newUser.email}, password: $password");

      Get.snackbar("Success", "Account created successfully");
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }

    try {
      await firestoreService.loginUser(email: email, password: password);


      Get.snackbar("Success", "Logged in successfully");
      Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Login Failed", e.toString());
    }
  }






}