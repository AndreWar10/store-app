import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:store_app/helpers/firebase_errors.dart';
import 'package:store_app/models/user.dart';

class UserManager extends ChangeNotifier {
  UserManager() {
    _loadCurrentUser();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  late User user;

  bool _loading = false;
  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signIn(
      {required UserModel user,
      required Function onFail,
      required Function onSucess}) async {
    loading = true;
    try {
      final UserCredential result = await auth.signInWithEmailAndPassword(
        email: user.email!.trim(),
        password: user.password!.trim(),
      );
      this.user = result.user!;
      debugPrint("User successfully logged in");
      onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      debugPrint("Login error: ${getErrorString(e.code)}");
    }
    loading = false;
  }

  Future<void> _loadCurrentUser() async {
    final User? currentUser = auth.currentUser;
    if (currentUser != null) {
      user = currentUser;
      debugPrint("User logged in: ${user.uid}");
    }
    notifyListeners();
  }

  Future<void> signUp(
      {required UserModel user,
      required Function onFail,
      required Function onSucess}) async {
    loading = true;

    try {
      final UserCredential result = await auth.createUserWithEmailAndPassword(
          email: user.email!, password: user.password!);
      debugPrint("User successfully sign up");
      this.user = result.user!;
       onSucess();
    } on FirebaseAuthException catch (e) {
      onFail(getErrorString(e.code));
      debugPrint("SignUp error: ${getErrorString(e.code)}");
    }
    loading = false;
  }
}
