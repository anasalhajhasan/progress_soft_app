part of 'register_bloc.dart';

abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String fullName;
  final String age;
  final String gender;
  final String mobileNumber;
  final String password;
  RegisterButtonPressed({
    required this.fullName,
    required this.age,
    required this.gender,
    required this.mobileNumber,
    required this.password,
  });
}

class VerifyButtonPressed extends RegisterEvent {
  final String otpValue;
  final String verificationId;
  VerifyButtonPressed({required this.otpValue, required this.verificationId});
}
