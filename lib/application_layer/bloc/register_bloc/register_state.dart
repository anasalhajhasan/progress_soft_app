part of 'register_bloc.dart';

// @immutable
abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);
}

class VerifyOtpLoading extends RegisterState {}

class VerifyOtpError extends RegisterState {}

class VerifyOtpSuccess extends RegisterState {}
