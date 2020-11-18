
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLogin = false;
  static User _user;

  Future<bool> signInEmail({String email, String pasword}) async {
    try {
      User user = (await _auth.signInWithEmailAndPassword(email: email.trim(), password: pasword.trim())).user;
      if(user != null) {

        setUser(user);

        return true;
      }
    } on Exception catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> signUpEmail({String email, String password}) async {
    try {
      User user = (await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password.trim())).user;
      signOut();


      if(user != null) {
        return true;
      }
    } on Exception catch (e) {
      print(e);
      return false;
    }
  }

  signOut() async {
    setUser(null);
    await _auth.signOut();
  }

  sendPasswordResetEmail(String email) async {
    await _auth.setLanguageCode("ko");
    _auth.sendPasswordResetEmail(email: email.trim());
  }

  setUser(User user) {
    _user = user;
  }

  changeDisplayName(String name) async {
    await _user.updateProfile(displayName: name.trim());
    notifyListeners();
  }

  static User get userInformation => _user;
  String get displayName => _user.displayName;
  String get email => _user.email;
}