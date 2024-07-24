import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:progress_soft_app/core/constants/navigations.dart';
import 'package:progress_soft_app/core/constants/strings.dart';

class CustomDialogs {
  static void showRegistrationDialog(
    BuildContext context, {
    required VoidCallback onRegister,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.userNotRegistered.tr()),
        content: Text(Strings.thisUserNotRegistered.tr()),
        actions: [
          TextButton(
            onPressed: () {
              goBack(context: context);
            },
            child: Text(Strings.cancel.tr()),
          ),
          TextButton(
            onPressed: () {
              goBack(context: context);
              onRegister();
            },
            child: Text(Strings.register.tr()),
          ),
        ],
      ),
    );
  }

  static void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.error.tr()),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(Strings.ok.tr()),
          ),
        ],
      ),
    );
  }

  static void showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(Strings.success.tr()),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              goBack(context: context);
            },
            child: Text(Strings.ok.tr()),
          ),
        ],
      ),
    );
  }
}
