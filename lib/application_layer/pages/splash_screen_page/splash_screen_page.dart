import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/system_config_bloc/system_config_bloc.dart';
import 'package:progress_soft_app/application_layer/pages/home_page/home_page.dart';
import 'package:progress_soft_app/application_layer/pages/login_page/login_page.dart';
import 'package:progress_soft_app/core/constants/assets.dart';
import 'package:progress_soft_app/core/constants/navigations.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/data_layer/models/user_data_model/user_data_model.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    _onInit(context);
    super.initState();
  }

  void _onInit(BuildContext context) async {
    BlocProvider.of<SystemConfigBloc>(context).add(SystemConfigLoadEvent());
    final RxSharedPreferences rxPrefs = RxSharedPreferences.getInstance();
    String? mobileNumber = await rxPrefs.getString('mobileNumber');
    if (mobileNumber != null) {
      UserDataModel.mobileNumber = await rxPrefs.getString('mobileNumber');
      UserDataModel.age = await rxPrefs.getString('age');
      UserDataModel.gender = await rxPrefs.getString('gender');
      UserDataModel.password = await rxPrefs.getString('password');
      UserDataModel.fullName = await rxPrefs.getString('fullName');
      Future.delayed(
        const Duration(seconds: 2),
        () => navigateWithReplacement(
          context: context,
          pageName: const HomePage(),
        ),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 2),
        () => navigateWithReplacement(
          context: context,
          pageName: const LoginPage(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [_logoWidget(), _copyrightTextWidget()],
        ),
      ),
    );
  }

  Expanded _logoWidget() => Expanded(
        child: Center(
          child: Image.asset(
            Assets.logo,
            width: MediaQuery.sizeOf(context).width / 1.8,
            height: MediaQuery.sizeOf(context).height / 1.8,
          ),
        ),
      );

  Text _copyrightTextWidget() => Text(
        Strings.copyright.tr(),
        style: Theme.of(context).textTheme.bodyLarge,
        maxLines: 1,
      );
}
