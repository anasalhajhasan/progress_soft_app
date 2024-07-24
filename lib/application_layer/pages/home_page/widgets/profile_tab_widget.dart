import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_soft_app/application_layer/pages/login_page/login_page.dart';
import 'package:progress_soft_app/application_layer/resources/fonts_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:progress_soft_app/core/constants/navigations.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/core/widgets/main_button_widget/main_button_widget.dart';
import 'package:progress_soft_app/data_layer/models/user_data_model/user_data_model.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class ProfileTabWidget extends StatelessWidget {
  const ProfileTabWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Text(
              UserDataModel.fullName ?? '',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: FontSize.s23),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppPadding.p8, horizontal: AppPadding.p8),
                child: Column(
                  children: List.generate(
                      5,
                      (index) => Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  if (index == 0) ...[
                                    Text(
                                      Strings.age.tr(),
                                      style: getStyle(context),
                                    ),
                                    Text(
                                      UserDataModel.age ?? '',
                                      style: getStyle(context),
                                    ),
                                  ] else if (index == 1) ...[
                                    Text(
                                      Strings.gender.tr(),
                                      style: getStyle(context),
                                    ),
                                    Text(
                                      UserDataModel.gender ?? '',
                                      style: getStyle(context),
                                    ),
                                  ] else if (index == 2) ...[
                                    Text(
                                      Strings.mobileNumber.tr(),
                                      style: getStyle(context),
                                    ),
                                    Text(
                                      UserDataModel.mobileNumber ?? '',
                                      style: getStyle(context),
                                    ),
                                  ]
                                ],
                              )
                            ],
                          )),
                ),
              ),
            ),
          ],
        ),
        MainButton(
          onPressed: () => _logout(context),
          elevation: 5,
          size: '',
          child: Text(
            Strings.logout.tr(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                  color: Theme.of(context).canvasColor,
                ),
          ),
        ),
      ],
    );
  }

  void _logout(BuildContext context) async {
    SharedPreferences rxPrefs = await SharedPreferences.getInstance();
    rxPrefs.remove('mobileNumber');
    rxPrefs.remove('password');
    rxPrefs.remove('gender');
    rxPrefs.remove('age');
    rxPrefs.remove('fullName');

    await FirebaseAuth.instance.signOut();

    navigateWithReplacement(context: context, pageName: const LoginPage());
  }

  getStyle(BuildContext context) {
    return Theme.of(context).textTheme.displayMedium!.copyWith(
          color: Theme.of(context).hintColor,
        );
  }
}
