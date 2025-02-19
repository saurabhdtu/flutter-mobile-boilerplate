import 'package:design_module/old_design/resources/color_manager.dart';
import 'package:design_module/old_design/resources/custom_text_style.dart';
import 'package:design_module/old_design/resources/font_manager.dart';
import 'package:design_module/old_design/resources/styles_manager.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFloatingTextField extends StatelessWidget {
  CustomFloatingTextField(
      {Key? key,
      this.alignment,
      this.width,
      this.scrollPadding,
      this.controller,
      this.focusNode,
      this.autofocus = false,
      this.textStyle,
      this.obscureText = false,
      this.textInputAction = TextInputAction.next,
      this.textInputType = TextInputType.text,
      this.maxLines,
      this.hintText,
      this.maxLength,
      this.hintStyle,
      this.labelText,
      this.enabled = true,
      this.labelStyle,
      this.prefix,
      this.prefixConstraints,
      this.prefixText,
      this.suffix,
      this.suffixConstraints,
      this.contentPadding,
      this.borderDecoration,
      this.fillColor,
      this.errorText,
      this.filled = true,
      this.validator,
      this.inputFormatters,
      this.autovalidateMode,
      this.autofillHints,
      this.textCapitalization,
      this.onChanged})
      : super(
          key: key,
        );

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool enabled;

  final bool? autofocus;
  final int? maxLength;

  final Function(String?)? onChanged;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final String? labelText;

  final String? prefixText;

  final String? errorText;

  final TextStyle? labelStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  final List<TextInputFormatter>? inputFormatters;

  final AutovalidateMode? autovalidateMode;

  final Iterable<String>? autofillHints;

  final TextCapitalization? textCapitalization;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: floatingTextFieldWidget(context))
        : floatingTextFieldWidget(context);
  }

  Widget floatingTextFieldWidget(BuildContext context) => SizedBox(
        width: width ?? double.maxFinite,
        child: TextFormField(
          autofillHints: autofillHints,
          autovalidateMode:
              autovalidateMode ?? AutovalidateMode.onUserInteraction,
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          textCapitalization: textCapitalization ?? TextCapitalization.words,
          inputFormatters: inputFormatters,
          onTapOutside: (event) {
            if (focusNode != null) {
              focusNode?.unfocus();
            } else {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          autofocus: autofocus!,
          maxLength: maxLength,
          style: textStyle ?? CustomTextStyles.titleMediumGray900,
          obscureText: obscureText!,
          textInputAction: textInputAction,
          keyboardType: textInputType,
          maxLines: maxLines ?? 1,
          decoration: decoration,
          validator: validator,
        ),
      );

  InputDecoration get decoration => InputDecoration(
        hintText: hintText ?? "",
        hintStyle: hintStyle ?? CustomTextStyles.titleMediumGray900,
        labelText: labelText ?? "",
        labelStyle: labelStyle?? ZincTextStyle.smallRegular(),
        prefixText: prefixText ?? "",
        prefixIcon: prefix,
        counterStyle: null,
        counterText: null,
        prefixIconConstraints: prefixConstraints,
        suffixIcon: suffix,
        errorText: errorText,
        suffixIconConstraints: suffixConstraints,
        isDense: true,
        contentPadding: contentPadding ?? EdgeInsets.fromLTRB(11, 38, 11, 11),
        fillColor: fillColor ??
            WidgetStateColor.resolveWith((Set<WidgetState> states) {
              if (states.contains(WidgetState.error)) {
                return ColorManager.errorBg;
              }
              return ColorManager.lightBlue;
            }),
        enabled: enabled,
        filled: filled,
        errorStyle:
            getRegularStyle(color: ColorManager.error, fontSize: FontSize.s12),
        border: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
        enabledBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
        focusedBorder: borderDecoration ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
      );
}
