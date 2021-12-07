import 'package:capstone_final/ui/ui.dart';
import 'package:capstone_final/shared/shared.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halo Psikiater',
      theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreenPage.routeName,
      routes: {
        SplashScreenPage.routeName: (context) => SplashScreenPage(),
        LoginPage.routeName: (context) => LoginPage(),
        // RegisterPage.routeName: (context) => RegisterPage(),
        HomePage.routeName: (context) => HomePage(),
        // UserInfoScreen.routeName: (context) => UserInfoScreen(user: context.user),
      },
    );
  }
}
