import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String id;
  final String storeName;
  final String bankName;
  final double amount;
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.storeName,
    required this.amount,
    required this.date,
    required this.bankName,
  });

  TransactionModel.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> transactionMap)
      : id = transactionMap.id,
        storeName = transactionMap.data()['store_name'],
        amount = transactionMap.data()['amount'],
        date = DateTime.parse(transactionMap.data()['date']),
        bankName = transactionMap.data()['bank_name'];
}
