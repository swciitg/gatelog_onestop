import 'package:flutter/material.dart';
import 'package:khokha_entry/src/globals/my_fonts.dart';
import 'package:onestop_kit/onestop_kit.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String? hintText;
  final String? label;
  final Function? onChanged;
  final String? Function(String?)? validator;
  final int? index;
  final String? value;
  final BorderRadius? borderRadius;
  final bool? isNecessary;
  final Widget? icon;

  const CustomDropDown({
    super.key,
    required this.items,
    this.hintText,
    this.label,
    required this.onChanged,
    this.index,
    this.value,
    this.borderRadius,
    required this.validator,
    this.isNecessary = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      validator: validator,
      menuMaxHeight: 400,
      value: value,
      isExpanded: true,
      decoration: InputDecoration(
        hintText: hintText,
        label: hintText == null
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: label,
                      style: MyFonts.w500.size(14).setColor(OneStopColors.kTabText),
                    ),
                    isNecessary!
                        ? TextSpan(
                            text: ' * ',
                            style: MyFonts.w500.size(16).setColor(OneStopColors.kRed),
                          )
                        : const TextSpan(),
                  ],
                ),
              )
            : null,
        labelStyle: MyFonts.w500.size(14).setColor(OneStopColors.kTabText),
        hintStyle: MyFonts.w500.size(14).setColor(OneStopColors.kTabText),
        errorStyle: MyFonts.w500,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: OneStopColors.kfocusColor, width: 1),
          borderRadius: borderRadius ??
              const BorderRadius.all(
                Radius.circular(4),
              ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: OneStopColors.kfocusColor, width: 1),
          borderRadius: borderRadius ??
              const BorderRadius.all(
                Radius.circular(4),
              ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: borderRadius ??
              const BorderRadius.all(
                Radius.circular(4),
              ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 1),
          borderRadius: borderRadius ??
              const BorderRadius.all(
                Radius.circular(4),
              ),
        ),
      ),
      dropdownColor: OneStopColors.kBackground,
      isDense: true,
      icon: icon ??
          const Icon(
            Icons.arrow_drop_down,
            size: 28,
          ),
      elevation: 16,
      style: MyFonts.w500.size(14).setColor(OneStopColors.kWhite),
      onChanged: (String? value) {
        if (index != null) {
          onChanged!(value, index);
        } else {
          onChanged!(value);
        }
      },
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
