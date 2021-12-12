part of 'widget.dart';

class GoogleSIgnInButton extends StatefulWidget {
  const GoogleSIgnInButton({Key? key}) : super(key: key);

  @override
  _GoogleSIgnInButtonState createState() => _GoogleSIgnInButtonState();
}

class _GoogleSIgnInButtonState extends State<GoogleSIgnInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            )
          : OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              onPressed: () async {
                setState(() {
                  _isSigningIn = true;
                });

                await Authentication.signInWithGoogle();

                setState(() {
                  _isSigningIn = false;
                });
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    // builder: (context) => UserInfoScreen(
                    //   user: user,
                    // ),
                    builder: (context) => HomePage(),
                  ),
                );
                // if (user != null) {
                //   Navigator.of(context).pushReplacement(
                //     MaterialPageRoute(
                //       // builder: (context) => UserInfoScreen(
                //       //   user: user,
                //       // ),
                //       builder: (context) => HomePage(),
                //     ),
                //   );
                // }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset("assets/images/icons_google.png", height: 25, fit: BoxFit.fill),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Login with Google',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
