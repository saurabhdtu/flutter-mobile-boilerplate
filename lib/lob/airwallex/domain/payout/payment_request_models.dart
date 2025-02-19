import 'package:utility_module/extensions/date_time_extensions.dart';

class CreatePaymentRequest {
  final String beneficiaryId;
  final String paymentAmount;
  final String paymentCurrency;
  final String paymentMethod;
  final String feePaidBy = "PAYER";
  final String reason;
  String paymentDate = DateTime.now().formatToDate();
  final String reference;
  final String requestId;
  final String sourceCurrency;

  CreatePaymentRequest(
      {required this.beneficiaryId,
      required this.paymentAmount,
      required this.paymentCurrency,
      required this.paymentMethod,
      required this.reason,
      required this.reference,
      required this.requestId,
      required this.sourceCurrency});

  Map<String, dynamic> toJson() {
    return {
      "beneficiary_id": this.beneficiaryId,
      "payment_amount": this.paymentAmount,
      "payment_currency": this.paymentCurrency,
      "payment_method": this.paymentMethod,
      "fee_paid_by": this.feePaidBy,
      "reason": this.reason,
      "payment_date": this.paymentDate,
      "reference": this.reference,
      "request_id": this.requestId,
      "source_currency": this.sourceCurrency,
    };
  }
}
