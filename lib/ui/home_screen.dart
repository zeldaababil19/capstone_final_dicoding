part of 'ui.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  // const HomePage({required User user}) : user = user;

  late User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // int _selectedIndex = 0;
  // List<Widget> _pages = [
  //   ListPage(),
  //   JadwalScreens(),
  //   HistoriScreens(),
  //   UserInfoScreen(user: user),
  // ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  String shortcut = "no action set";

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);
    // final FirebaseAuth auth = FirebaseAuth.instance;

    // final User? user = auth.currentUser;
    // user!.uid;
    // User? user = FirebaseAuth.instance.currentUser;

    // if (user != null) {
    //   Navigator.of(context).pushReplacement(
    //     MaterialPageRoute(
    //       builder: (context) => UserInfoScreen(user: user),
    //     ),
    //   );
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: accentColor,
          ),
          SafeArea(
            child: Stack(
              children: <Widget>[
                Container(
                  color: baseColor,
                ),
                PageView(
                  controller: navigation.page,
                  onPageChanged: (context) {
                    navigation.changeIndex(context);
                  },
                  children: <Widget>[
                    ListPage(),
                    JadwalScreens(),
                    HistoriScreens(),
                    UserInfoScreen(),
                    // UserInfoScreen(user: user),
                  ],
                ),
                NavBarWidget(context),
              ],
            ),
          ),
        ],
      ),
      // drawer: NavigateDrawer(uid: this.uid),
    );
  }
}
