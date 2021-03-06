part of 'ui.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splash_Screen';
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    _getUser();
    return SplashScreen.timer(
      seconds: 3,
      navigateAfterSeconds: user != null ? MainPage() : LoginPage(),
      // navigateAfterSeconds: LoginPage(),
      title: Text(
        "Halo Psikiater",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0, color: Colors.white),
      ),
      image: Image.asset("assets/images/splashscreen.png"),
      loadingTextPadding: EdgeInsets.all(0),
      loadingText: Text(""),
      photoSize: 100.0,
      backgroundColor: Colors.blue,
      styleTextUnderTheLoader: TextStyle(),
      loaderColor: Color(0xFF49AFDB),
      pageRoute: _createRoute(),
    );
  }

  Route _createRoute() {
    _getUser();
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => user != null ? MainPage() : LoginPage(),
      // pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
