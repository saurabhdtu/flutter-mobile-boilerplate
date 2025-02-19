import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_colors.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utility_module/extensions/num_extensions.dart';
import 'package:utility_module/extensions/string_extensions.dart';
import 'package:zinc/constants/strings.dart';

class AmountCollectConvertWidget extends StatefulWidget {
  final Function(String)? onSenderValueChange;
  final Function(String)? onReceiverValueChange;
  final Function? changeSenderCurrency;
  final Function? changeReceiverCurrency;
  final String? senderSymbol;
  final String? receiverSymbol;
  final String? senderCurrencyFlag;
  final String? receiverCurrencyFlag;
  final String? senderTitle;
  final String? receiverTitle;
  final String? senderCurrencyCode;
  final String? receiverCurrencyCode;
  final String? senderCurrencyTopLabel;
  final String? receiverCurrencyTopLabel;
  final int maxInputLength;
  final num receiverBySenderRatio;
  final num maxSenderLimit;

  AmountCollectConvertWidget(
      {this.onSenderValueChange,
      this.onReceiverValueChange,
      this.changeSenderCurrency,
      this.changeReceiverCurrency,
      this.senderSymbol,
      this.receiverSymbol,
      this.senderTitle,
      this.receiverTitle,
      this.senderCurrencyCode,
      this.receiverCurrencyCode,
      this.senderCurrencyFlag,
      this.receiverCurrencyFlag,
      this.receiverBySenderRatio = 1,
      this.senderCurrencyTopLabel,
      this.receiverCurrencyTopLabel,
      this.maxSenderLimit = double.maxFinite,
      this.maxInputLength = 12})
      : super(key: ValueKey("$senderCurrencyCode-$receiverBySenderRatio"));

  @override
  State<StatefulWidget> createState() => _AmountCollectConvertWidget();
}

class _AmountCollectConvertWidget extends State<AmountCollectConvertWidget> {
  late final TextEditingController _senderController;
  late final TextEditingController _receiverController;

/*
  @override
  void didUpdateWidget(AmountCollectConvertWidget oldWidget) {
    if (oldWidget.senderCurrencyCode != widget.senderCurrencyCode) {
      super.didUpdateWidget(widget);
    }
    super.didUpdateWidget(oldWidget);
  }
*/

  @override
  void initState() {
    super.initState();
    _receiverController = TextEditingController();
    _senderController = TextEditingController();
  }

  @override
  void dispose() {
    _receiverController.dispose();
    _senderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.senderCurrencyTopLabel != null)
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(22.0)),
                      color: PrimarySurface().darker),
                  child: Text(widget.senderCurrencyTopLabel!,
                      style: ZincTextStyle.tinySemiBold(
                          color: ZincColors.neutralWhite))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(widget.senderTitle ?? AppStrings.youSend,
                          style: ZincTextStyle.smallRegular(
                              color: GreyscaleText().body)),
                      _textField(context, _senderController, "sender",
                          widget.senderSymbol),
                    ])),
                const SizedBox(width: 20.0),
                _currencyAction(widget.changeSenderCurrency,
                    widget.senderCurrencyFlag, widget.senderCurrencyCode ?? "")
              ]),
            )
          ],
        ),
      ),
      const SizedBox(height: 12.0),
      DecoratedBox(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(22.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.receiverCurrencyTopLabel != null)
              Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(22.0)),
                      color: GreyscaleSurface().black),
                  child: Text(widget.receiverCurrencyTopLabel!,
                      style: ZincTextStyle.tinySemiBold(
                          color: ZincColors.neutralWhite))),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(children: [
                Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(widget.receiverTitle ?? AppStrings.theyGet,
                          style: ZincTextStyle.smallRegular(
                              color: GreyscaleText().body)),
                      const SizedBox(height: 4.0),
                      _textField(context, _receiverController, "receiver",
                          widget.receiverSymbol),
                    ])),
                const SizedBox(width: 20.0),
                _currencyAction(
                    widget.changeReceiverCurrency,
                    widget.receiverCurrencyFlag,
                    widget.receiverCurrencyCode ?? "")
              ]),
            )
          ],
        ),
      ),
      const SizedBox(height: 22.0)
    ]);
  }

  Widget _textField(BuildContext context, TextEditingController controller,
      final String key, final String? symbol) {
    return TextField(
        key: ValueKey(key),
        controller: controller,
        maxLength: widget.maxInputLength,
        autofocus: false,
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          if (value.isNotEmpty) {
            final numeric = value.getOnlyNumberFromString();
            if (key == "sender") {
              _receiverController.text =
                  (numeric! / widget.receiverBySenderRatio)
                      .formatToIntlCurrency();
            } else {
              _senderController.text = (numeric! * widget.receiverBySenderRatio)
                  .formatToIntlCurrency();
            }
          } else {
            _senderController.text = _receiverController.text = "";
          }
          widget.onSenderValueChange?.call(_senderController.text);
          widget.onReceiverValueChange?.call(_receiverController.text);
        },
        inputFormatters: [
          TextInputFormatter.withFunction((oldValue, newValue) {
            final RegExp regExp = RegExp(r'^[0-9,\\.]*$');
            if (regExp.hasMatch(newValue.text)) {
              if (newValue.text.isEmpty) {
                return newValue;
              }
              final num? parsedValue = newValue.text.getOnlyNumberFromString();
              if (parsedValue == null ||
                  (key == "sender" && parsedValue > widget.maxSenderLimit)) {
                return oldValue;
              }
              final String formattedValue =
                  parsedValue.formatToIntlCurrency();
              return newValue.copyWith(
                  text: formattedValue,
                  selection:
                      TextSelection.collapsed(offset: formattedValue.length));
            }
            return oldValue;
          })
        ],
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
            prefixText: symbol,
            hintText: "0",
            hintStyle:
                ZincTextStyle.bigExtraBold(color: GreyscaleText().disabled),
            prefixStyle:
                ZincTextStyle.bigExtraBold(color: GreyscaleText().title),
            counterText: "",
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none),
        keyboardType: TextInputType.number,
        cursorColor: PrimaryBorder().darker,
        cursorWidth: 3.0,
        style: ZincTextStyle.bigExtraBold(color: GreyscaleText().title));
  }

  Widget _currencyAction(
      Function? action, String? currencyFlag, String currencyCode) {
    return InkWell(
      onTap: () {
        action?.call();
      },
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
            border: Border.all(color: GreyscaleBorder().subtle),
            borderRadius: BorderRadius.circular(AppDimens.radius20),
            color: action != null
                ? ZincColors.neutralWhite
                : GreyscaleSurface().subtle),
        child: Row(
          children: [
            if (!currencyFlag.isEmptyOrNull())
              ZincImage.networkAsset(imageUrl: currencyFlag!, imageWidth: 24.0, isCircle: false),
            const SizedBox(width: 4.0),
            Text(currencyCode, style: ZincTextStyle.smallBold()),
            if (action != null)
              const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black)
          ],
        ),
      ),
    );
  }
}
