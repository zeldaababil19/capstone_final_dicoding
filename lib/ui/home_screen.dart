part of 'ui.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  const HomePage({required User user}) : _user = user;

  final User _user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late User _user;
  
  @override
  Widget build(BuildContext context) {
    NavigationProvider navigation = Provider.of<NavigationProvider>(context);
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(user: user),
        ),
      );
    }

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
                    // ListPage(),
                    UserInfoScreen(user: _user),
                    // UserInfoScreen(user: _user),
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
