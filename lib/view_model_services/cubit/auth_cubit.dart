import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velora/constants/api_paths.dart';
import 'package:velora/models/user_data.dart';
import 'package:velora/services/auth_services.dart';
import 'package:velora/services/firestore_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthServices authServices = AuthServicesImpl();
  final firestoreServices = FirestoreServices.instance;
  AuthCubit() : super(AuthInitial());
  Future<void> logInWithEmailAndPassword(String email, String password) async {
    final AuthServices authServices = AuthServicesImpl();
    emit(AuthLoading());
    try {
      final result = await authServices.loginWithEmailandPassword(
        email,
        password,
      );
      if (result) {
        
        emit(AuthDone());
      } else {
        emit(AuthError(message: "Login Failed"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> registerWithEmailandPassword(
    String username,
    String email,
    String password,
    String phone
  ) async {
    final AuthServices authServices = AuthServicesImpl();
    emit(AuthLoading());
    try {
      final result = await authServices.registerWithEmailandPassword(
        email,
        password,

      );
      if (result) {
        _saveUserData(username, email,phone);
        emit(AuthDone());
      } else {
        emit(AuthError(message: "register Failed"));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  void checkAuth() {
    final AuthServices authServices = AuthServicesImpl();
    final user = authServices.currentUser();
    if (user != null) {
      emit(AuthDone());
    }
  }

  Future<void> logOut() async {
    final AuthServices authServices = AuthServicesImpl();
    emit(AuthLogingout());
    try {
      await authServices.logOut();
      await GoogleSignIn.instance.signOut();
      await FacebookAuth.instance.logOut();
      emit(AuthLogedout());
    } catch (e) {
      emit(AuthLogError(message: e.toString()));
    }
  }
  Future<void> signInwithGoogle() async{
    final AuthServices authServices = AuthServicesImpl();
    emit(GoogleLoading());
    try{
      final result = await authServices.signInWithGoogle();
      if(result){
        emit(GoogleDone());
      } else{
        emit(AuthError(message: "Google Login Failed"));
      }
    }catch (e){
      emit(GoogleError(message: e.toString()));
    }
  }
  Future<void> signInwithFacebook() async{
    final AuthServices authServices = AuthServicesImpl();
    emit(FacebookAuthLoading());
    try{
      final result = await authServices.signInWithFacebook();
      if(result){
        emit(FacebookAuthDone());
      } else{
        emit(FacebookAuthError(message: "Facebook Login Failed"));
      }
    }catch (e){
      emit(FacebookAuthError(message: e.toString()));
    }
  }
  Future<void> _saveUserData(String username,String email,String phone) async{
    final currentUser = authServices.currentUser();
    final userData = UserData(id: currentUser!.uid, name: username, email: email,phone: phone);
    await firestoreServices.setData(path: ApiPaths.user(userData.id), data: userData.toMap());
  }
}
  

