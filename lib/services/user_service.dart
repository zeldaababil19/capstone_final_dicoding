part of 'service.dart';

final FirebaseFirestore _firebase = FirebaseFirestore.instance;
final CollectionReference _userDet = _firebase.collection('user');
final FirebaseAuth auth = FirebaseAuth.instance;
final User user = auth.currentUser!;
// user.uid;

class UserService {
  // static String? userUid;

  static Future<void> addUserDet({
    required String nama,
    required String email,
    required int phone,
    required String birthDate,
    required dynamic gender,
  }) async {
    DocumentReference document = _userDet.doc(user.uid).collection('data').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "email": email,
      "phone": phone,
      " birthDate": birthDate,
      "gender": gender,
    };

    await document
        .set(data)
        .whenComplete(
          () => print("Added succes"),
        )
        .catchError(
          (e) => print(e),
        );
  }

  static Stream readUserDet() {
    CollectionReference userDetail = _userDet.doc(user.uid).collection('data');

    return userDetail.snapshots();
  }

  UserDetailed _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDetailed(
      name: snapshot['name'],
      email: snapshot['email'],
      gender: snapshot['gender'],
      phone: snapshot['phone'],
      pictureId: snapshot['pictureId'],
      birthDate: snapshot['birthDate'],
    );
  }

  Stream<UserDetailed> get userData {
    return _userDet.doc(user.uid).collection('data').doc().snapshots().map(_userDataFromSnapshot);
  }

  static Future<void> updateUserDet({
    required String nama,
    required String email,
    required int phone,
    required String birthDate,
    required dynamic gender,
    required String idDoc,
  }) async {
    DocumentReference document = _userDet.doc(user.uid).collection('data').doc(idDoc);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "email": email,
      "phone": phone,
      " birthDate": birthDate,
      "gender": gender,
    };

    await document
        .update(data)
        .whenComplete(
          () => print("data berhasil diubah"),
        )
        .catchError(
          (onError) => print(onError),
        );
  }
}
