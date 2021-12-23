part of 'ui.dart';

class RegisterPage extends StatefulWidget {
  static const routeName = '/register_screen';
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController = TextEditingController();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();
  FocusNode f4 = FocusNode();

  late bool _isSuccess;
  late bool _isHidden = true;

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
                    const SizedBox(width: 18),
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          'Halo Psikiater',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                const SizedBox(height: 15),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                              'Nama',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 6.0, right: 12.0),
                            child: TextFormField(
                              focusNode: f1,
                              controller: _nameController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Masukkan Nama',
                                fillColor: baseColor,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: accentColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: baseColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              ),
                              onFieldSubmitted: (value) {
                                f1.unfocus();
                                FocusScope.of(context).requestFocus(f2);
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) return 'masukkan Nama';
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
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
                              focusNode: f2,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: 'Masukkan Email',
                                fillColor: baseColor,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: accentColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: baseColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              ),
                              onFieldSubmitted: (value) {
                                f2.unfocus();
                                if (_passwordController.text.isEmpty) {
                                  FocusScope.of(context).requestFocus(f3);
                                }
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Masukkan Email';
                                } else if (!emailValidate(value)) {
                                  return 'Masukkan Email dengan benar';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
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
                              focusNode: f3,
                              controller: _passwordController,
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden ? Icons.visibility : Icons.visibility_off,
                                  ),
                                ),
                                hintText: 'Masukkan Password',
                                fillColor: baseColor,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: accentColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: baseColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              ),
                              onFieldSubmitted: (value) {
                                f3.unfocus();
                                if (_passwordConfirmController.text.isEmpty) {
                                  FocusScope.of(context).requestFocus(f4);
                                }
                              },
                              textInputAction: TextInputAction.next,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Masukkan Password';
                                } else if (value.length < 8) {
                                  return 'Masukkan Password sepanjang 8 karakter';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 12),
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
                              focusNode: f4,
                              controller: _passwordConfirmController,
                              obscureText: _isHidden,
                              decoration: InputDecoration(
                                suffix: InkWell(
                                  onTap: _togglePasswordView,
                                  child: Icon(
                                    _isHidden ? Icons.visibility : Icons.visibility_off,
                                  ),
                                ),
                                hintText: 'Konfirmasi password',
                                fillColor: baseColor,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: accentColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                    color: baseColor,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                              ),
                              onFieldSubmitted: (value) {
                                f4.unfocus();
                              },
                              textInputAction: TextInputAction.done,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter the Password';
                                } else if (value.compareTo(_passwordController.text) != 0) {
                                  return 'Password not Matching';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 20.0),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: accentColor),
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    side: const BorderSide(
                                      color: accentColor,
                                    ),
                                  ),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    showLoaderDialog(context);
                                    _registerAccount();
                                    _registerOauth();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text('OR', style: Theme.of(context).textTheme.subtitle2),
                    const SizedBox(width: 20),
                    const Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
              ]),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
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
                      child: const Text(
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

  showAlertDialog(BuildContext context) {
    Navigator.pop(context);
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: GoogleFonts.lato(fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
        FocusScope.of(context).requestFocus(f2);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(
        "Error!",
        style: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        "Email sudah digunakan",
        style: GoogleFonts.lato(),
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool emailValidate(String email) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _registerAccount() async {
    late User user;
    late UserCredential credential;

    try {
      credential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
    } catch (error) {
      if (error.toString().compareTo('[firebase_auth/email-already-in-use] The email address is already in use by another account.') == 0) {
        showAlertDialog(context);
        print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        // print(user);
      }
    }
    user = credential.user!;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      // ignore: deprecated_member_use
      await user.updateProfile(displayName: _nameController.text);

      FirebaseFirestore.instance.collection('pasiens').doc(user.uid).set({
        'name': _nameController.text,
        'birthDate': null,
        'email': user.email,
        'phone': null,
        'alamat': null,
        'image': null,
        'gender': null,
      }, SetOptions(merge: true));

      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
    } else {
      _isSuccess = false;
    }
  }

  void _registerOauth() async {
    const _scopes = [calendar.CalendarApi.calendarScope];
    var _clientID = ClientId("389215821819-0i3ed9vl37gbh5qc3ro5hhn50q2k017e.apps.googleusercontent.com", "");
    clientViaUserConsent(_clientID, _scopes, prompt).then((AuthClient client) {
      var cal = calendar.CalendarApi(client);
      cal.calendarList.list().then((value) => print("VAL________$value"));
    });
  }

  void prompt(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }
}
