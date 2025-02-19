import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:sprintf/sprintf.dart';
import 'package:zinc/lob/remittance/constants/api_endpoints.dart';
import 'package:zinc/lob/remittance/domain/remittance_data_source.dart';
import 'package:zinc/lob/remittance/domain/transaction/transaction_model.dart';

class TransactionDataSource extends RemittanceDataSource {
  TransactionDataSource._();

  static TransactionDataSource? _instance;

  static get getInstance => _instance ??= TransactionDataSource._();

  Future<InitTransactionResponse> initiateTransaction(
      String? studentId,
      String remitterId,
      String beneficiaryId,
      String beneficiaryBankId,
      num amount,
      String receiverCurrencyCode,
      String senderCurrencyCode,
      String remitterBankId) async {
    var params = {
      "student_id": studentId,
      "sender_id": remitterId,
      "beneficiary_id": beneficiaryId,
      "remitter_bank_id": remitterBankId,
      "receiver_bank_id": beneficiaryBankId,
      "amount": amount,
      "input_currency": receiverCurrencyCode,
      "from_currency": senderCurrencyCode,
      "to_currency": receiverCurrencyCode
    };
    ZincAPIResponse<InitTransactionResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.post,
            body: params,
            url: ApiEndpoints.initTransaction,
            mapper: InitTransactionResponse.fromJson));

    return Future.value(
        response.body ?? (InitTransactionResponse.error(response.error)));
  }

  Future<SOFResponse> setSourceOfFunds(
      String transactionId, SourceOfFunds sourceOfFund) async {
    var params = {
      "txn_id": transactionId,
      "to_loan": sourceOfFund == SourceOfFunds.loan,
      "to_self": sourceOfFund == SourceOfFunds.self,
    };
    ZincAPIResponse<SOFResponse> response = await makeRequest(ZincAPIRequest(
        requestType: RequestType.post,
        url: ApiEndpoints.sofTransaction,
        body: params,
        mapper: SOFResponse.fromJson));
    return Future.value(response.body ?? (SOFResponse.error(response.error)));
  }

  Future<TransactionListResponse> getInitiatedTransactions() async {
    ZincAPIResponse<TransactionListResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: ApiEndpoints.getInitiatedTransactions,
            mapper: TransactionListResponse.fromJson));
    return Future.value(
        response.body ?? (TransactionListResponse.error(response.error)));
  }

  Future<TransactionListResponse> getCompletedTransactions() async {
    ZincAPIResponse<TransactionListResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: ApiEndpoints.getCompletedTransactions,
            mapper: TransactionListResponse.fromJson));
    return Future.value(
        response.body ?? (TransactionListResponse.error(response.error)));
  }

  Future<TransactionListResponse> getAllTransactions(
      {String? remitterId, String? beneficiaryId}) async {
    final Map<String, dynamic> params = {};
    if (remitterId != null) params.addAll({"remitter_id": remitterId});
    if (beneficiaryId != null) params.addAll({"beneficiary_id": beneficiaryId});
    ZincAPIResponse<TransactionListResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: ApiEndpoints.getTransactionHistory,
            queryParams: params,
            mapper: TransactionListResponse.fromJson));
    return Future.value(
        response.body ?? (TransactionListResponse.error(response.error)));
  }

  Future<TransactionResponse> getTransactionDetails(String txnId) async {
    ZincAPIResponse<TransactionResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: ApiEndpoints.getTransactionDetails,
            queryParams: {"transaction_id": txnId},
            mapper: TransactionResponse.fromJson));
    return Future.value(
        response.body ?? (TransactionResponse.error(response.error)));
  }

  Future<PaymentTimelineResponse> getPaymentTimelineData(
      String? transactionId) async {
    ZincAPIResponse<PaymentTimelineResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(ApiEndpoints.getPaymentTimeline, [transactionId]),
            mapper: PaymentTimelineResponse.fromJson));
    return Future.value(
        response.body ?? (PaymentTimelineResponse.error(response.error)));
  }
}
