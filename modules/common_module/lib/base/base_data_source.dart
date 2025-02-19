import 'package:network_module/data/network/api/zinc_request_response.dart';
import 'package:network_module/data/network/dio_api_client.dart';
import 'package:network_module/data/responses/responses.dart';

abstract class BaseDataSource {
  DioAPIClient get _dioClient => DioAPIClient.instance;

  Future<ZincAPIResponse<T>>  makeRequest<T extends BaseResponse>(
      ZincAPIRequest<T> request) {
    return _dioClient.makeRequest(request);
  }
}
