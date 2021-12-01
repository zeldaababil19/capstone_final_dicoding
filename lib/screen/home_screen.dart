import 'package:capstone_final/styles/plus_icons.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _buttomNavBar = 0;

  List<BottomNavigationBarItem> _buttomNavBarItems = [
    BottomNavigationBarItem(icon: Icon(Plus.user_md)),
    BottomNavigationBarItem(icon: Icon(Plus.calendar_check_o)),
    BottomNavigationBarItem(icon: Icon(Plus.history)),
    BottomNavigationBarItem(icon: Icon(Plus.user)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
