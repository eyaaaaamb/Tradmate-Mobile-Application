import 'package:flutter/material.dart';
import '../widgets/menu.dart';
import '../theme.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: CustomBottomBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo at top-right
                Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: 50,
                  ),
                ),
                const SizedBox(height: 20),

                // Title
                Text(
                  "Add Purchase",
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                // Form card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildTextField("Product"),
                      const SizedBox(height: 15),
                      buildTextField("Category"),
                      const SizedBox(height: 15),
                      buildTextField("Date", hint: "DD/MM/YYYY"),
                      const SizedBox(height: 15),
                      buildTextField("Purchase Price", keyboardType: TextInputType.number),
                      const SizedBox(height: 15),
                      buildTextField("Quantity", keyboardType: TextInputType.number),
                      const SizedBox(height: 25),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink.shade300,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(fontSize: 16,color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label,
      {TextInputType keyboardType = TextInputType.text, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 6),
        TextFormField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint ?? "Enter $label",
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
