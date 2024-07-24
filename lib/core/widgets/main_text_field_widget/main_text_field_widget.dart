import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:progress_soft_app/application_layer/resources/color_manager.dart';
import 'package:progress_soft_app/application_layer/resources/fonts_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';

class MainTextField extends StatelessWidget {
  const MainTextField({
    Key? key,
    required this.hintText,
    this.labelText,
    required this.isRequired,
    this.verifyEmail = false,
    this.onIconPressed,
    this.onEditingComplete,
    this.onSaved,
    this.textInputAction,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.initialValue,
    this.iconData,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
    this.isFirst,
    this.isLast,
    this.style,
    this.textAlign,
    this.onChanged,
    this.borderRadius,
    this.controller,
    this.isRaduis,
    this.maxLengthEnforced,
    this.maxLength,
    this.maxLines,
    this.svgpath = '',
    this.onFieldSubmitted,
    this.formatter,
  }) : super(key: key);

  final int? maxLines;
  final bool isRequired;
  final bool verifyEmail;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSaved;
  final FormFieldValidator<String?>? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final IconData? iconData;
  final String? svgpath;
  final bool? obscureText;
  final bool? isFirst;
  final bool? isLast;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final void Function(String)? onChanged;
  final BorderRadius? borderRadius;
  final bool? isRaduis;
  final bool? maxLengthEnforced;
  final int? maxLength;
  final List<TextInputFormatter>? formatter;
  final VoidCallback? onIconPressed;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.sizeOf(context);

    return Column(
      children: <Widget>[
        if (labelText != null)
          Padding(
            padding: const EdgeInsets.only(top: AppPadding.p8),
            child: SizedBox(
              width: mediaQuery.width,
              child: Row(
                children: <Widget>[
                  Text(
                    labelText?.tr() ?? '',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w800,
                          fontSize: FontSize.s12,
                        ),
                  ),
                  if (isRequired == true)
                    Text(
                      isRequired == true ? ' *' : '',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: ColorManager.red,
                                fontWeight: FontWeight.w800,
                                fontSize: FontSize.s12,
                              ),
                    )
                ],
              ),
            ),
          ),
        Padding(
          padding:
              const EdgeInsets.only(bottom: AppPadding.p8, top: AppPadding.p4),
          child: TextFormField(
            inputFormatters: formatter ?? <TextInputFormatter>[],
            textInputAction: textInputAction,
            initialValue: initialValue,
            controller: controller,
            keyboardType: keyboardType ?? TextInputType.text,
            onSaved: onSaved,
            onFieldSubmitted: onFieldSubmitted,
            onEditingComplete: onEditingComplete,
            onChanged: onChanged,
            validator: validator,
            cursorColor: Colors.black,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: FontSize.s15,
                color: Theme.of(context).hintColor),
            obscureText: obscureText ?? false,
            focusNode: focusNode,
            decoration: InputDecoration(
              fillColor: Theme.of(context).focusColor,
              counterText: '',
              contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12, vertical: AppPadding.p14),
              errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: FontSize.s12,
                    color: ColorManager.red,
                    fontWeight: FontWeight.normal,
                  ),
              // TextStyle(fontFamily: 'AvenirLTStd', fontSize: 12),
              disabledBorder: OutlineInputBorder(
                borderRadius:
                    borderRadius ?? const BorderRadius.all(Radius.circular(10)),
                borderSide:
                    BorderSide(color: ColorManager.grey.withOpacity(0.5)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    borderRadius ?? const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: ColorManager.grey.withOpacity(0.5),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    borderRadius ?? const BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(
                  color: ColorManager.grey.withOpacity(0.5),
                ),
              ),
              hintText: hintText!.tr(),
              alignLabelWithHint: true,
              hintStyle: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: FontSize.s14,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.hint,
                  ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                maxWidth: 150,
                maxHeight: 55,
                minHeight: 55,
                minWidth: suffixIcon != null ? 38 : 0,
              ),
              prefixIcon: prefixIcon,
              suffixIcon: Visibility(
                visible: svgpath != '' || svgpath != null,
                child: Container(
                  padding: const EdgeInsets.only(left: AppPadding.p14),
                  child: suffixIcon,
                ),
              ),
            ),
            maxLines: maxLines ?? 1,
            maxLength: maxLength,
          ),
        ),
      ],
    );
  }
}
