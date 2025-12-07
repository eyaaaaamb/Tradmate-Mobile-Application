import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/menu.dart';
import '../theme.dart';
import '../controllers/lang_controller.dart';
import '../controllers/profile_controller.dart';





class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController controller = Get.put(ProfileController());
  final LangController langController = Get.put(LangController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "Your Profile",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Personal Details
                  _sectionTitle("Personal Details"),
                  _infoCard(
                    children: [
                      _infoRow("First name", controller.user.value.firstName),
                      _infoRow("Last name", controller.user.value.lastName),
                      _infoRow("Email", controller.user.value.email),

                    ],
                  ),

                  const SizedBox(height: 25),

                  // Settings
                  _sectionTitle("Settings"),
                  _infoCard(
                    children: [
                     // _settingsButton(
                      //  icon: Icons.lock_outline,
                      //  text: "Change Password",
                      //  onTap: () {},
                     // ),
                     // _settingsButton(
                      //  icon: Icons.language,
                      //  text: "Change Language",
                       // onTap: () => langController.showLanguageDialog(),
                     // ),
                      _settingsButton(
                        icon: Icons.logout,
                        text: "Log out",
                        onTap: () => controller.confirmLogout(context),
                      ),
                    ],
                  ),
                ],
              ),

              // Logo
              Positioned(
                top: 10,
                right: 10,
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Small widgets
  Widget _sectionTitle(String text) => Text(
    text,
    style: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  );

  Widget _infoCard({required List<Widget> children}) => Container(
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.only(top: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: AppColors.primary.withOpacity(0.3)),
    ),
    child: Column(children: children),
  );

  Widget _infoRow(String label, String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
        Text(value, style: const TextStyle(fontSize: 15)),
      ],
    ),
  );

  Widget _settingsButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) =>
      ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      );
}
