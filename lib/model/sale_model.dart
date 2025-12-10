import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel {
  final String id;
  final String purchaseId;
  final String name;
  final String category;
  final DateTime saleDate;
  final int quantity;
  final double price;
 final double profit;
  final String userId;


  SaleModel({
    required this.id,
    required this.purchaseId,
    required this.name,
    required this.category,
    required this.saleDate,
    required this.quantity,
    required this.price,
    required this.profit,
    required this.userId,
  });

  factory SaleModel.fromMap(Map<String, dynamic> data, String docId) {
    return SaleModel(
      id: docId,
      purchaseId: data['purchaseId'],
      name: data['name'] ?? '',
      category: data['category'] ?? '',
      saleDate: (data['saleDate'] as Timestamp).toDate(),
      quantity: data['quantity'] ?? 1,
      price: (data['price'] ?? 0).toDouble(),
      profit: (data['profit'] ?? 0).toDouble(),
      userId: data['userId'] ?? '',

    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseId': purchaseId,
      'name': name,
      'category': category,
      'saleDate': Timestamp.fromDate(saleDate),
      'quantity': quantity,
      'price': price,
      'profit': profit,
      'userId': userId,
    };
  }
}
