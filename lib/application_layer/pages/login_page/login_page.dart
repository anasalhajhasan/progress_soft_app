import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/login_bloc/login_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/system_config_bloc/system_config_bloc.dart';
import 'package:progress_soft_app/application_layer/pages/register_page/register_page.dart';
import 'package:progress_soft_app/application_layer/resources/color_manager.dart';
import 'package:progress_soft_app/application_layer/resources/fonts_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:progress_soft_app/core/constants/assets.dart';
import 'package:progress_soft_app/core/constants/navigations.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/core/constants/validators.dart';
import 'package:progress_soft_app/core/widgets/loading_widget/loading_widget.dart';
import 'package:progress_soft_app/core/widgets/main_button_widget/main_button_widget.dart';
import 'package:progress_soft_app/core/widgets/main_text_field_widget/main_text_field_widget.dart';
import 'package:progress_soft_app/data_layer/models/config_model/config_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final Validators _validators = Validators();

  @override
  void dispose() {
    _mobileController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<SystemConfigBloc, SystemConfigBlocState>(
      builder: (context, state) {
        return state is ConfigLoading
            ? const LoadingWidget()
            : SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    children: [
                      _changeLanguageWidget(),
                      _logoWidget(),
                      _mobileTextField(),
                      _passwordTextField(),
                      _loginbuttonWidget(),
                      _registerTextButtonWidget(),
                    ],
                  ),
                ),
              );
      },
    ));
  }

  Widget _changeLanguageWidget() => SafeArea(
        child: Align(
          alignment: AlignmentDirectional.centerEnd,
          child: IconButton(
            icon: Icon(
              Icons.language,
              color: ColorManager.hint,
            ),
            onPressed: () => _changeLanguage(),
          ),
        ),
      );

  Center _logoWidget() => Center(
        child: Image.asset(
          Assets.logo,
          height: MediaQuery.sizeOf(context).height / 3,
          width: MediaQuery.sizeOf(context).width / 1.9,
        ),
      );

  Padding _mobileTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: MainTextField(
        controller: _mobileController,
        labelText: Strings.mobileNumber.tr(),
        hintText: Strings.enterMobileNumber.tr(),
        keyboardType: TextInputType.phone,
        isRequired: false,
        prefixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(
                Config.countryCode ?? '',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: FontSize.s15,
                    color: Theme.of(context).hintColor),
              ),
            ),
          ],
        ),
        validator: (String? value) => _validators.validateMobile(value!),
      ),
    );
  }

  Padding _passwordTextField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: MainTextField(
        controller: _passwordController,
        labelText: Strings.password.tr(),
        hintText: Strings.enterPassword.tr(),
        keyboardType: TextInputType.visiblePassword,
        isRequired: false,
        validator: (String? value) => _validators.validatePassword(value!),
      ),
    );
  }

  MainButton _loginbuttonWidget() => MainButton(
        onPressed: () => _onPressedLogin(),
        elevation: 5,
        size: '',
        height: AppSize.s50,
        margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.m20,
          vertical: AppMargin.m20,
        ),
        child: Text(
          Strings.login.tr(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).canvasColor,
              ),
        ),
      );

  TextButton _registerTextButtonWidget() => TextButton(
        onPressed: () => navigatePush(
          context: context,
          pageName: const RegisterPage(),
        ),
        child: Text(
          Strings.register.tr(),
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).primaryColor,
                decoration: TextDecoration.underline,
              ),
        ),
      );

  void _changeLanguage() {
    final newLocale = context.locale == const Locale('en')
        ? const Locale('ar')
        : const Locale('en');
    context.setLocale(newLocale);
  }

  void _onPressedLogin() {
    if (_loginFormKey.currentState!.validate()) {
      context.read<LoginBloc>().add(
            LoginButtonPressed(
              mobileNumber: _mobileController.text.trim(),
              password: _passwordController.text.trim(),
            ),
          );
      _mobileController.clear();
      _passwordController.clear();
    }
  }
}
