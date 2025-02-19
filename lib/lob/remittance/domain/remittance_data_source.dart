import 'package:common_module/base/base_data_source.dart';
import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:network_module/data/responses/responses.dart';
import 'package:utility_module/app_prefs.dart';
import 'package:zinc/core/application/application_bloc.dart';
import 'package:zinc/constants/api_endpoints.dart';

abstract class RemittanceDataSource extends BaseDataSource {
  @override
  Future<ZincAPIResponse<T>> makeRequest<T extends BaseResponse>(
      ZincAPIRequest<T> request) async {
    String token =
        await AppPreferences.getInstance.getString(PrefKeys.authToken);
    final headers = ({
      "Authorization": "Bearer $token",
    });

    return super.makeRequest(ZincAPIRequest.copyFrom(
      request,
      baseUrl: ApplicationBloc.appConfig.baseUrl + APIEndPoints.apiVersion,
      headers: headers,
    ));
  }
}
