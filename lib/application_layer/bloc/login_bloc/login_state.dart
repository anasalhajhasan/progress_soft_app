part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

class UserNotRegistered extends LoginState {}

class IncorrectPassword extends LoginState {
  final String errorMessage;
  IncorrectPassword(this.errorMessage);
}
