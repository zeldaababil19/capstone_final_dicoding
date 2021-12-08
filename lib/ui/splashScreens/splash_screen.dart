part of '../ui.dart';

class SplashScreenPage extends StatelessWidget {
  static const routeName = '/splashScreen';

  @override
  Widget build(BuildContext context) {
    // User? result = FirebaseAuth.instance.currentUser;
    return SplashScreen.timer(
      seconds: 3,
      // navigateAfterSeconds: result != null ? Home(uid: result.uid) : SignUp(),
      navigateAfterSeconds: LoginPage(),
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
    // User? result = FirebaseAuth.instance.currentUser;
    return PageRouteBuilder(
      // pageBuilder: (context, animation, secondaryAnimation) => result != null ? UserInfoScreen(user: result) : LoginPage(),
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
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
