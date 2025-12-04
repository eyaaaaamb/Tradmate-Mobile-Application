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

  PurchaseModel copyWith({
    String? id,
    String? name,
    String? category,
    DateTime? purchaseDate,
    int? quantity,
    double? price,
  }) {
    return PurchaseModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      purchaseDate: purchaseDate ?? this.purchaseDate,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }


  factory PurchaseModel.fromMap(Map<String, dynamic> data, String docId) => PurchaseModel(
    id: docId,
    name: data['name'] ?? '',
    category: data['category'] ?? '',
    purchaseDate: (data['purchaseDate'] as Timestamp).toDate(),
    quantity: data['quantity'] ?? 1,
    price: (data['price'] ?? 0).toDouble(),
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'category': category,
    'purchaseDate': Timestamp.fromDate(purchaseDate),
    'quantity': quantity,
    'price': price,
  };
}
