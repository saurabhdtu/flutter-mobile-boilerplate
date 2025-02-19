import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:sprintf/sprintf.dart';
import 'package:zinc/lob/airwallex/constants/api_endpoints.dart';
import 'package:zinc/lob/airwallex/domain/airwallex_data_source.dart';
import 'package:zinc/lob/airwallex/domain/transaction/transaction_details_models.dart';
import 'package:zinc/lob/airwallex/domain/transaction/transaction_models.dart';

class TransactionDataSource extends AirWallexDataSource {
  TransactionDataSource._();

  static TransactionDataSource? _instance;

  static get getInstance => _instance ??= TransactionDataSource._();

  Future<CardTransactionResponse> getTransactionListData(String cardId) async {
    ZincAPIResponse<CardTransactionResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(AWApiEndpoints.getTransaction, [cardId]),
            mapper: CardTransactionResponse.fromJson));
    return Future.value(
        response.body ?? (CardTransactionResponse.error(response.error)));
  }

  Future<TransactionDetailsResponse> getTransactionData(String txnID) async {
    ZincAPIResponse<TransactionDetailsResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(AWApiEndpoints.getTransactionDetails, [txnID]),
            mapper: TransactionDetailsResponse.fromJson));
    return Future.value(
        response.body ?? (TransactionDetailsResponse.error(response.error)));
  }
}
