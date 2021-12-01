import 'package:capstone_final/screen/home_screen.dart';
import 'package:capstone_final/screen/splash_screen.dart';
import 'package:capstone_final/styles/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List Psikiater',
      theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomePage.routeName: (context) => const HomePage(),
      },
    );
  }
}
