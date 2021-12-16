part of 'util.dart';

class Authentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<FirebaseApp> initializeFirebase({required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          // builder: (context) => UserInfoScreen(user: user),
          builder: (context) => HomePage(),
        ),
      );
    }
    return firebaseApp;
  }

  static Future<UserCredential> signInWithGoogle() async {
    // FirebaseAuth auth = FirebaseAuth.instance;
    // User? user;

    // final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
    // if (googleSignInAccount != null) {
    //   final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

    //   final AuthCredential credential = GoogleAuthProvider.credential(
    //     accessToken: googleSignInAuthentication.accessToken,
    //     idToken: googleSignInAuthentication.idToken,
    //   );

    //   try {
    //     final UserCredential userCredential = await auth.signInWithCredential(credential);

    //     user = userCredential.user;
    //   } on FirebaseAuthException catch (e) {
    //     if (e.code == 'account-exists-with-different-credential') {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         Authentication.customSnackBar(content: 'Akun sudah ada'),
    //       );
    //     } else if (e.code == 'invalid-credential') {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         Authentication.customSnackBar(content: 'terjadi kesalahan, coba beberapa saat lagi'),
    //       );
    //     }
    //   } catch (e) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       Authentication.customSnackBar(content: 'Terjadi kesalahan saat melakukan sign google'),
    //     );
    //   }
    // }

    // return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    try {
      final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
      await _firebaseAuth.signOut();

      // FirebaseAuth auth = FirebaseAuth.instance;
      // await auth.signOut().then((res) {
      //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
      // });
      print('telah logout');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Terjadi kesalahan saat keluar. Silahkan coba lagi',
        ),
      );
    }
  }
}
