part of 'ui.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  // const HomePage({required User user}) : _user = user;

  // final User _user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const routeName = '/home_page';

  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);

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
                  onPageChanged: (index) {
                    navigation.changeIndex(index);
                  },
                  children: <Widget>[
                    // Text('halo ini list page'),
                    ListPage(),
                    JadwalScreens(),
                    // Text('halo jadwal page'),
                    // HistoryScreen(),
                    Text('halo ini histori page'),
                    // UserInfoScreen(user: _user),
                    Text('halo ini user page'),
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
