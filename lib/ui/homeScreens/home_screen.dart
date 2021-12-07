part of '../ui.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              auth.signOut().then((res) {
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage()), (Route<dynamic> route) => false);
              });
            },
          )
        ],
      ),
      body: Center(child: Text('Welcome!')),
      // drawer: NavigateDrawer(uid: this.uid),
    );
  }
}
