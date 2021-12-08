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
    required this.tgl,
    required this.kelamin,
    required this.pictureId,
    required this.noHp,
  });

  String name;
  String email;
  String tgl;
  String kelamin;
  String pictureId;
  String noHp;

  factory UserDetailed.fromJson(Map<String, dynamic> json) => UserDetailed(

        name: json["name"],
        email: json["email"],
        tgl: json["tgl"],
        kelamin: json["kelamin"],
        pictureId: json["pictureId"],
        noHp: json["noHp"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "tgl": tgl,
        "kelamin": kelamin,
        "pictureId": pictureId,
        "noHp": noHp,
      };
}