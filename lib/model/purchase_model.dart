import 'package:cloud_firestore/cloud_firestore.dart';

class PurchaseModel {
  final String id;
  final String name;
  final String category;
  final DateTime purchaseDate;
  final int quantity;
  final double price;

  PurchaseModel({
    required this.id,
    required this.name,
    required this.category,
    required this.purchaseDate,
    required this.quantity,
    required this.price,
  });

  factory PurchaseModel.fromMap(Map<String, dynamic> data, String docId) {
    return PurchaseModel(
      id: docId,
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      purchaseDate: (data['purchaseDate'] as Timestamp).toDate(),
      quantity: data['quantity'] ?? 0,
      price: (data['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'purchaseDate': Timestamp.fromDate(purchaseDate),
      'quantity': quantity,
      'price': price,
    };
  }
}
