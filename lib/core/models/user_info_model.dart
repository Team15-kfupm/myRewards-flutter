import 'package:cloud_firestore/cloud_firestore.dart';

class UserInfoModel {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String gender;
  final Map points;
  final int totalPoints;

  UserInfoModel(
      {required this.uid,
      required this.name,
      required this.email,
      required this.phone,
      required this.birthDate,
      required this.gender,
      required this.points,
      required this.totalPoints});

  // from snapshot
  UserInfoModel.fromDocument(DocumentSnapshot userDoc)
      : uid = userDoc.id,
        name = userDoc.get('name'),
        email = userDoc.get('email'),
        phone = userDoc.get('phone'),
        birthDate = DateTime.parse(userDoc.get('birth_date')),
        gender = userDoc.get('gender'),
        points = userDoc.get('points'),
        totalPoints = userDoc.get('total_points');

  static UserInfoModel fromSnapshot(DocumentSnapshot snapshot) {
    return UserInfoModel(
        name: snapshot['name'],
        email: snapshot['email'],
        birthDate: DateTime.parse(snapshot['birth_date']),
        gender: snapshot['gender'],
        phone: snapshot['phone'],
        uid: snapshot.id,
        points: snapshot['points'],
        totalPoints: snapshot['total_points']);
  }
}
