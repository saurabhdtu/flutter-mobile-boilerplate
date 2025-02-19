import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zinc/lob/airwallex/common/models/currency_model.dart';
import 'package:zinc/lob/airwallex/common/ui/zinc_file_upload/zinc_file_upload_bloc.dart';
import 'package:zinc/lob/airwallex/domain/payout/payment_data_source.dart';
import 'package:zinc/lob/airwallex/features/testing_screen/global_test_screen.dart';

abstract class AWRoutes {
  static const String homeScreen = "homeScreen";
  static const String addCardLandingScreen = "addCardLandingScreen";
  static const String rfiScreen = "rfiScreen";
  static const String awxConnectedAccountScreen = "awxConnectedAccountScreen";
  static const String cardHomeScreen = "cardHomeScreen";
  static const String transactionDetails = "transactionDetails";
  static const String cardInfoScreen = "cardInfoScreen";
  static const String cardHistoryScreen = "cardHistoryScreen";
  static const String cardLimitScreen = "cardLimitScreen";
  static const String editNickNameCard = "editNickNameCardScreen";
  static const String setCardLimitScreen = "setCardLimitScreen";
  static const String cardsActionScreen = "cardsActionScreen";
  static const String globalTestScreen = "globalTestScreen";
  static const String beneficiaryListScreen = "awxBeneficiaryListScreen";
  static const String paymentReviewScreen = "paymentReviewScreen";
  static const String paymentSuccessScreen = "paymentSuccessScreen";
  static const String beneficiaryRegionSelectionScreen =
      "beneficiaryRegionSelectionScreen";
  static const String beneficiaryOnboardingScreen =
      "beneficiaryOnboardingScreen";

  static const String beneficiaryCreationScreen = "beneficiaryCreationScreen";
  static const String beneficiaryPaymentSelectionScreen =
      "beneficiaryPaymentSelectionScreen";
  static const String paymentAmountInputScreen = "paymentAmountInputScreen";
  static const String convertFundsActionScreen = "convertFundsActionScreen";
  static const String addFundsStaticDetailsScreen =
      "addFundsStaticDetailsScreen";
  static const String walletAmountConversionScreen =
      "walletAmountConversionScreen";
  static const String conversionReviewScreen = "conversionReviewScreen";
  static const String conversionSuccessScreen = "conversionSuccessScreen";
  static const String currencyPickerScreen = "currencyPickerScreen";
  static const String walletTransactionHistoryScreen =
      "walletTransactionHistoryScreen";
  static const String walletAccountActivityScreen =
      "walletAccountActivityScreen";
  static const String awxAccountCreationScreen = "awxAccountCreationScreen";
  static const String uploadPassportFront = "uploadPassportFront";
  static const String rfiAccountDetailFormScreen = "rfiAccountDetailFormScreen";
}

class AWRouter {
  static Map<String, dynamic>? _getDecodedArgs(String? data) {
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  static final List<GoRoute> routes = [

    GoRoute(
      path: "/${AWRoutes.globalTestScreen}",
      name: AWRoutes.globalTestScreen,
      builder: (context, state) {
        // final data = state.pathParameters["data"];
        // final args = _getDecodedArgs(data);
        return GlobalTestScreen();
      },
    )
  ];
}
