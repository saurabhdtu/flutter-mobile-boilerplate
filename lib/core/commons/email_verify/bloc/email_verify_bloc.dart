import 'dart:async';
import 'package:common_module/base/base_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zinc/core/commons/email_verify/bloc/email_verify_states.dart';
import 'package:zinc/core/commons/email_verify/repository/email_verify_repo.dart';
import 'package:zinc/domain/user_auth/user_auth_data_source.dart';

class EmailVerificationBloc extends BaseCubit<EmailVerificationState> {
  factory EmailVerificationBloc.create() {
    return EmailVerificationBloc._(
        VerifyEmailRepositoryImplemantation(UserAuthDataSource.getInstance));
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Timer? _timer;
  int _start = 30;
  String refId = '';
  final VerifyEmailRepository _verifyEmailRepository;

  EmailVerificationBloc._(this._verifyEmailRepository)
      : super(EmailVerificationInitial());

  Future<void> verifyWithGmail() async {
    emitState(EmailVerificationLoading());
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        emitState(GmailVerificationSuccess(account.email));
      } else {
        emitState(EmailVerificationError('Gmail verification canceled.'));
      }
    } catch (error) {
      handleError(error);
      emitState(EmailVerificationError('Error during Gmail verification'));
    }
  }

  void typeEmailToSendOtp() {
    emitState(EmailVerifyState());
  }

  void sendOTPToEmail(String email) async {
    try {
      refId = await _verifyEmailRepository.sendOtp(email);
      _startTimer();
    } catch (error) {
      handleError(error);
      emitState(EmailVerificationError('Error while sending OTP.'));
    }
  }

  void verifyOTP(String otp, String email) async {
    try {
      await _verifyEmailRepository.verifyOtp(email, otp, refId);
      emitState(OTPVerificationSuccess(email));
    } catch (error) {
      handleError(error);
      emitState(EmailVerificationError('Invalid OTP.'));
    }
  }

  void _startTimer() {
    _start = 30;
    emitState(OTPSentState(countdown: _start));
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start == 0) {
        timer.cancel();
        emitState(ResendOTPEnabledState());
      } else {
        _start--;
        emitState(OTPSentState(countdown: _start));
      }
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
