import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String gender;

  UserInfoModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.birthDate,
    required this.gender,
  });

  // from snapshot
  UserInfoModel.fromSnapshot(DocumentSnapshot userDoc)
      : uid = userDoc.id,
        name = userDoc.get('name'),
        email = userDoc.get('email'),
        phone = userDoc.get('phone'),
        birthDate = DateTime.parse(userDoc.get('birth_date')),
        gender = userDoc.get('gender');
}
