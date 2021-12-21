part of 'ui.dart';

class UserInfoScreen extends StatefulWidget {
  static const routeName = '/profile_screen';

  const UserInfoScreen({Key? key, required User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  State<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User _user;

  Future<void> _getUser() async {
    _user = _auth.currentUser!;
  }

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  bool _isSigningOut = false;

  Icon iconUser = const Icon(Plus.user);
  Widget _appBar = Text(
    'Profil',
    style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w900),
  );

  @override
  Widget build(BuildContext context) {
    CollectionReference pasiens = FirebaseFirestore.instance.collection('pasiens');
    final FirebaseFirestore _firebase = FirebaseFirestore.instance;

    return MultiProvider(
        providers: appProvider,
        child: Scaffold(
          appBar: AppBar(
            title: _appBar,
            leading: iconUser,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ),
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.cog,
                  color: whiteColor,
                  size: 18,
                ),
              ),
            ],
          ),
          body: FutureBuilder<DocumentSnapshot>(
            future: pasiens.doc(user!.uid).get(),
            builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                return Container(
                  color: baseColor,
                  child: ListView(
                    children: <Widget>[
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              child: Column(
                                children: [
                                  _user.photoURL != null
                                      ? ClipOval(
                                          child: Material(
                                            color: Colors.blue,
                                            child: Image.network(
                                              _user.photoURL!,
                                              fit: BoxFit.fitHeight,
                                            ),
                                          ),
                                        )
                                      : ClipOval(
                                          child: Material(
                                            child: Padding(
                                              padding: const EdgeInsets.all(26.0),
                                              child: Icon(
                                                Icons.person,
                                                size: 90,
                                                color: Colors.blue,
                                              ),
                                            ),
                                          ),
                                        ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 5,
                                  ),
                                  shape: BoxShape.circle),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Text(_user.displayName!, style: fontTheme.headline6),
                              // ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Container(
                              alignment: Alignment.center,
                              child: Text('( ${_user.email!} )', style: fontTheme.subtitle1),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(color: greyColor.withOpacity(0.8), blurRadius: 8, offset: Offset(0, 3), spreadRadius: 2),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: FaIcon(
                                          FontAwesomeIcons.phone,
                                          color: blackColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Text(data['phone'] == null ? "--" : data['phone'], style: fontTheme.bodyText1),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      child: Container(
                                        height: 30,
                                        width: 30,
                                        child: FaIcon(
                                          FontAwesomeIcons.calendarAlt,
                                          color: blackColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Text(data['birthDate'] == null ? "--" : data['birthDate'],
                                        // _user.phoneNumber?.isEmpty ?? true ? "Not Added" : _user.phoneNumber!,
                                        style: fontTheme.bodyText1),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: FaIcon(
                                          FontAwesomeIcons.venusMars,
                                          color: blackColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Text(data['gender'] == null ? "--" : data['gender'],
                                        // _user.phoneNumber?.isEmpty ?? true ? "Not Added" : _user.phoneNumber!,
                                        style: fontTheme.bodyText1),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: FaIcon(
                                          FontAwesomeIcons.mapMarkedAlt,
                                          color: blackColor,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                    Text(data['address'] == null ? "--" : data['address'],
                                        // _user.phoneNumber?.isEmpty ?? true ? "Not Added" : _user.phoneNumber!,
                                        style: fontTheme.bodyText1),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    accentColor,
                  ),
                ),
              );
            },
          ),
        ));
  }
}
