part of '../ui.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = '/profilescreen';

  const UserInfoScreen({required User user}) : _user = user;

  final User _user;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  late UserProvider provider;
  late User _user;
  bool _isSigningOut = false;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(
          begin: begin,
          end: end,
        ).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: baseColor,
        // title: AppBarTitle(),
      ),
      body: _buildItem(),
    );
  }

  Widget _buildItem() {
    return Consumer<UserProvider>(
      builder: (context, state, _) {
        provider = state;
        if (state.state == ResultState.loading) {
          return const Center(
              // child: SpinKitHourGlass(color: Color(0xFF98bd8f)),
              );
        } else if (state.state == ResultState.withData) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(),
                      _user.photoURL != null
                          ? ClipOval(
                              child: Material(
                                color: accentColor.withOpacity(0.3),
                                child: Image.network(
                                  _user.photoURL!,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                            )
                          : ClipOval(
                              child: Material(
                                color: accentColor.withOpacity(0.3),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(
                                    Icons.person,
                                    size: 60,
                                    color: baseColor,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(height: 16.0),
                      Text(
                        'Hello',
                        style: TextStyle(
                          color: baseColor,
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _user.displayName!,
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 26,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '( ${_user.email!} )',
                        style: TextStyle(
                          color: accentColor,
                          fontSize: 20,
                          letterSpacing: 0.5,
                        ),
                      ),
                      SizedBox(height: 24.0),
                      Text(
                        'You are now signed in using your Google account. To sign out of your account, click the "Sign Out" button below.',
                        style: TextStyle(color: accentColor.withOpacity(0.8), fontSize: 14, letterSpacing: 0.2),
                      ),
                      SizedBox(height: 16.0),
                      _isSigningOut
                          ? CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            )
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.redAccent,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _isSigningOut = true;
                                });
                                await Authentication.signOut(context: context);
                                setState(() {
                                  _isSigningOut = false;
                                });
                                Navigator.of(context).pushReplacement(_routeToSignInScreen());
                              },
                              child: Padding(
                                padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                                child: Text(
                                  'Sign Out',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    letterSpacing: 2,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              );
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.error) {
          return Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/no-wifi.png", width: 100),
              const SizedBox(
                height: 10,
              ),
              const Text("Koneksi terputus!"),
              ElevatedButton(
                child: const Text("refresh"),
                onPressed: () {
                  // provider.getUser();
                },
              ),
            ],
          ));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}
