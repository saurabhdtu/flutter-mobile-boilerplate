import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:sprintf/sprintf.dart';
import 'package:zinc/lob/remittance/constants/api_endpoints.dart';
import 'package:zinc/lob/remittance/domain/remittance_data_source.dart';
import 'package:zinc/lob/remittance/domain/remitter/remitter_model.dart';

class RemitterDataSource extends RemittanceDataSource {
  RemitterDataSource._();

  static RemitterDataSource? _instance;

  static get getInstance => _instance ??= RemitterDataSource._();

  Future<RemitterListResponse> getListOfRemitter() async {
    ZincAPIResponse<RemitterListResponse> response =
        await makeRequest(ZincAPIRequest(
            requestType: RequestType.get,
            url: ApiEndpoints.getRemitters,
            mapper: RemitterListResponse.fromJson));
    return Future.value(
        response.body ?? (RemitterListResponse.error(response.error)));
  }

  Future<RemitterResponse> getRemitterDetail(String remitterId) async {
    ZincAPIResponse<RemitterResponse> response = await makeRequest(
        ZincAPIRequest(
            requestType: RequestType.get,
            url: sprintf(ApiEndpoints.getRemitterById, [remitterId]),
            mapper: RemitterResponse.fromJson));
    return Future.value(
        response.body ?? (RemitterResponse.error(response.error)));
  }
}
