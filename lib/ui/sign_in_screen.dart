part of 'ui.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login_screen';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FocusNode f1 = FocusNode();
  FocusNode f2 = FocusNode();
  FocusNode f3 = FocusNode();

  // bool _obscureText = true;
  // bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: baseColor,
      key: _scaffoldKey,
      body: Builder(builder: (context) {
        return SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Row(
                      children: <Widget>[
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              'Halo Psikiater',
                              style: Theme.of(context).textTheme.headline3,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18),
                      child: Text(
                        'Login',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
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
                                  'Email',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0),
                                child: TextFormField(
                                    focusNode: f1,
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
                                    onFieldSubmitted: (value) {
                                      f1.unfocus();
                                      FocusScope.of(context).requestFocus(f2);
                                    },
                                    textInputAction: TextInputAction.next,
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Email tidak boleh kosong';
                                      } else if (!emailValidate(val)) {
                                        return 'Please enter a valid email address';
                                      }
                                      return null;
                                    }),
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 12.0),
                                child: Text(
                                  'Password',
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0),
                                child: TextFormField(
                                  focusNode: f2,
                                  controller: _passwordController,
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
                                  onFieldSubmitted: (value) {
                                    f2.unfocus();
                                    FocusScope.of(context).requestFocus(f3);
                                  },
                                  textInputAction: TextInputAction.done,
                                  validator: (val) {
                                    if (val!.isEmpty) return 'Password tidak boleh kosong';
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.only(left: 12.0, top: 8.0, right: 12.0, bottom: 20.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        showLoaderDialog(context);
                                        _loginState();
                                      }
                                    },
                                    child: Text(
                                      'Login',
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
                                      padding: EdgeInsets.symmetric(vertical: 16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
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
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Belum punya akun ?',
                            style: TextStyle(color: Colors.black),
                          ),
                          TextButton(
                            style: ButtonStyle(overlayColor: MaterialStateProperty.all(Colors.transparent)),
                            onPressed: () => _pushPage(context, RegisterPage()),
                            //onTap: () {
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute<void>(builder: (_) => RegisterPage()),
                            //   );
                            // },
                            child: const Text(
                              'Daftar disini',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool emailValidate(String email) {
    if (RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  void _loginState() async {
    try {
      final User? user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user!.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      // Navigator.of(context).pushReplacement(
      //   MaterialPageRoute(
      //     // builder: (context) => UserInfoScreen(user: user),
      //     // builder: (context) => HomePage(),
      //     builder: (context) => MainPage(),
      //   ),
      // );
    } catch (e) {
      final snackbar = SnackBar(
        content: Expanded(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: const [
                Icon(
                  Icons.info_outline,
                  color: Colors.white,
                ),
                Expanded(child: SizedBox(child: Text('Terdapat kesalahan ketika login, silahkan ulangi beberapa saat lagi'))),
              ],
            ),
          ),
        ),
      );
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }
}
