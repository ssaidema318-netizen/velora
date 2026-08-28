part of 'auth_cubit.dart';


sealed class AuthState {}

final class AuthInitial extends AuthState {}
final class AuthLoading extends AuthState {}
final class AuthDone extends AuthState {}
final class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

}
final class AuthLogedout extends AuthState {}
final class AuthLogingout extends AuthState {}
final class AuthLogError extends AuthState {
  final String message;

  AuthLogError({required this.message});
  
}
final class GoogleLoading extends AuthState {}
final class GoogleDone extends AuthState {}
final class GoogleError extends AuthState {
  final String message;

  GoogleError({required this.message});

}
final class FacebookAuthLoading extends AuthState {}
final class FacebookAuthDone extends AuthState {}
final class FacebookAuthError extends AuthState {
  final String message;

  FacebookAuthError({required this.message});

}
