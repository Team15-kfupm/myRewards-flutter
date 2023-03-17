
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

  // copyWith
  UserInfoModel copyWith(
      {String? uid,
      String? name,
      String? email,
      String? phone,
      DateTime? birthDate,
      String? gender}) {
    return UserInfoModel(

        uid: uid ?? this.uid,

        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender);
  }


  // from snapshot
  UserInfoModel.fromSnapshot(DocumentSnapshot snapshot)
      : uid = snapshot.get('uid'),
        name = snapshot.get('name'),
        email = snapshot.get('email'),
        phone = snapshot.get('phoneNumber'),
        birthDate = snapshot.get('birthDate'),
        gender = snapshot.get('gender');
>
}
