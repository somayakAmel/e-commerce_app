part of 'login_cubit.dart';

sealed class LoginState {}

final class UserLoginInitial extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure({required this.message});
}

class LoginLoading extends LoginState {}

class LoginChangePasswordVisibility extends LoginState {}

class SignOutSuccess extends LoginState {}

class SignOutFailure extends LoginState {}

class SignOutLoading extends LoginState {}
