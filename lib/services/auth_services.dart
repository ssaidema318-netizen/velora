import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailandPassword(String email, String password);
  Future<bool> registerWithEmailandPassword(String email, String password);
  Future<bool> signInWithGoogle();
  Future<bool> signInWithFacebook();
  User? currentUser();
  Future<void> logOut();
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<bool> loginWithEmailandPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailandPassword(
    String email,
    String password,
  ) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }

  @override
  Future<void> logOut() async{
    await  _firebaseAuth.signOut();
      }

  @override
  Future<bool> signInWithGoogle() async{
    final googleUser = await GoogleSignIn.instance.authenticate();
    final googleAuth =  googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken
    );
    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return userCredential.user != null;

  }

  @override
  Future<bool> signInWithFacebook() async{
     try {
  final LoginResult loginResult = await FacebookAuth.instance.login(
    permissions: ['public_profile', 'email'],
  );

  if (loginResult.status != LoginStatus.success || loginResult.accessToken == null) {
    return false;
  }

  final credential = FacebookAuthProvider.credential(
    loginResult.accessToken!.tokenString,
  );

  final userCredential = await _firebaseAuth.signInWithCredential(credential);
  return userCredential.user != null;
} catch (e) {
  return false;
}

  }

  
}
