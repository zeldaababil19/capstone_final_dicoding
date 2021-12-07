part of 'service.dart';
class ApiService {
  User? user = FirebaseAuth.instance.currentUser;

// Future<UserDetail> getUserDetail(String id) async {

//   final response = await user!.photoURL!;
//   if (response.photoURL != null) {
//     return UserDetail(user: user);
//   } else {
//     throw Exception('Failed to load');
//   }
// }
}

