import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onestop_kit/onestop_kit.dart';

class CustomTextField extends StatefulWidget {
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final String? label;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  final String? value;
  final void Function(String)? onChanged;
  final bool isNecessary;
  final TextEditingController? controller;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool? isEnabled;
  final int? maxLength;
  final int? maxLines;
  final bool? counter;

  const CustomTextField({
    super.key,
    this.hintText,
    this.label,
    this.validator,
    this.value,
    this.onChanged,
    required this.isNecessary,
    this.inputType,
    this.controller,
    this.onTap,
    this.isEnabled,
    this.focusNode,
    this.maxLength,
    this.maxLines,
    this.counter,
    this.inputFormatters,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    Widget? counterBuilder(context,
        {required currentLength, required isFocused, required maxLength}) {
      if (currentLength == 0) {
        return null;
      }
      return Text("$currentLength/$maxLength",
          style: OnestopFonts.w500.size(12).setColor(OneStopColors.kWhite));
    }

    return TextFormField(
      inputFormatters: widget.inputFormatters,
      enabled: widget.isEnabled ?? true,
      readOnly: widget.onTap != null,
      style: OnestopFonts.w500.size(14).copyWith(color: Colors.white),
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      cursorColor: OneStopColors.primaryColor,
      onTap: widget.onTap,
      onChanged: widget.onChanged,
      buildCounter: widget.counter == true ? counterBuilder : null,
      initialValue: widget.value == 'null' ? '' : widget.value,
      keyboardType: widget.inputType,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        errorStyle: OnestopFonts.w500,
        hintText: widget.hintText,
        label: widget.hintText == null
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: widget.label,
                      style: OnestopFonts.w500
                          .size(14)
                          .setColor(OneStopColors.cardFontColor2),
                    ),
                    if (widget.isNecessary)
                      TextSpan(
                        text: ' * ',
                        style: OnestopFonts.w500
                            .size(16)
                            .setColor(OneStopColors.errorRed),
                      ),
                  ],
                ),
              )
            : null,
        labelStyle:
            OnestopFonts.w500.size(14).setColor(OneStopColors.cardFontColor2),
        hintStyle:
            OnestopFonts.w500.size(14).setColor(OneStopColors.cardFontColor2),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: OneStopColors.focusColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: OneStopColors.focusColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: OneStopColors.focusColor, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: OneStopColors.errorRed, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: OneStopColors.errorRed, width: 1),
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
    );
  }
}
