import 'package:common_module/base/base_data_source.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:network_module/data/responses/responses.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/lob/airwallex/constants/constants.dart';

abstract class AirWallexDataSource extends BaseDataSource {
  @override
  Future<ZincAPIResponse<T>> makeRequest<T extends BaseResponse>(
      ZincAPIRequest<T> request) {
    final headers = ({
      "connected-account-id": Constants.CONNECTED_ACCOUNT_ID,
      "account-id": Constants.CONNECTED_ACCOUNT_ID,
      "token": ""
    });
    return super.makeRequest(ZincAPIRequest.copyFrom(
      request,
      baseUrl: ApplicationBloc.appConfig.baseUrl,
      headers: headers,
    ));
  }
}

/*clears json having null or empty fields*/

