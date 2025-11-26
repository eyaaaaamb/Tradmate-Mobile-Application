import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme.dart';

class ProductCard extends StatelessWidget {
  final String name;
  final int quantity;
  final double price; // sale price
  final String category;
  final String date; // purchase date
  final double? purchasePrice;
  final String? purchaseDate;
  final double? salePrice;
  final String? saleDate;

  const ProductCard({
    super.key,
    required this.name,
    required this.quantity,
    required this.price,
    required this.category,
    required this.date,
    this.purchasePrice,
    this.purchaseDate,
    this.salePrice,
    this.saleDate,
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
              value: category,
            ),
            const SizedBox(height: 6),

            // --- QUANTITY ---
            _iconTextRow(
              icon: Icons.inventory_2_outlined,
              label: "Qty",
              value: quantity.toString(),
            ),
            const SizedBox(height: 6),

            // --- PURCHASE PRICE ---
            if (purchasePrice != null)
              _iconTextRow(
                icon: Icons.attach_money,
                label: "Prix d'achat",
                value: "${purchasePrice!.toStringAsFixed(2)} DT",
              ),
            if (purchasePrice != null) const SizedBox(height: 6),

            // --- PURCHASE DATE ---
            if (purchaseDate != null)
              _iconTextRow(
                icon: Icons.calendar_today,
                label: "Date d'achat",
                value: purchaseDate!,
              ),
            if (purchaseDate != null) const SizedBox(height: 6),

            // --- SALE PRICE ---
            if (salePrice != null)
              _iconTextRow(
                icon: Icons.attach_money,
                label: "Prix de vente",
                value: "${salePrice!.toStringAsFixed(2)} DT",
              ),
            if (salePrice != null) const SizedBox(height: 6),

            // --- SALE DATE ---
            if (saleDate != null)
              _iconTextRow(
                icon: Icons.calendar_today,
                label: "Date de vente",
                value: saleDate!,
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
