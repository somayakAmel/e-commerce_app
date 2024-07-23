part of 'register_cubit.dart';

abstract class RegisterState {}

final class UserRegisterInitial extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure({required this.message});
}

class RegisterLoading extends RegisterState {}

class CreateFailure extends RegisterState {
  final String message;

  CreateFailure({required this.message});
}

class RegisterChangePasswordVisibility extends RegisterState {}

class SignOutLoading extends RegisterState {}

class SignOutSuccess extends RegisterState {}

class SignOutFailure extends RegisterState {}
