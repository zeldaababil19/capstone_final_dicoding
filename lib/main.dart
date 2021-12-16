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
  FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Halo Psikiater',
        theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
        initialRoute: SplashScreenPage.routeName,
        routes: {
          SplashScreenPage.routeName: (context) => SplashScreenPage(),
          LoginPage.routeName: (context) => LoginPage(),
          RegisterPage.routeName: (context) => RegisterPage(),
          HomePage.routeName: (context) => HomePage(),
          UserInfoScreen.routeName: (context) => UserInfoScreen(user: user),
          JadwalScreens.routeName: (context) => JadwalScreens(),
          //Psikiatercreens.routename: (context) => Psikiater
        },
      ),
    );
  }
}
