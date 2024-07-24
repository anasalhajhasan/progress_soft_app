import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:progress_soft_app/application_layer/bloc/register_bloc/register_bloc.dart';
import 'package:progress_soft_app/application_layer/resources/color_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:progress_soft_app/core/constants/strings.dart';
import 'package:progress_soft_app/core/constants/validators.dart';
import 'package:progress_soft_app/core/widgets/main_button_widget/main_button_widget.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key, required this.verificationId});
  final String verificationId;

  final GlobalKey<FormState> _otpFormKey = GlobalKey<FormState>();
  final TextEditingController _otpController = TextEditingController();
  final Validators _validators = Validators();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_otpTextField(context)],
      ),
    );
  }

  Container _otpTextField(BuildContext context) => Container(
        margin: const EdgeInsets.only(
          left: AppPadding.p20,
          right: AppPadding.p20,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: ColorManager.black.withOpacity(0.2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Form(
          key: _otpFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: AppPadding.p20),
                child: Center(
                  child: Text(
                    Strings.enterTheOtp.tr(),
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: AppPadding.p16,
                  left: AppPadding.p16,
                  top: AppPadding.p30,
                  bottom: AppPadding.p30,
                ),
                child: Pinput(
                  length: 6,
                  controller: _otpController,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (String? value) {
                    if (value?.isEmpty ?? true) {
                      _validators.validateField(value);
                    }
                    if (value?.length != 6) {
                      return Strings.fieldIsRequired.tr();
                    }
                    return null;
                  },
                  defaultPinTheme: PinTheme(
                    height: AppSize.s50,
                    textStyle: Theme.of(context).textTheme.displayMedium,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).dividerColor.withOpacity(0.1),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              _verifyOtpButtonWidget(context)
            ],
          ),
        ),
      );

  MainButton _verifyOtpButtonWidget(BuildContext context) => MainButton(
        onPressed: () => _onPressedVerifyOtpButton(context),
        elevation: 5,
        size: '',
        height: AppSize.s50,
        margin: const EdgeInsets.symmetric(
          horizontal: AppMargin.m20,
          vertical: AppMargin.m20,
        ),
        child: Text(
          Strings.verifyOtp.tr(),
          style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).canvasColor,
              ),
        ),
      );

  void _onPressedVerifyOtpButton(BuildContext context) {
    if (_otpFormKey.currentState!.validate()) {
      context.read<RegisterBloc>().add(
            VerifyButtonPressed(
              otpValue: _otpController.text,
              verificationId: verificationId,
            ),
          );
    }
  }
}
