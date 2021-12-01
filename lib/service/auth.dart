// static Future<SignInSignUpResult> createUser({String email, String pass}) async {
//            try {
//              AuthResult result = await
//        _auth.createUserWithEmailAndPassword(email: email, password: pass);
//              return SignInSignUpResult(user: result.user);
//            } catch (e) {
//              return SignInSignUpResult(message: e.toString());
//            }
//          }