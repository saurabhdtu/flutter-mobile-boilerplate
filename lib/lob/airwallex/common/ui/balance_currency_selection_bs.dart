import 'package:design_module/resources/dimens.dart';
import 'package:design_module/resources/zinc_style_colors.dart';
import 'package:design_module/resources/zinc_style_textstyles.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/lob/airwallex/common/models/currency_model.dart';
import 'package:zinc/lob/airwallex/constants/strings.dart';

class BalanceCurrencySelectionBottomSheet extends StatefulWidget {
  final List<CurrencyUiModel> currencyList;
  final CurrencyUiModel? selectedCurrency;
  final String? pageState;
  final Function(CurrencyUiModel?) onCurrencySelected;

  const BalanceCurrencySelectionBottomSheet(
      this.currencyList, this.onCurrencySelected, this.selectedCurrency,
      {super.key, this.pageState});

  @override
  State<StatefulWidget> createState() =>
      _BalanceCurrencySelectionBottomSheetState();
}

class _BalanceCurrencySelectionBottomSheetState
    extends State<BalanceCurrencySelectionBottomSheet> {
  CurrencyUiModel? updatedCurrency;

  _BalanceCurrencySelectionBottomSheetState();

  @override
  void initState() {
    super.initState();
    updatedCurrency = widget.selectedCurrency;
  }

  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Expanded(
            child: ListView.separated(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final currency = widget.currencyList[index];
            return InkWell(
                onTap: () {
                  /*  Analytics.getInstance.trackEvent(ButtonClickEvent(
                      HomeScreen.pageName, "currency_radio",
                      buttonType: EventButtonType.radioButton,
                      bottomSheetName: "currency",
                      pageState: pageState));*/
                  setState(() {
                    updatedCurrency = currency;
                  });
                },
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.screenHorizontalPadding),
                    child: Row(children: [
                      ZincImage.networkAsset(
                          imageUrl: currency.currencyLogoUrl,
                          imageWidth: 40.0,
                          isCircle: false),
                      const SizedBox(width: AppDimens.screenHorizontalPadding),
                      Expanded(
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            RichText(
                                text: TextSpan(
                                    style: ZincTextStyle.normalRegular(),
                                    children: [
                                  TextSpan(
                                      text: currency.currencyCode,
                                      style: ZincTextStyle.normalBold()),
                                  TextSpan(text: " ${currency.currencyName}")
                                ])),
                            if (currency.balance != null)
                              Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: Text(
                                      "${AWStrings.balance}: ${currency.currencySymbol}${currency.displayBalance}"))
                          ])),
                      Radio(
                          value: currency,
                          groupValue: updatedCurrency,
                          activeColor: PrimaryBorder().defaultC,
                          onChanged: (value) {
                            updatedCurrency = value;
                          })
                    ])));
          },
          itemCount: widget.currencyList.length,
          separatorBuilder: (BuildContext context, int index) =>
              const SizedBox(height: AppDimens.screenVerticalPadding),
        )),
        const SizedBox(height: 8.0),
        PrimaryZincButton.normal(
            title: AppStrings.proceed,
            onTap: () {
              widget.onCurrencySelected(updatedCurrency);
              context.pop();
            })
      ]);
}
