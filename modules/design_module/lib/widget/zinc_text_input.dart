import 'package:design_module/constants.dart';
import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_border_radius.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_padding.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum TextInputState {
  success,
  error,
  normal,
  disabled,
}

class ZincTextInput extends StatefulWidget {
  final TextEditingController fieldController;
  final String? bottomText;
  final TextStyle? bottomTextStyle;

  final FormFieldValidator<String>? validator;

  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final String placeholder;
  final String? label;
  final TextStyle? labelStyle;
  final TextStyle? placeholderStyle;
  final bool isEnabled;
  final TextInputState inputState;
  final String? leadingText;
  final TextStyle? textFieldStyle;
  final bool? autoFocus;
  final Color? cursorColor;
  final TextInputType? keybaordType;
  final Widget? rightIcon;
  final double? rightIconWidth;
  final double? rightIconHeight;
  final Function()? rightIconOnTap;
  final bool isObscureText;
  final int maxLines;
  final Widget? leftIcon;
  final Function()? leftIconOnTap;
  final String? obscuringCharacter;
  final Widget? showTextIcon;
  final Widget? hideTextIcon;
  final ZincInputFieldDropDownButton? dropDownWidget;

  const ZincTextInput({
    super.key,
    required this.fieldController,
    this.bottomText,
    this.bottomTextStyle,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    required this.placeholder,
    required this.label,
    this.labelStyle,
    this.placeholderStyle,
    this.isEnabled = true,
    required this.inputState,
    this.leadingText,
    this.textFieldStyle = const ZincTextStyle.normalBold(),
    this.cursorColor,
    this.keybaordType = TextInputType.name,
    this.rightIcon,
    this.rightIconOnTap,
    this.isObscureText = false,
    this.maxLines = 1,
    this.obscuringCharacter,
    this.showTextIcon,
    this.hideTextIcon,
    this.dropDownWidget,
    this.rightIconWidth,
    this.rightIconHeight,
    this.leftIcon,
    this.leftIconOnTap,
    this.autoFocus = false
  });

  @override
  State<ZincTextInput> createState() => _ZincTextInputState();
}

class _ZincTextInputState extends State<ZincTextInput> {
  final FocusNode _focusNode = FocusNode();
  bool isFocused = false;
  bool showLabel = false;
  bool isEmptyError = false;
  bool hideTextVisibility = false;

  @override
  void initState() {
    _focusNode.addListener(_onFocusChange);
    hideTextVisibility = widget.isObscureText;
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      if (_focusNode.hasFocus) {
        isFocused = true;
      } else {
        isFocused = false;
      }
      _checkForEmptyError();
      _showPlaceholderAsLabel();
    });
  }

  void _showPlaceholderAsLabel() {
    setState(() {
      if (isFocused) {
        showLabel = true;
      } else {
        if (widget.fieldController.text.trim() != "") {
          showLabel = true;
        } else {
          showLabel = false;
        }
      }
    });
  }

  void _checkForEmptyError() {
    if (widget.inputState == TextInputState.error) {
      if (!isFocused && widget.fieldController.text.trim() == "") {
        isEmptyError = true;
      } else {
        isEmptyError = false;
      }
    } else {
      isEmptyError = false;
    }
  }

  Color _bgColorSpecifier(TextInputState inputState) {
    if (inputState == TextInputState.error) {
      return ErrorSurface().subtle;
    } else if (inputState == TextInputState.success) {
      return SuccessSurface().subtle;
    } else if (inputState == TextInputState.disabled) {
      return GreyscaleSurface().disabled;
    } else {
      return GreyscaleSurface().subtle;
    }
  }

  Color _helperTextColorSpecifier(TextInputState inputState) {
    if (inputState == TextInputState.error) {
      return ErrorTextIcon().label;
    } else if (inputState == TextInputState.success) {
      return SuccessTextIcon().label;
    } else {
      return GreyscaleText().subtitle;
    }
  }

  void _toggleTextVisibility() {
    setState(() {
      hideTextVisibility = !hideTextVisibility;
    });
  }

  Widget? _leftIconSpecifier() {
    if (widget.leftIcon == null) {
      return null;
    }

    return GestureDetector(
      onTap: widget.leftIconOnTap,
      child: Container(
        padding: EdgeInsets.only(right: 4),
        height: 52,
        width: 52,
        child: widget.leftIcon,
      ),
    );
  }

  Widget? _rightIconSpecifier() {
    Widget? rightIcon;
    if (widget.isObscureText) {
      if (widget.showTextIcon == null && widget.hideTextIcon == null) {
        throw Exception(
            "showTextIcon and hideTextIcon can't be null when you are passing isObscureText as true, please give showtextIcon and hideTextIcon");
      } else {
        rightIcon =
            hideTextVisibility ? widget.hideTextIcon : widget.showTextIcon;
      }
    } else if (widget.rightIcon != null) {
      if (widget.inputState == TextInputState.error ||
          widget.inputState == TextInputState.success) {
        throw Exception(
            "you shouldn't assign right icon with input state of ${widget.inputState.name}");
      }
    } else if (widget.rightIcon == null) {
      if (widget.inputState != TextInputState.error &&
          widget.inputState != TextInputState.success) {
        return null;
      }
    }

    return GestureDetector(
      onTap: () {
        if (widget.rightIconOnTap != null && widget.isObscureText) {
          throw Exception(
              "you can't assign rightIconOnTap with isObscureText as true");
        } else if (widget.isObscureText) {
          _toggleTextVisibility();
        } else if (widget.rightIconOnTap != null) {
          if (widget.inputState != TextInputState.error ||
              widget.inputState != TextInputState.success ||
              widget.inputState != TextInputState.disabled) {
            widget.rightIconOnTap!();
          }
        }
      },
      child: Container(
        margin: ZincPadding.l8r2Margin,
        padding: ZincPadding.allXxs,
        height:
            widget.rightIconHeight ?? AppDimens.textFieldStateIconContainerSize,
        width:
            widget.rightIconWidth ?? AppDimens.textFieldStateIconContainerSize,
        child: widget.isObscureText
            ? rightIcon
            : (widget.inputState == TextInputState.error ||
                    widget.inputState == TextInputState.success)
                ? SvgPicture.asset(
                    widget.inputState == TextInputState.error
                        ? "${AssetPaths.svgAsset}ic_warning_circle_outlined.svg"
                        : "${AssetPaths.svgAsset}ic_check_circled_outline.svg",
                    colorFilter: ColorFilter.mode(
                      widget.inputState == TextInputState.error
                          ? ErrorTextIcon().label
                          : SuccessTextIcon().label,
                      BlendMode.srcIn,
                    ),
                  )
                : widget.rightIcon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: ZincPadding.ltrbTextFieldParentContainer,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //inner input container with bg color
          ///code for on field tap focus
          ///// onTap: widget.inputState == TextInputState.disabled
          //     ? null
          //     : () {
          //         _focusNode.requestFocus();
          //       },
          Container(
            padding: ZincPadding.hv14,
            constraints: const BoxConstraints(
              minHeight: 40,
            ),
            decoration: BoxDecoration(
              color: _bgColorSpecifier(widget.inputState),
              borderRadius: ZincBorderRadius.l,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Add left icon if present
                if (widget.leftIcon != null) _leftIconSpecifier()!,
                //dropdown
                if (widget.dropDownWidget != null) widget.dropDownWidget!,
                //showing text as leading text --on empty field && not focused field
                if (!isFocused && widget.fieldController.text.trim() == "")
                  Container(
                    padding: widget.fieldController.text.trim() != ""
                        ? ZincPadding.onlyTop18
                        : isEmptyError
                            ? const EdgeInsets.only(bottom: 2)
                            : ZincPadding.onlyTop7,
                    child: Text(
                      widget.leadingText ?? "",
                      style: widget.textFieldStyle ??
                          const ZincTextStyle.normalBold(),
                    ),
                  ),

                //textfield
                Expanded(
                  child: TextFormField(
                    autofocus: widget.autoFocus ?? false,
                    style: widget.textFieldStyle,
                    controller: widget.fieldController,
                    autocorrect: false,
                    enableSuggestions: false,
                    //disabling text field if state is disabled and also using value from user
                    enabled: widget.inputState == TextInputState.disabled
                        ? false
                        : widget.isEnabled,
                    focusNode: _focusNode,
                    maxLines: widget.maxLines,
                    onChanged: widget.onChanged,
                    validator: widget.validator,
                    keyboardType: widget.keybaordType,
                    inputFormatters: widget.inputFormatters,
                    cursorColor:
                        widget.cursorColor ?? GreyscaleBorder().selected,
                    cursorHeight: 20,
                    obscureText: hideTextVisibility,
                    obscuringCharacter: widget.obscuringCharacter ?? '•',
                    decoration: InputDecoration(
                      //showing prefix as leading text when textfield is not empty && isFocused
                      prefixText: widget.fieldController.text.trim() != ""
                          ? widget.leadingText
                          : isFocused
                              ? widget.leadingText
                              : null,
                      //adding textstyle to prefix when textfield is not empty && isFocused
                      prefixStyle: widget.fieldController.text.trim() != ""
                          ? widget.textFieldStyle
                          : isFocused
                              ? widget.textFieldStyle
                              : null,
                      //showing only label when state is error (empty error) and there is no text in textfield --basically empty error state on figma
                      floatingLabelBehavior: isEmptyError
                          ? FloatingLabelBehavior.auto
                          : FloatingLabelBehavior.always,
                      border: InputBorder.none,
                      hintText: widget.placeholder,
                      hintStyle: widget.placeholderStyle ??
                          const ZincTextStyle.normalBold().copyWith(
                            color: GreyscaleText().placeholder,
                          ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      suffixIcon: _rightIconSpecifier(),
                      suffixIconConstraints: BoxConstraints(
                        minHeight: widget.rightIconHeight ??
                            AppDimens.textFieldStateIconContainerSize,
                        minWidth: widget.rightIconWidth ??
                            AppDimens.textFieldStateIconContainerSize,
                      ),
                      //calculating to show label as heading, on empty error state
                      labelText: isEmptyError
                          ? widget.label
                          : showLabel
                              ? widget.label
                              : null,
                      labelStyle: widget.labelStyle ??
                          const ZincTextStyle.moderateSemiBold().copyWith(
                            color: GreyscaleText().subtitle,
                          ),
                    ),
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
              ],
            ),
          ),
          //helper text
          if (widget.bottomText != null && widget.bottomText!.isNotEmpty)
            Padding(
              padding: ZincPadding.onlyTopSmall,
              child: Text(
                widget.bottomText!,
                style: widget.bottomTextStyle ??
                    const ZincTextStyle.tinySemiBold().copyWith(
                      color: _helperTextColorSpecifier(widget.inputState),
                    ),
              ),
            )
        ],
      ),
    );
  }
}

class ZincInputFieldDropDownButton extends StatelessWidget {
  const ZincInputFieldDropDownButton({
    super.key,
    this.title = "",
    required this.selected,
    this.onTap,
    this.labelStyle,
  });

  final String title;
  final String? selected;
  final Function()? onTap;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (title != "")
                Text(
                  title,
                  style: labelStyle ??
                      const ZincTextStyle.smallSemiBold().copyWith(
                        color: GreyscaleText().subtitle,
                      ),
                ),
              if (selected != null)
                Text(
                  selected!,
                  style: const ZincTextStyle.normalBold(),
                ),
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child:
                  SvgPicture.asset("${AssetPaths.svgAsset}ic_arrow_down.svg"),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 8),
            color: GreyscaleBorder().defaultC,
            width: 1,
            height: 24,
          ),
        ],
      ),
    );
  }
}
