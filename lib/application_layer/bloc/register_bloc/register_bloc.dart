import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/age_bloc/age_bloc.dart';
import 'package:progress_soft_app/application_layer/pages/login_page/login_page.dart';
import 'package:progress_soft_app/application_layer/pages/otp_page/otp_page.dart';
import 'package:progress_soft_app/core/constants/navigations.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/core/widgets/custom_dialogs/custom_dialogs.dart';
import 'package:progress_soft_app/data_layer/models/config_model/config_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final FirebaseFirestore _firestore;

  RegisterBloc(this._firestore) : super(RegisterInitial()) {
    on<RegisterButtonPressed>(_onRegisterButtonPressed);
    on<VerifyButtonPressed>(_verifyButtonPressed);
  }

  Future<void> _onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      // Save the user on Firebase Auth
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: '${event.mobileNumber}@progress-soft-app.com',
        password: event.password,
      );

      // Save the user on Firebase Cloud Firestore
      await _firestore
          .collection('users')
          .doc('${Config.countryCode}${event.mobileNumber}')
          .set({
        'full_name': event.fullName,
        'mobile_number': '${Config.countryCode}${event.mobileNumber}',
        'password': event.password,
        'age': event.age,
        'gender': event.gender,
      });
      emit(RegisterSuccess());

      navigateWithReplacement(
          context: navigatorKey.currentContext!, pageName: const LoginPage());
      CustomDialogs.showSuccessDialog(navigatorKey.currentContext!,
          Strings.accountCreatedsuccessfully.tr());

      BlocProvider.of<AgeBloc>(navigatorKey.currentContext!).reset();
    } catch (e) {
      emit(RegisterError(e.toString()));
      CustomDialogs.showErrorDialog(navigatorKey.currentContext!, e.toString());
    }
  }

  void onPressedVerifyPhone(String mobileNumber) async {
    // Send OTP
    if (mobileNumber.isNotEmpty) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '${Config.countryCode}$mobileNumber',
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
                SnackBar(
                    content:
                        Text('${Strings.somethingWrong.tr()}${e.message}')));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // Handle auto-retrieval timeout
            ScaffoldMessenger.of(navigatorKey.currentContext!).showSnackBar(
              const SnackBar(content: Text('SMS timeout. Please try again.')),
            );
          },
          codeSent: (String verificationId, int? resendToken) => navigatePush(
            context: navigatorKey.currentContext!,
            pageName: OtpPage(verificationId: verificationId),
          ),
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> _verifyButtonPressed(
    VerifyButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(VerifyOtpLoading());
    try {
      final credential = PhoneAuthProvider.credential(
        smsCode: event.otpValue,
        verificationId: event.verificationId,
      );
      log(credential.toString());

      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        // If successful, show a success message and navigate back

        emit(VerifyOtpSuccess());

        goBack(context: navigatorKey.currentContext!);
        CustomDialogs.showSuccessDialog(
          navigatorKey.currentContext!,
          Strings.otpVerifiedSuccessfully.tr(),
        );
      }).onError((error, __) {
        CustomDialogs.showErrorDialog(
            navigatorKey.currentContext!, Strings.invalidOtp.tr());
        emit(VerifyOtpError());
      });
    } catch (e) {
      // Handle general errors
      CustomDialogs.showErrorDialog(
          navigatorKey.currentContext!, Strings.somethingWrong.tr());
      emit(VerifyOtpError());
    }
  }
}
