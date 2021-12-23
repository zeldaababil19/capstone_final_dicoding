part of 'ui.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  Future<void> _getUser() async {
    user = _auth.currentUser!;
  }

  _navigate(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  String shortcut = "no action set";

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  // List<Widget> _pages = [
  //   ListPage(),
  //   JadwalScreens(),
  //   HistoriScreens(),
  //   UserInfoScreen(user: user),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        key: _scaffoldKey,
        body: [
          ListPage(),
          JadwalScreens(),
          HistoriScreens(),
          UserInfoScreen(),
          // UserInfoScreen(user: user),
        ][_selectedIndex],
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 40,
                color: Colors.black.withOpacity(0.2),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                curve: Curves.easeOutExpo,
                rippleColor: Colors.blue[300]!,
                hoverColor: Colors.blue[100]!,
                haptic: true,
                tabBorderRadius: 12,
                gap: 3,
                activeColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                duration: Duration(milliseconds: 300),
                tabBackgroundColor: Colors.blue.withOpacity(0.9),
                textStyle: fontTheme.subtitle2!.copyWith(color: whiteColor),
                tabs: [
                  GButton(
                    iconSize: _selectedIndex != 0 ? 28 : 25,
                    icon: _selectedIndex == 0 ? FontAwesomeIcons.userMd : FontAwesomeIcons.userMd,
                    text: 'Psikiater',
                  ),
                  GButton(
                    icon: _selectedIndex == 1 ? FontAwesomeIcons.calendarWeek : FontAwesomeIcons.calendarDay,
                    text: 'Jadwal',
                  ),
                  GButton(
                    iconSize: 28,
                    icon: _selectedIndex == 2 ? FontAwesomeIcons.history : FontAwesomeIcons.history,
                    text: 'History',
                  ),
                  GButton(
                    iconSize: 29,
                    icon: _selectedIndex == 3 ? FontAwesomeIcons.userAlt : FontAwesomeIcons.userAlt,
                    text: 'Profile',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: _onItemTapped,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
