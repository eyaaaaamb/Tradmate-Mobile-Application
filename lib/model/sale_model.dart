import 'package:cloud_firestore/cloud_firestore.dart';

class SaleModel {
  final String id;
  final String purchaseId; // ID of the linked purchase
  final int quantity;
  final DateTime saleDate;
  final double price;

  SaleModel({
    required this.id,
    required this.purchaseId,
    required this.quantity,
    required this.saleDate,
    required this.price,
  });

  factory SaleModel.fromMap(Map<String, dynamic> data, String docId) {
    return SaleModel(
      id: docId,
      purchaseId: data['purchaseId'] ?? '',
      quantity: data['quantity'] ?? 0,
      saleDate: (data['saleDate'] as Timestamp).toDate(),
      price: (data['price'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseId': purchaseId,
      'quantity': quantity,
      'saleDate': Timestamp.fromDate(saleDate),
      'price': price,
    };
  }
}
