import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../model/user_model.dart';
import '../services/firestore_service.dart';

class ProfileController extends GetxController {
  // Observable user
  var user = UserModel(
    id : "",
    firstName: '',
    lastName: '',
    email: '',

  ).obs;

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  // ---------------- FETCH USER ----------------
  void fetchUser() async {
    final uid = auth.currentUser?.uid;
    if (uid != null) {
      try {
        final u = await FireStoreService.getUserInfo(uid);
        user.value = u;
      } catch (e) {
        print("Error fetching user: $e");
      }
    }
  }

  // ---------------- LOGOUT ----------------
  void logout() async {
    await auth.signOut();
    Fluttertoast.showToast(
      msg: "Logged out successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );

    // Navigate to login page
    Get.offAllNamed('/login');
  }

  // ---------------- CONFIRM LOGOUT ----------------
  void confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // Cancel
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close dialog
              logout(); // Call the logout method
            },
            child: const Text(
              "Log out",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
