import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionsByMonthModel {
  final String month;
  final Map<String, double> categories;
  TransactionsByMonthModel({required this.month, required this.categories});

  TransactionsByMonthModel.fromDoc(
      QueryDocumentSnapshot<Map<String, dynamic>> transactionMap)
      : categories = {
          'restaurant':
              transactionMap.data()['categories']['restaurant'] ?? 0.0,
          'cafe': transactionMap.data()['categories']['cafe'] ?? 0.0,
          'entertainment':
              transactionMap.data()['categories']['entertainment'] ?? 0.0,
          'shoppings': transactionMap.data()['categories']['shopping'] ?? 0.0,
          'travel': transactionMap.data()['categories']['travel'] ?? 0.0,
          'other': transactionMap.data()['categories']['other'] ?? 0.0,
        },
        month = transactionMap.id.substring(5);
}
