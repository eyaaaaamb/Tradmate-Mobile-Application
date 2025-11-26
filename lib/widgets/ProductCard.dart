import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';


class ProductCard extends StatelessWidget {
  final String name;
  final int quantity;
  final double price;
  final String category;
  final String date;

  const ProductCard({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PRODUCT NAME ---
            Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 10),

            // --- CATEGORY ---
            _iconTextRow(
              icon: Icons.category,
              label: "Catégorie",
              value: "Alimentation", // statique temporaire
            ),

            const SizedBox(height: 6),

            // --- QUANTITY ---
            _iconTextRow(
              icon: Icons.inventory_2_outlined,
              label: "Qty",
              value: quantity.toString(),
            ),

            const SizedBox(height: 6),

            // --- PRICE ---
            _iconTextRow(
              icon: Icons.attach_money,
              label: "Prix unitaire",
              value: "${price.toStringAsFixed(2)} DT",
            ),

            const SizedBox(height: 6),

            // --- DATE ---
            _iconTextRow(
              icon: Icons.calendar_today,
              label: "Date d'achat",
              value: "12/11/2025", // statique temporaire
            ),
          ],
        ),
      ),
    );
  }

  // Small reusable row widget
  Widget _iconTextRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 6),
        Text(
          "$label : ",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
        ),
        Expanded(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
