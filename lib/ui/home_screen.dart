part of 'ui.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  // const HomePage({required User user}) : _user = user;

  // final User _user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;

    final User? user = auth.currentUser;
    user!.uid;
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
                  onPageChanged: (index) {
                    navigation.changeIndex(index);
                  },
                  children: <Widget>[
                    // Text('halo ini list page'),
                    ListPage(),
                    JadwalScreens(),
                    // Text('halo jadwal page'),
                    HistoriScreens(),
                    // Text('halo ini histori page'),

                    UserInfoScreen(user: user),
                    // UserInfoScreen(),
                    // Text('halo ini user page'),
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
