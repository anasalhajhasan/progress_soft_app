part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String mobileNumber;
  final String password;
  LoginButtonPressed({required this.mobileNumber, required this.password});
}
