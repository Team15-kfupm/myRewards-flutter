class UserInfoModel {
  final String name;
  final String email;
  final String phone;
  final DateTime birthDate;
  final String gender;

  UserInfoModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.birthDate,
      required this.gender});

  UserInfoModel copyWith(
      {String? name,
      String? email,
      String? phone,
      DateTime? birthDate,
      String? gender}) {
    return UserInfoModel(
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        birthDate: birthDate ?? this.birthDate,
        gender: gender ?? this.gender);
  }
}
