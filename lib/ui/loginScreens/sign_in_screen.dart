part of '../ui.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/loginscreen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final _auth = FirebaseAuth.instance;
  // final _emailController = TextEditingController();
  // final _passController = TextEditingController();
  // final GlobalKey<FormState> _form = GlobalKey<FormState>();

  // bool _obscureText = true;
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                // SizedBox(height: 30),
                Row(
                  children: <Widget>[
                    SizedBox(width: 12),
                    Text(
                      'Halo Psikiater',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Divider(
                        thickness: 3,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 12),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    'Login',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                // SizedBox(height: 30),
                Image.asset("assets/images/splashscreen.png"),

                // Form(
                //   key: _form,
                //   child: Padding(
                //     padding: const EdgeInsets.all(18.0),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(12),
                //       ),
                // child: Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: <Widget>[
                //     Padding(
                //       padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                //       child: Text(
                //         'Email',
                //         style: Theme.of(context).textTheme.headline6,
                //       ),
                //     ),
                //     SizedBox(height: 8),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0),
                //       child: TextFormField(
                //           controller: _emailController,
                //           keyboardType: TextInputType.emailAddress,
                //           decoration: InputDecoration(
                //             hintText: 'Masukkan Email',
                //             fillColor: baseColor,
                //             filled: true,
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(8),
                //               borderSide: BorderSide(
                //                 color: accentColor,
                //               ),
                //             ),
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(8),
                //               borderSide: BorderSide(
                //                 color: baseColor,
                //               ),
                //             ),
                //             contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                //           ),
                //           validator: (val) {
                //             if (val!.isEmpty) {
                //               return 'Email tidak boleh kosong';
                //             } else if (!val.contains('@')) {
                //               return 'Please enter a valid email address';
                //             }
                //             return null;
                //           }),
                //     ),
                //     SizedBox(height: 16),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                //       child: Text(
                //         'Password',
                //         style: Theme.of(context).textTheme.headline6,
                //       ),
                //     ),
                //     SizedBox(height: 8),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0),
                //       child: TextFormField(
                //           controller: _passController,
                //           obscureText: true,
                //           decoration: InputDecoration(
                //             hintText: 'Masukkan Password',
                //             fillColor: baseColor,
                //             filled: true,
                //             focusedBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(8),
                //               borderSide: BorderSide(
                //                 color: accentColor,
                //               ),
                //             ),
                //             enabledBorder: OutlineInputBorder(
                //               borderRadius: BorderRadius.circular(8),
                //               borderSide: BorderSide(
                //                 color: baseColor,
                //               ),
                //             ),
                //             contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                //           ),
                //           validator: (val) {
                //             if (val!.isEmpty) return 'Password tidak boleh kosong';
                //             return null;
                //           }),
                //     ),
                //     SizedBox(height: 20),
                //     Padding(
                //       padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 20.0),
                //       child: SizedBox(
                //         width: double.infinity,
                //         child: ElevatedButton(
                //           onPressed: () {
                //             if (_form.currentState!.validate()) {
                //               _loginState();
                //             }
                //           },
                //           child: Text(
                //             'Login',
                //             style: TextStyle(color: accentColor),
                //           ),
                //           style: ElevatedButton.styleFrom(
                //             primary: Colors.white,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(8.0),
                //               side: BorderSide(
                //                 color: accentColor,
                //               ),
                //             ),
                //             elevation: 0,
                //             padding: EdgeInsets.symmetric(vertical: 16),
                //           ),
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                //     ),
                //   ),
                // ),
                // SizedBox(height: 20),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       child: Divider(
                //         thickness: 1,
                //         color: Colors.black,
                //       ),
                //     ),
                //     SizedBox(width: 20),
                //     Text('OR', style: Theme.of(context).textTheme.subtitle2),
                //     SizedBox(width: 20),
                //     Expanded(
                //       child: Divider(
                //         thickness: 1,
                //         color: Colors.black,
                //       ),
                //     ),
                //   ],
                // ),
                // SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: FutureBuilder(
                      future: Authentication.initializeFirebase(context: context),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error initializing Firebase');
                        } else if (snapshot.connectionState == ConnectionState.done) {
                          return GoogleSIgnInButton();
                        }
                        return CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                        );
                      },
                    ),

                    /// yang lama
                    // child: ElevatedButton.icon(
                    //   onPressed: () {
                    //     _loginEmailState();
                    //   },
                    //   icon: Image.asset("assets/images/icons_google.png", height: 25, fit: BoxFit.fill),
                    //   label: Text(
                    //     'Login with Google',
                    //     style: TextStyle(color: Colors.grey),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     primary: Colors.white,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(8.0),
                    //     ),
                    //     elevation: 0,
                    //     padding: EdgeInsets.symmetric(vertical: 16),
                    //   ),
                    // ),
                  ),
                ),
                // SizedBox(height: 30),
              ]),
            ),
            // SliverFillRemaining(
            //   hasScrollBody: false,
            //   child: Container(
            //     alignment: Alignment.bottomCenter,
            //     margin: EdgeInsets.only(bottom: 20),
            //     child: Column(
            //       mainAxisSize: MainAxisSize.min,
            //       children: <Widget>[
            //         Text(
            //           'Belum punya akun ?',
            //           style: TextStyle(color: Colors.black),
            //         ),
            //         GestureDetector(
            //           onTap: () {
            //             Navigator.pushNamed(
            //               context,
            //               RegisterPage.routeName,
            //             );
            //           },
            //           child: Text(
            //             'Daftar disini',
            //             style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  // void _loginState() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   try {
  //     final email = _emailController.text;
  //     final password = _passController.text;

  //     await _auth.signInWithEmailAndPassword(email: email, password: password);
  //     Navigator.pushReplacementNamed(context, HomePage.routeName);
  //   } catch (e) {
  //     final snackbar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // void _loginEmailState() async {
  //   setState(() {
  //     _isLoading = true;
  //   });

  //   try {
  //     final GoogleSignIn googleSignIn = GoogleSignIn();
  //     final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  //     if (googleSignInAccount != null) {
  //       final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
  //       final AuthCredential authCredential = GoogleAuthProvider.credential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);

  //       UserCredential result = await _auth.signInWithCredential(authCredential);
  //       User? user = result.user;

  //       if (result != null) {
  //         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
  //       }
  //     }
  //   } catch (e) {
  //     final snackbar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //   } finally {
  //     setState(() {
  //       _isLoading = false;
  //     });
  //   }
  // }

  // @override
  // void dispose() {
  //   _emailController.dispose();
  //   _passController.dispose();
  //   super.dispose();
  // }
}
