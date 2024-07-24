import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:progress_soft_app/application_layer/pages/home_page/home_page.dart';
import 'package:progress_soft_app/application_layer/pages/register_page/register_page.dart';
import 'package:progress_soft_app/core/constants/navigations.dart';
import 'package:progress_soft_app/core/widgets/custom_dialogs/custom_dialogs.dart';
import 'package:progress_soft_app/data_layer/models/config_model/config_model.dart';
import 'package:progress_soft_app/data_layer/models/user_data_model/user_data_model.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseFirestore _firestore;

  LoginBloc(this._firestore) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: '${event.mobileNumber}@progress-soft-app.com',
              password: event.password)
          .then((value) async {
        // Check if the user is registered in Firestore
        log(event.mobileNumber);
        var userDoc = await _firestore
            .collection('users')
            .doc('${Config.countryCode}${event.mobileNumber}')
            .get();

        // if user does not exist
        if (!userDoc.exists) {
          emit(UserNotRegistered());
          CustomDialogs.showRegistrationDialog(
            navigatorKey.currentContext!,
            onRegister: () {
              navigatePush(
                context: navigatorKey.currentContext!,
                pageName: const RegisterPage(),
              );
            },
          );
          return;
        }

        // Validate password
        if (userDoc['password'] == event.password) {
          // Save credentials for auto-login
          final RxSharedPreferences rxPrefs = RxSharedPreferences.getInstance();
          rxPrefs.setString('mobileNumber', event.mobileNumber);
          rxPrefs.setString('password', event.password);
          rxPrefs.setString('gender', userDoc['gender']);
          rxPrefs.setString('age', userDoc['age']);
          rxPrefs.setString('fullName', userDoc['full_name']);

          UserDataModel.password = await rxPrefs.getString('password');
          UserDataModel.mobileNumber = await rxPrefs.getString('mobileNumber');
          UserDataModel.gender = await rxPrefs.getString('gender');
          UserDataModel.age = await rxPrefs.getString('age');
          UserDataModel.fullName = await rxPrefs.getString('fullName');

          navigatePush(
              context: navigatorKey.currentContext!,
              pageName: const HomePage());

          emit(LoginSuccess());
        } else {
          // Use error message from system configuration
          String errorMessage =
              Config.incorrectPasswordMessage ?? 'Incorrect password';
          emit(IncorrectPassword(errorMessage));
          CustomDialogs.showErrorDialog(
              navigatorKey.currentContext!, errorMessage);
        }
      }).onError((error, stackTrace) {
        CustomDialogs.showErrorDialog(
            navigatorKey.currentContext!, error.toString());
      });
    } catch (e) {
      emit(LoginError(e.toString()));
      CustomDialogs.showErrorDialog(navigatorKey.currentContext!, e.toString());
    }
  }
}
