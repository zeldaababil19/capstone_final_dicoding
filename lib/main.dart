import 'package:capstone_final/ui/ui.dart';
import 'package:capstone_final/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    _getUser();
    return MultiProvider(
      providers: appProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Halo Psikiater',
        theme: ThemeData(textTheme: fontTheme, primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: '/',
        routes: {
          // '/': (context) => user == null ? SplashScreenPage() : MainPage(),
          '/': (context) => SplashScreenPage(),
          '/login': (context) => LoginPage(),
          '/home': (context) => MainPage(),
          '/profile': (context) => UserInfoScreen(),
          '/booking': (context) => MyBooking(),
          '/history': (context) => HistoriScreens()
          // '/PsikiaterProfile': (context) => PsikiaterProfile(psikiater: psikiater['name']),
          // SplashScreenPage.routeName: (context) => SplashScreenPage(),
          // LoginPage.routeName: (context) => LoginPage(),
          // RegisterPage.routeName: (context) => RegisterPage(),
          // MainPage.routeName: (context) => MainPage(),
          // HomePage.routeName: (context) => HomePage(),
          // UserInfoScreen.routeName: (context) => UserInfoScreen(user: user),
          // JadwalScreens.routeName: (context) => JadwalScreens(),
          //Psikiatercreens.routename: (context) => Psikiater
        },
      ),
    );
  }
}
