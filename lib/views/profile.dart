import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

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

              // ========= PAGE CONTENT =========
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

                  // ========= PERSONAL DETAILS CARD =========
                  _sectionTitle("Personal Details"),
                  _infoCard(
                    children: [
                      _infoRow("First name", "Eya"),
                      _infoRow("Last name", "Mabrouk"),
                      _infoRow("Email", "eya@example.com"),
                      _infoRow("Phone", "+216 55 000 000"),
                    ],
                  ),

                  const SizedBox(height: 25),

                  // ========= SETTINGS CARD =========
                  _sectionTitle("Settings"),
                  _infoCard(
                    children: [
                      _settingsButton(
                        icon: Icons.lock_outline,
                        text: "Change Password",
                        onTap: () {},
                      ),
                      _settingsButton(
                        icon: Icons.language,
                        text: "Change Language",
                        onTap: () {
                        //api
                        },
                      ),
                      _settingsButton(
                        icon: Icons.logout,
                        text: "Log out",
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),

              // ========= LOGO =========
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

  // -------------------------------------
  // SMALL WIDGETS
  // -------------------------------------

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          Text(value, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }

  Widget _settingsButton({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
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
}
