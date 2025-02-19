import 'package:common_module/base/base_repository.dart';
import 'package:zinc/domain/user_auth/user_auth_data_source.dart';

abstract class VerifyEmailRepository extends BaseRepository {
  abstract final UserAuthDataSource authDataSource;

  Future<String> sendOtp(String identifier);

  Future verifyOtp(String identifier, String otp, String refId);
}

class VerifyEmailRepositoryImplemantation extends VerifyEmailRepository {
  UserAuthDataSource _authDataSource;
  VerifyEmailRepositoryImplemantation(this._authDataSource);

  @override
  UserAuthDataSource get authDataSource => _authDataSource;
  @override
  Future<String> sendOtp(String identifier) async {
    final response = await _authDataSource.sendOtp(identifier);
    if (response.hasError) throw (response.error!);
    return Future.value(response.referenceId);
  }

  @override
  Future verifyOtp(String identifier, String otp, String refId) async {
    final response =
        await _authDataSource.verifyEmailOtp(identifier, otp, refId);
    if (response.hasError) throw (response.error!);
  }

  @override
  void reset() {}
}
