part of 'service.dart';

final FirebaseFirestore _firebase = FirebaseFirestore.instance;
final CollectionReference _userDet = _firebase.collection('user');
final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
// user!.uid;

class UserService {
  // static String? userUid;

  static Future<void> addUserDet({
    required String nama,
    required String email,
    required int noHp,
    required String ttgl,
    required dynamic jekel,
  }) async {
    DocumentReference document = _userDet.doc(user!.uid).collection('data').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "email": email,
      "noHp": noHp,
      " ttgl": ttgl,
      "jekel": jekel,
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
    CollectionReference userDetail = _userDet.doc(user!.uid).collection('data');

    return userDetail.snapshots();
  }

  UserDetailed _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserDetailed(
      name: snapshot['name'],
      email: snapshot['email'],
      jekel: snapshot['jekel'],
      noHp: snapshot['noHp'],
      pictureId: snapshot['pictureId'],
      ttgl: snapshot['ttgl'],
    );
  }

  Stream<UserDetailed> get userData {
    return _userDet.doc(user!.uid).collection('data').doc().snapshots().map(_userDataFromSnapshot);
  }

  static Future<void> updateUserDet({
    required String nama,
    required String email,
    required int noHp,
    required String ttgl,
    required dynamic jekel,
    required String idDoc,
  }) async {
    DocumentReference document = _userDet.doc(user!.uid).collection('data').doc(idDoc);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "email": email,
      "noHp": noHp,
      " ttgl": ttgl,
      "jekel": jekel,
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
