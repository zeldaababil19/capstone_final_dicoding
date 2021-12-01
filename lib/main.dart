import 'package:capstone_final/page/login_page.dart';
import 'package:capstone_final/page/register_page.dart';
import 'package:capstone_final/page/splashscreen_page.dart';
import 'package:capstone_final/shared/text.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Halo Psikiater',
//       theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
//       initialRoute: '/splashScreen',
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Halo Psikiater',
      theme: ThemeData(textTheme: myTextTheme, primarySwatch: Colors.blue, visualDensity: VisualDensity.adaptivePlatformDensity),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LoginPage.routeName: (context) => LoginPage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        // HomePage.routeName: (context) => HomePage(),
        // DetailPage.routeName: (context) => DetailPage(
        //       restaurant: ModalRoute.of(context)?.settings.arguments as Restaurant,
        //     ),
      },
    );
  }
}
