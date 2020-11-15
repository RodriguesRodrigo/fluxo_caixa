import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String email;
  String password;

  UserModel({this.email = '', this.password = ''});

  Future<String> create() async {
    var result = 'success';
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
    }
    catch(e) {
      print(e.code);
      result = e.code;
    }
    return result;
  }

}