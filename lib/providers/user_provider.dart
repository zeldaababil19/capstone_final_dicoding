part of 'provider.dart';

class UserProvider extends ChangeNotifier {
  final String user;

  UserProvider(BuildContext context, {required this.user}) {
    getUser(context: context);
  }

  late UserDetail _userDetail;
  late ResultState _state;
  String _message = "";

  UserDetail get result => _userDetail;
  ResultState get state => _state;
  String get message => _message;

  static Future<FirebaseApp> getUser({required BuildContext context}) async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(user: user),
        ),
      );
    }
    return firebaseApp;
  }

  // Future<dynamic> _getUser() async {
  //   try {
  //     _state = ResultState.loading;
  //     FirebaseApp firebaseApp = await Firebase.initializeApp();

  //     User? user = FirebaseAuth.instance.currentUser;
  //   } catch (e) {}
  // }
  // Future<FirebaseApp> _getUser() async {
  //   // FirebaseApp firebaseApp = await Firebase.initializeApp();

  //   // User? user = FirebaseAuth.instance.currentUser;

  //   try {
  //     _state = ResultState.loading;
  //     final user = await Firebase.initializeApp();
  //     notifyListeners();
  //     // if (user.error) {
  //     //   _state = ResultState.noData;
  //     //   notifyListeners();
  //     //   return _message = 'Empty Data';
  //     // } else {
  //     //   _state = ResultState.withData;
  //     //   notifyListeners();
  //     //   return _restaurantDetail = user;
  //     // }
  //   } catch (error) {
  //     _state = ResultState.error;
  //     notifyListeners();
  //     // return _message = 'Error: $error';
  //   }
  // }
}
