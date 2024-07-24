import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/age_bloc/age_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/gender_bloc/gender_bloc.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/register_bloc.dart';
import 'package:progress_soft_app/application_layer/props/main_dropdown_props/main_dropdown_props.dart';
import 'package:progress_soft_app/application_layer/resources/color_manager.dart';
import 'package:progress_soft_app/application_layer/resources/fonts_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/core/constants/validators.dart';
import 'package:progress_soft_app/core/widgets/main_button_widget/main_button_widget.dart';
import 'package:progress_soft_app/core/widgets/main_dropdown_button_widget/main_dropdown_button_widget.dart';
import 'package:progress_soft_app/core/widgets/main_text_field_widget/main_text_field_widget.dart';
import 'package:progress_soft_app/data_layer/models/config_model/config_model.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final Validators _validators = Validators();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void deactivate() {
    context.read<AgeBloc>().reset();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Form(
              key: _registerFormKey,
              child: Column(
                children: [
                  _fullNameTextField(),
                  _mobileTextField(),
                  _passwordTextField(),
                  _confirmPasswordTextField(),
                  _genderDropDownWidget(),
                  _ageWidget(),
                  _registerbuttonWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _fullNameTextField() {
    return MainTextField(
      controller: _fullNameController,
      labelText: Strings.fullName.tr(),
      hintText: Strings.typeYourName.tr(),
      keyboardType: TextInputType.text,
      isRequired: true,
      validator: (String? value) => _validators.validateField(value!),
    );
  }

  Widget _mobileTextField() {
    return MainTextField(
      controller: _mobileController,
      labelText: Strings.mobileNumber.tr(),
      hintText: Strings.enterMobileNumber.tr(),
      keyboardType: TextInputType.phone,
      isRequired: true,
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
      suffixIcon: BlocBuilder<RegisterBloc, RegisterState>(
        builder: (context, state) {
          return state is VerifyOtpSuccess
              ? Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: AppPadding.p14, right: AppPadding.p14),
                    child: Text(
                      Strings.verified.tr(),
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                color: ColorManager.green,
                                fontSize: FontSize.s13,
                              ),
                    ),
                  ),
                )
              : TextButton(
                
                  onPressed: () =>
                      BlocProvider.of<RegisterBloc>(context, listen: false)
                          .onPressedVerifyPhone(_mobileController.text.trim()),
                  child: Text(
                    Strings.verify.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(color: Theme.of(context).primaryColor),
                  ),
                );
        },
      ),
      validator: (String? value) => _validators.validateMobile(value!),
    );
  }

  // gender drop down
  Widget _genderDropDownWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: AppPadding.p8),
      child: MainDropdownButton(
        props: MainDropDownProps(
          labelText: Strings.gender.tr(),
          hintText: Strings.gender.tr(),
          isRequired: true,
          items: [Strings.male.tr(), Strings.female.tr()],
          selectedItem: context.read<GenderBloc>().selectedGender,
          validator: (value) => _validators.validateField(value ?? ''),
          onChanged: (value) => context.read<GenderBloc>().add(
                GenderChanged(value!),
              ),
        ),
      ),
    );
  }

  Widget _ageWidget() {
    var selectedAge = context.watch<AgeBloc>().selectedAge;
    return Padding(
      padding:
          const EdgeInsets.only(top: AppPadding.p12, bottom: AppPadding.p8),
      child: Wrap(
        runSpacing: 4,
        children: [
          Row(
            children: [
              Text(
                Strings.age.tr(),
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w800,
                      fontSize: FontSize.s12,
                    ),
              ),
              Text(
                ' *',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: ColorManager.red,
                      fontSize: FontSize.s12,
                    ),
              )
            ],
          ),
          InkWell(
            onTap: () => showAgePicker(context),
            splashColor: ColorManager.grey,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: AppSize.s50,
              width: double.maxFinite,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: _registerFormKey.currentState?.validate() ??
                            true && selectedAge == null
                        ? ColorManager.grey.withOpacity(0.5)
                        : ColorManager.red),
              ),
              child: Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                    child: Text(
                      selectedAge != null
                          ? '${DateTime.now().year - selectedAge.year}'
                          : Strings.age.tr(),
                      style: selectedAge == null
                          ? Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                color: ColorManager.grey,
                                fontWeight: FontWeight.w400,
                                fontSize: FontSize.s14,
                              )
                          : Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                  fontWeight: FontWeight.w400,
                                  fontSize: FontSize.s14,
                                  color: ColorManager.black),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!(_registerFormKey.currentState?.validate() ?? true) &&
              selectedAge == null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p14),
              child: Text(
                Strings.fieldIsRequired.tr(),
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.s13,
                    color: ColorManager.red),
              ),
            )
        ],
      ),
    );
  }

  MainTextField _passwordTextField() {
    return MainTextField(
      controller: _passwordController,
      labelText: Strings.password.tr(),
      hintText: Strings.enterPassword.tr(),
      keyboardType: TextInputType.visiblePassword,
      isRequired: true,
      validator: (String? value) => _validators.validatePassword(value!),
    );
  }

  MainTextField _confirmPasswordTextField() {
    return MainTextField(
        controller: _confirmPasswordController,
        labelText: Strings.confirmPassword.tr(),
        hintText: Strings.typeYourConfirmPassword.tr(),
        keyboardType: TextInputType.visiblePassword,
        isRequired: true,
        validator: (String? value) {
          if (value != _passwordController.text) {
            return Strings.passwordDoesNotMatch.tr();
          } else {
            return _validators.validateField(value!);
          }
        });
  }

  MainButton _registerbuttonWidget() => MainButton(
        onPressed: () => _onPressedRegister(),
        elevation: 5,
        size: '',
        height: AppSize.s50,
        margin:
            const EdgeInsets.only(top: AppMargin.m20, bottom: AppMargin.m30),
        child: Text(
          Strings.register.tr(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).canvasColor,
              ),
        ),
      );

  void _onPressedRegister() {
    DateTime? selectedAge = context.read<AgeBloc>().selectedAge;
    if (_registerFormKey.currentState!.validate() && selectedAge != null) {
      String? selectedGender = context.read<GenderBloc>().selectedGender;
      context.read<RegisterBloc>().add(
            RegisterButtonPressed(
              fullName: _fullNameController.text.trim(),
              age: '${DateTime.now().year - selectedAge.year}',
              gender: selectedGender ?? '',
              mobileNumber: _mobileController.text.trim(),
              password: _passwordController.text,
            ),
          );
      // _mobileController.clear();
      // _passwordController.clear();
    }
    setState(() {});
  }

  void showAgePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1950, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (DateTime date) {
        context.read<AgeBloc>().add(AgeChanged(date));
      },
      currentTime: DateTime.now(),
    );
  }
}
