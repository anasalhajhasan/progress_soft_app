import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:progress_soft_app/application_layer/props/main_dropdown_props/main_dropdown_props.dart';
import 'package:progress_soft_app/application_layer/resources/color_manager.dart';
import 'package:progress_soft_app/application_layer/resources/fonts_manager.dart';
import 'package:progress_soft_app/application_layer/resources/values_manager.dart';
import 'package:progress_soft_app/core/constants/assets.dart';

class MainDropdownButton extends StatelessWidget {
  const MainDropdownButton({super.key, required this.props});
  final MainDropDownProps props;

  @override
  Widget build(BuildContext context) {
    return Wrap(runSpacing: 0, children: [
      Row(
        children: [
          Text(
            props.labelText.tr(),
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: FontSize.s12,
                ),
          ),
          if (props.isRequired ?? false)
            Text(
              props.isRequired == true ? ' *' : '',
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: ColorManager.red,
                    fontSize: FontSize.s12,
                  ),
            )
        ],
      ),
      DropdownButtonHideUnderline(
        child: DropdownButtonFormField2<String>(
            // isExpanded: true,
            hint: Text(
              props.selectedItem ?? props.hintText.tr(),
              style: props.selectedItem == null
                  ? Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: ColorManager.grey,
                        fontWeight: FontWeight.w400,
                        fontSize: FontSize.s14,
                      )
                  : Theme.of(context).textTheme.headlineMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.s15,
                      color: ColorManager.black),
              overflow: TextOverflow.ellipsis,
            ),
            items: props.items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: ColorManager.black,
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.s14,
                            ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),

            // value: props.selectedItem,
            onChanged: (value) => props.onChanged(value),
            validator: props.validator,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.grey.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.grey.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.grey.withOpacity(0.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontSize: FontSize.s12,
                    color: ColorManager.red,
                    fontWeight: FontWeight.normal,
                    height: 1.5),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: ColorManager.red,
                  ),
                  borderRadius: BorderRadius.circular(10),
                )),
            buttonStyleData: const ButtonStyleData(
              height: AppSize.s20,
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(horizontal: AppPadding.p2),
            ),
            dropdownStyleData: _dropDownStyleDate(context),
            iconStyleData: _iconStyleData(context)),
      ),
    ]);
  }

  Color _getColor() {
    return ColorManager.grey.withOpacity(0.5);
  }

  DropdownStyleData _dropDownStyleDate(BuildContext context) =>
      DropdownStyleData(
        // width: MediaQuery.sizeOf(context).width / 1.3,
        maxHeight: MediaQuery.sizeOf(context).height / 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
        ),
        // offset: const Offset(, 0),
      );

  IconStyleData _iconStyleData(BuildContext context) => IconStyleData(
        icon: SvgPicture.asset(Assets.dropdownIcon),
      );
}
