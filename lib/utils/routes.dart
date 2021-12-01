import 'dart:js';

import 'package:capstone_final/page/login_page.dart';
import 'package:capstone_final/page/splashscreen_page.dart';
import 'package:flutter/widgets.dart';

class Navigate {
  static Map<String, Widget Function(BuildContext)> routes = {
    '/splashScreen': (context) => SplashScreen(),
    '/loginpage': (context) => LoginPage(),
    // '/sign-in': (context) => SignInPage(),
    // '/home': (context) => HomePage(),
  };
}
