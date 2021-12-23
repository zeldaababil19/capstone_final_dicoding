part of 'model.dart';

class UserDetail {
  UserDetail({
    required this.error,
    required this.message,
    required this.user,
  });

  bool error;
  String message;
  UserDetailed user;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        error: json["error"],
        message: json["message"],
        user: UserDetailed.fromJson(json["User"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "User": user.toJson(),
      };
}

class UserDetailed {
  UserDetailed({
    required this.name,
    required this.email,
    required this.birthDate,
    required this.gender,
    required this.pictureId,
    required this.phone,
  });

  String name;
  String email;
  String birthDate;
  String gender;
  String pictureId;
  String phone;

  factory UserDetailed.fromJson(Map<String, dynamic> json) => UserDetailed(
        name: json["name"],
        email: json["email"],
        birthDate: json["birthDate"],
        gender: json["gender"],
        pictureId: json["pictureId"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "birthDate": birthDate,
        "gender": gender,
        "pictureId": pictureId,
        "phone": phone,
      };
}
