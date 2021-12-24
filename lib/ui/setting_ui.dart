part of 'ui.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Setting> {
  // UserProfileDetails detail = UserProfileDetails();

  FirebaseAuth _auth = FirebaseAuth.instance;
  // late User user;

  // Future<void> _getUser() async {
  //   user = _auth.currentUser!;
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: IconButton(
            splashRadius: 25,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        title: Text(
          'Settings',
          style: GoogleFonts.lato(color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: baseColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: greyColor.withOpacity(0.8), blurRadius: 8, offset: Offset(0, 3), spreadRadius: 2),
                  ],
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileSetting(),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(primary: Colors.grey),
                  child: Text(
                    'Profile Setting',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 14,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(color: greyColor.withOpacity(0.8), blurRadius: 8, offset: Offset(0, 3), spreadRadius: 2),
                  ],
                ),
                child: TextButton(
                  onPressed: () async {
                    await _auth.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    // setState(() {
                    //   _isSigningOut = true;
                    // });
                    // await Authentication.signOut(context: context);
                    // setState(() {
                    //   _isSigningOut = false;
                    // });
                    // Navigator.of(context).pushReplacement(_routeToSignInScreen());
                    // Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
                    // _signOut();
                  },
                  style: TextButton.styleFrom(primary: Colors.grey),
                  child: Text(
                    'Sign out',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
