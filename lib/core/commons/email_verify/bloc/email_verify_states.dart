abstract class EmailVerificationState {
  List<Object> get props => [];
}

class EmailVerificationInitial extends EmailVerificationState {}

class EmailVerificationLoading extends EmailVerificationState {}

class GmailVerificationSuccess extends EmailVerificationState {
  final String email;

  GmailVerificationSuccess(this.email);

  @override
  List<Object> get props => [email];
}

class OTPVerificationSuccess extends EmailVerificationState {
  final String email;

  OTPVerificationSuccess(this.email);

  @override
  List<Object> get props => [email];
}

class EmailVerificationError extends EmailVerificationState {
  final String message;

  EmailVerificationError(this.message);

  @override
  List<Object> get props => [message];
}

class EmailVerifyState extends EmailVerificationState {}

class OTPSentState extends EmailVerificationState {
  final int countdown; // Add this property to hold the timer value

  OTPSentState({required this.countdown});

  @override
  List<Object> get props => [countdown];
}

class ResendOTPEnabledState extends EmailVerificationState {}
