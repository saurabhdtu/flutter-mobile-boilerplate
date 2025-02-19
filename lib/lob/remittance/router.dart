import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class RemittanceRouter {
  static Map? _getDecodedArgs(String? data) {
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  static final List<GoRoute> routes = [];
}

abstract class RemittanceRoutes {
  //OLD SCREEN
  // static const String collectAdhaar = "collectAdhaar";
  //NEW SCREEN
  static const String addRemitterScreen = "addRemitterScreen";
  static const String priceCampareView = "priceCampareView";

  //NEW SCREEN
  static const String sendMoneyLandingScreen = "sendMoneyLandingScreen";

  //NEW SCREEN
  static const String remitterListScreen = "remitterListScreen";

  // NEW SCREEN
  static const String beneficiaryListScreen = "beneficiaryListScreen";

  //NEW SCREEN @CS
  static const String beneficiaryReasonListScreen =
      "beneficiaryReasonListScreen";

  //NEW Screen @CS
  static const String beneficiaryReasonStudentListScreen =
      "beneficiaryReasonStudentListView";

  //New Screen @CS
  static const String beneficiaryVerificationScreen =
      "beneficiaryVerificationScreen";

  //New Screen @CS
  static const String beneficiaryPassportVerificationScreen =
      "beneficiaryPassportVerificationScreen";

  //NEW Screen
  static const String addBeneficiaryUniversityScreen =
      "addBeneficiaryUniversityScreen";

  //NEW Screen
  static const String addBeneficiaryScreen = "addBeneficiaryScreen";

  //Old Screen
  static const String beneficiaryVerifiedScreen = "beneficiaryVerifiedScreen";

  //New Screen @CS
  static const String addBeneficiarySuccessfulScreen =
      "addBeneficiarySuccessfulScreen";

  //Old Screen
  static const String proceedToPaymentView = "proceedToPaymentView";

  //New Screen @CS
  static const String transactionPaymentInfoScreen =
      "transactionPaymentInfoScreen";

  //Old Screen
  static const String paymentSuccessTimelineView = "paymentSuccessTimelineView";

  //New Screen @CS
  static const String transactionStatusTimelineScreen =
      "transactionStatusTimelineScreen";

  //New Screen @CS
  static const String transactionLoanLetterUploadScreen =
      "transactionLoanLetterUploadScreen";

  //New Screen @CS
  static const String transactionMarriageLetterUploadScreen =
      "transactionMarriageLetterUploadScreen";

  //New Screen @CS
  static const String transactionRelationshipSelectionScreen =
      "transactionRelationshipSelectionScreen";

  //NEW Screen
  static const String nmiDocumentUploadScreen = "nmiDocumentUploadScreen";

  static const String paymentSuccessViewScreen = "paymentSuccessViewScreen";
  static const String nmiDocumentListUploadView = "nmiDocumentListUploadView";
  static const String nmiVerifiedScreen = "nmiVerifiedScreen";
  static const String passportUploadView = "passportUploadView";

  static const String senders = "senders";
  static const String senderDetails = "senderDetails";
  static const String receivers = "receivers";
  static const String receiverDetails = "receiverDetails";
  static const String transactions = "transactions";
  static const String transactionDetail = "transactionDetail";
}
