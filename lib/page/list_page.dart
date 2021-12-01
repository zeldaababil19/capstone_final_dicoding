import 'package:capstone_final/shared/plus_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListPage extends StatefulWidget {
  static const routeName = '/home_page';
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Icon _user_md = const Icon(Plus.user_md);
  Widget _appBar = Text(
    'List Psikiater',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _appBar,
        leading: Icon(Plus.user_md),
      ),
      // body: _buildItem(),
    );
  }
}
