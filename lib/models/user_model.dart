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
    required this.ttgl,
    required this.jekel,
    required this.pictureId,
    required this.noHp,
  });

  String name;
  String email;
  String ttgl;
  String jekel;
  String pictureId;
  String noHp;

  factory UserDetailed.fromJson(Map<String, dynamic> json) => UserDetailed(
        name: json["name"],
        email: json["email"],
        ttgl: json["ttgl"],
        jekel: json["jekel"],
        pictureId: json["pictureId"],
        noHp: json["noHp"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "ttgl": ttgl,
        "jekel": jekel,
        "pictureId": pictureId,
        "noHp": noHp,
      };
}
