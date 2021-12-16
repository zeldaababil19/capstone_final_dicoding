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
  void initState() {
    _user = widget._user;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore _firebase = FirebaseFirestore.instance;
    CollectionReference users = _firebase.collection('user');
    // final Stream<QuerySnapshot> _userDet = _firebase.collection('user').doc(user!.uid).collection('data').snapshots();

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
                style: mediumBaseFont.copyWith(
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
                style: mediumBaseFont.copyWith(
                  color: whiteColor,
                ),
              ),
            ),
          ],
        ),
        // body: _buildItem(),
        body: FutureBuilder<DocumentSnapshot>(
          future: users.doc(user!.uid).get(),
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong");
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              return Text("Document does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
              return Text("Full Name: ${data['nama']} ${data['email']}");
            }

            return Text("loading");

            // return Center(
            //   child: CircularProgressIndicator(
            //     valueColor: AlwaysStoppedAnimation<Color>(
            //       accentColor,
            //     ),
            //   ),
            // );
          },
          // builder: (context, snapshot) {

          // },
        ),
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
