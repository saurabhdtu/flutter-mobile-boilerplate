import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:sprintf/sprintf.dart';
import 'package:zinc/app/constant.dart';
import 'package:zinc/lob/airwallex/constants/api_endpoints.dart';
import 'package:zinc/lob/airwallex/constants/constants.dart';
import 'package:zinc/lob/airwallex/domain/airwallex_data_source.dart';
import 'package:zinc/lob/airwallex/domain/wallet/transaction/wallet_transaction_model.dart';
import 'package:dio/dio.dart';
class WalletTransactionDataSource extends AirWallexDataSource {
  WalletTransactionDataSource._();

  static WalletTransactionDataSource? _instance;

  static get getInstance => _instance ??= WalletTransactionDataSource._();

  Future<TransactionHistoryResponse> getWalletTransactionHistory(String? currency, num? pageNum, CancelToken cancelToken) async {
    Map<String, dynamic> queryParams = {
      "page_num": pageNum,
      "page_size": Constants.TRANSACTION_LIST_PAGE_SIZE
    };
    if(currency != null && currency != "") {
      queryParams["currency"] = currency;
    }
    ZincAPIResponse<TransactionHistoryResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            cancelToken: cancelToken,
            queryParams:queryParams,
            url: sprintf(
                AWApiEndpoints.getWalletTransactionHistory, [Constants.CONNECTED_ACCOUNT_ID]),
            mapper: TransactionHistoryResponse.fromJson));
    return Future.value(
        response.body ?? (TransactionHistoryResponse.error(response.error)));
  }
}
