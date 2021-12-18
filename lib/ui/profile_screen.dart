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
  Widget build(BuildContext context) {
    final FirebaseFirestore _firebase = FirebaseFirestore.instance;
    CollectionReference users = _firebase.collection('pasiens');
    // final Stream<QuerySnapshot> _userDet = _firebase.collection('pasiens').doc(user!.uid).collection('data').snapshots();

    return MultiProvider(
      providers: appProvider,
      child: Scaffold(
        appBar: AppBar(
          title: _appBar,
          leading: iconUser,
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: Text(
                'edit',
                style: fontTheme.bodyText2?.copyWith(
                  color: whiteColor,
                ),
              ),
            ),
            TextButton(
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
              child: Text(
                'logout',
                style: fontTheme.bodyText2?.copyWith(
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          // shrinkWrap: true,
          children: <Widget>[
            // Stack(
            //   alignment: Alignment.center,
            //   children: <Widget>[
            Column(
              children: [
                // Container(
                //   height: MediaQuery.of(context).size.height / 5,
                //   child: Container(
                //     padding: EdgeInsets.only(top: 10, right: 7),
                //     alignment: Alignment.topRight,
                //   ),
                // ),
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
                Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height / 10,
                  // padding: EdgeInsets.only(top: 15),
                  child: Text(
                    _user.displayName!,
                    style: GoogleFonts.lato(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              // padding: EdgeInsets.only(left: 20, right: 20),
              // height: MediaQuery.of(context).size.height / 7,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey[50],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 27,
                          width: 27,
                          // color: Colors.red[900],
                          child: Icon(
                            Icons.mail_rounded,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '( ${_user.email!} )',
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 27,
                          width: 27,
                          // color: Colors.blue[800],
                          child: Icon(
                            Icons.phone,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _user.phoneNumber?.isEmpty ?? true ? "Not Added" : _user.phoneNumber!,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          height: 27,
                          width: 27,
                          // color: Colors.blue[800],
                          child: Icon(
                            Icons.date_range,
                            color: Colors.grey,
                            size: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        _user.phoneNumber?.isEmpty ?? true ? "Not Added" : _user.phoneNumber!,
                        style: GoogleFonts.lato(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            //   padding: EdgeInsets.only(left: 20, top: 20),
            //   height: MediaQuery.of(context).size.height / 7,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.blueGrey[50],
            //   ),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(30),
            //             child: Container(
            //               height: 27,
            //               width: 27,
            //               color: Colors.indigo[600],
            //               child: Icon(
            //                 Icons.circle,
            //                 color: Colors.white,
            //                 size: 16,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             'Bio',
            //             style: GoogleFonts.lato(
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //             ),
            //           ),
            //         ],
            //       ),
            //       Container(
            //           // child: getBio(),
            //           )
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: EdgeInsets.only(left: 15, right: 15, top: 20),
            //   padding: EdgeInsets.only(left: 20, top: 20),
            //   height: MediaQuery.of(context).size.height / 5,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //     color: Colors.blueGrey[50],
            //   ),
            //   child: Column(
            //     children: [
            //       Row(
            //         children: [
            //           ClipRRect(
            //             borderRadius: BorderRadius.circular(30),
            //             child: Container(
            //               height: 27,
            //               width: 27,
            //               color: Colors.green[900],
            //               child: Icon(
            //                 Icons.history,
            //                 color: Colors.white,
            //                 size: 16,
            //               ),
            //             ),
            //           ),
            //           SizedBox(
            //             width: 10,
            //           ),
            //           Text(
            //             "Appointment History",
            //             style: GoogleFonts.lato(
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black,
            //             ),
            //           ),
            //           Expanded(
            //             child: Container(
            //               padding: EdgeInsets.only(right: 10),
            //               alignment: Alignment.centerRight,
            //               child: SizedBox(
            //                 height: 30,
            //                 child: TextButton(
            //                   onPressed: () {},
            //                   child: Text('View all'),
            //                 ),
            //               ),
            //             ),
            //           )
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),
            //       Expanded(
            //         child: Scrollbar(
            //           child: Container(
            //             padding: EdgeInsets.only(left: 35, right: 15),
            //             child: SingleChildScrollView(
            //                 // child: AppointmentHistoryList(),
            //                 ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 30,
            // ),
          ],
        ),

        // body: FutureBuilder<DocumentSnapshot>(
        //   future: users.doc(user!.uid).get(),
        //   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        //     if (snapshot.hasError) {
        //       return Text("Something went wrong");
        //     }

        //     if (snapshot.hasData && !snapshot.data!.exists) {
        //       return Text("Document does not exist");
        //     }

        //     if (snapshot.connectionState == ConnectionState.done) {
        //       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
        //       return Text("Full Name: ${data['nama']} ${data['email']}");
        //     }

        //     return Text("loading");

        //     // return Center(
        //     //   child: CircularProgressIndicator(
        //     //     valueColor: AlwaysStoppedAnimation<Color>(
        //     //       accentColor,
        //     //     ),
        //     //   ),
        //     // );
        //   },
        //   // builder: (context, snapshot) {

        //   // },
        // ),
      ),
    );
  }

  // Widget _buildItem() {
  //   return SafeArea(
  //     child: Padding(
  //       padding: const EdgeInsets.only(
  //         left: 16.0,
  //         right: 16.0,
  //         bottom: 20.0,
  //       ),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           StreamBuilder(builder: builder)
  //           // Row(),
  //           _user.photoURL != null
  //               ? ClipOval(
  //                   child: Material(
  //                     color: accentColor.withOpacity(0.3),
  //                     child: Image.network(
  //                       _user.photoURL!,
  //                       fit: BoxFit.fitHeight,
  //                     ),
  //                   ),
  //                 )
  //               : ClipOval(
  //                   child: Material(
  //                     color: accentColor.withOpacity(0.3),
  //                     child: Padding(
  //                       padding: const EdgeInsets.all(16.0),
  //                       child: Icon(
  //                         Icons.person,
  //                         size: 60,
  //                         color: baseColor,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //           SizedBox(height: 16.0),
  //           Text(
  //             'Hello',
  //             style: TextStyle(
  //               color: baseColor,
  //               fontSize: 26,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Text(
  //             _user.displayName!,
  //             style: TextStyle(
  //               color: accentColor,
  //               fontSize: 26,
  //             ),
  //           ),
  //           SizedBox(height: 8.0),
  //           Text(
  //             '( ${_user.email!} )',
  //             style: TextStyle(
  //               color: accentColor,
  //               fontSize: 20,
  //               letterSpacing: 0.5,
  //             ),
  //           ),
  //           SizedBox(height: 24.0),
  //           Text(
  //             'You are now signed in using your Google account. To sign out of your account, click the "Sign Out" button below.',
  //             style: TextStyle(color: accentColor.withOpacity(0.8), fontSize: 14, letterSpacing: 0.2),
  //           ),
  //           SizedBox(height: 16.0),
  //           _isSigningOut
  //               ? CircularProgressIndicator(
  //                   valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  //                 )
  //               : ElevatedButton(
  //                   style: ButtonStyle(
  //                     backgroundColor: MaterialStateProperty.all(
  //                       Colors.redAccent,
  //                     ),
  //                     shape: MaterialStateProperty.all(
  //                       RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(10),
  //                       ),
  //                     ),
  //                   ),
  //                   onPressed: () async {
  //                     setState(() {
  //                       _isSigningOut = true;
  //                     });
  //                     await Authentication.signOut(context: context);
  //                     setState(() {
  //                       _isSigningOut = false;
  //                     });
  //                     Navigator.of(context).pushReplacement(_routeToSignInScreen());
  //                   },
  //                   child: Padding(
  //                     padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
  //                     child: Text(
  //                       'Sign Out',
  //                       style: TextStyle(
  //                         fontSize: 20,
  //                         fontWeight: FontWeight.bold,
  //                         color: Colors.white,
  //                         letterSpacing: 2,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _userDetail() {
  //   return StreamBuilder<DocumentSnapshot>(
  //     stream: _userDet.doc(_user.uid).snapshots(),
  //     builder: (context, snapshot) {
  //       if (snapshot.hasData) {
  //         return Text(snapshot.data.data()["nama"]);
  //         // return Text('Something went wrong');
  //       } else if (snapshot.hasData || snapshot.data != null) {
  //         // return Text(snapshot.data!.data()["nama"]);
  //       }

  //       return Center(
  //         child: CircularProgressIndicator(
  //           valueColor: AlwaysStoppedAnimation<Color>(
  //             accentColor,
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

}
