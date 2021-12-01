import 'package:capstone_final/page/home_page.dart';
import 'package:capstone_final/page/login_page.dart';
import 'package:capstone_final/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/registerscreen';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _kpassController = TextEditingController();

  bool _obscureText = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Row(
                  children: <Widget>[
                    SizedBox(width: 18),
                    Text(
                      'Halo Psikiater',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Divider(
                        thickness: 3,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 30),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SizedBox(height: 15),
                Form(
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                            child: Text(
                              'Email',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 6.0, right: 12.0),
                            child: TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Masukkan Email',
                                fillColor: baseColor,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: accentColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: baseColor,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                            child: Text(
                              'Password',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 6.0, right: 12.0),
                            child: TextFormField(
                              controller: _passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Masukkan Password',
                                fillColor: baseColor,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: accentColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: baseColor,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              ),
                            ),
                          ),
                          SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                            child: Text(
                              'Konfirmasi Password',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 6.0, right: 12.0),
                            child: TextFormField(
                              controller: _kpassController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: 'Masukkan konfirmasi password',
                                fillColor: baseColor,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: accentColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(
                                    color: baseColor,
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: Text(
                                  'Register',
                                  style: TextStyle(color: accentColor),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: BorderSide(
                                      color: accentColor,
                                    ),
                                  ),
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(vertical: 12),
                                ),
                                onPressed: () {
                                  _register();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 20),
                    Text('OR', style: Theme.of(context).textTheme.subtitle2),
                    SizedBox(width: 20),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Image.asset("assets/images/icons_google.png", height: 25, fit: BoxFit.fill),
                      label: Text(
                        'Register with Google',
                        style: TextStyle(color: Colors.grey),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        elevation: 0,
                        padding: EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 30),
              ]),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Sudah punya akun?',
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Masuk disini',
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final email = _emailController.text;
      final password = _passController.text;

      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      // Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                  )));
    } catch (e) {
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }
}
