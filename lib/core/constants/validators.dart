import 'package:easy_localization/easy_localization.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/data_layer/models/config_model/config_model.dart';

class Validators {
  static final Validators _instance = Validators._internal();

  factory Validators() {
    return _instance;
  }

  Validators._internal();

  String? validateMobile(String value) {
    if (value.isEmpty) {
      return Strings.mobileNumberIsRequired.tr();
    } else if (!RegExp(Config.mobileRegex ?? '').hasMatch(value)) {
      return Strings.enterAValidMobileNumber.tr();
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return Strings.passwordIsRequired.tr();
    } else if (!RegExp(Config.passwordRegex ?? '').hasMatch(value)) {
      return Strings.enterAValidMobileNumber.tr();
    }
    return null;
  }

  String? validateField(String? value) {
    if (value!.isEmpty) {
      return Strings.fieldIsRequired.tr();
    }
    return null;
  }
}
