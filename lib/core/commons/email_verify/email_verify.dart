import 'package:common_module/base/base_screen.dart';
import 'package:design_module/old_design/common_ui/toast.dart';
import 'package:design_module/old_design/widget/custom_floating_text_field.dart';
import 'package:design_module/resources/zinc_colors.dart';
import 'package:design_module/widget/zinc_image.dart';
import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:utility_module/validators.dart';
import 'package:zinc/constants/strings.dart';
import 'package:zinc/core/commons/email_verify/bloc/email_verify_bloc.dart';
import 'package:zinc/core/commons/email_verify/bloc/email_verify_states.dart';
import 'package:zinc/domain/bff/ui_configuration/onboarding_config_models.dart';

class EmailVerificationScreen extends StatefulWidget {
  static const String pageName = "email_verification_screen";
  final Function(String)? onEmailVerified;
  final PageConfig? pageConfig;
  final bool launchForResult;

  EmailVerificationScreen(
      {this.pageConfig, this.onEmailVerified, this.launchForResult = false})
      : super(key: ValueKey(pageName));

  @override
  State<StatefulWidget> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends BaseScreenState<EmailVerificationScreen> {
  late EmailVerificationBloc _emailVerificationBloc;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  int _countdown = 0; // Holds the countdown value

  @override
  void initState() {
    super.initState();
    _emailVerificationBloc = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BlocConsumer<EmailVerificationBloc, EmailVerificationState>(
        listener: (context, state) {
          if (state is GmailVerificationSuccess) {
            widget.onEmailVerified?.call(state.email);
          } else if (state is OTPVerificationSuccess) {
            widget.onEmailVerified?.call(state.email);
            showZincToast(AppStrings.otpVerifiedSuccessfully);
          } else if (state is EmailVerificationError) {
            showZincToast(state.message);
          } else if (state is OTPSentState) {
            showZincToast(AppStrings.otpSentToYourEmail);
          } else if (state is ResendOTPEnabledState) {
            showZincToast(AppStrings.youCanNowResendOTP);
          }
        },
        builder: (context, state) {
          if (state is OTPSentState) {
            _countdown = state.countdown;
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if ((state is! EmailVerifyState) &&
                  (state is! OTPSentState) &&
                  (state is! ResendOTPEnabledState))
                _buildVerifyWithGmailButton(context),
              const SizedBox(height: 20),
              _buildVerifyWithOTPSection(context, state),
            ],
          );
        },
      ),
    );
  }

  Widget _buildVerifyWithGmailButton(BuildContext context) {
    return PrimaryZincButton.normal(
      onTap: () => _emailVerificationBloc.verifyWithGmail(),
      width: MediaQuery.of(context).size.width / 1.2,
      leftIcon: ZincImage.iconAsset(
        width: 35,
        height: 30,
        iconName: 'ic_gmail.svg',
      ),
      title: AppStrings.verifyWithGoogle,
      bgColor: Colors.blue,
    );
  }

  Widget _buildVerifyWithOTPSection(
      BuildContext context, EmailVerificationState state) {
    return Column(
      children: [
        if ((state is! EmailVerifyState) &&
            (state is! OTPSentState) &&
            (state is! ResendOTPEnabledState))
          PrimaryZincButton.normal(
            width: MediaQuery.of(context).size.width / 1.2,
            bgColor: Colors.orange,
            onTap: () => _emailVerificationBloc.typeEmailToSendOtp(),
            leftIcon: ZincImage.iconAsset(
              width: 35,
              height: 30,
              iconName: 'ic_otp.svg',
            ),
            title: AppStrings.verifyWithOTP,
          ),
        const SizedBox(
          height: 20,
        ),
        if (state is EmailVerifyState) _buildEmailInputField(context),
        if (state is OTPSentState || state is ResendOTPEnabledState)
          _buildOTPInputField(context, state),
      ],
    );
  }

  Widget _buildEmailInputField(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomFloatingTextField(
          labelText: AppStrings.enterEmail,
          controller: emailController,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: FieldValidators.emailValidator,
          textInputType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 15),
        PrimaryZincButton.normal(
          width: MediaQuery.of(context).size.width / 1.2,
          onTap: () {
            if (emailController.text.isNotEmpty) {
              _emailVerificationBloc.sendOTPToEmail(emailController.text);
            } else {
              showZincToast(AppStrings.pleaseEnterYourEmail);
            }
          },
          title: AppStrings.sendOTP,
        ),
      ],
    );
  }

  Widget _buildOTPInputField(
      BuildContext context, EmailVerificationState state) {
    return Column(
      children: [
        const SizedBox(height: 10),
        CustomFloatingTextField(
          labelText: AppStrings.enterOTP,
          controller: otpController,
          textInputType: TextInputType.number,
        ),
        const SizedBox(height: 15),
        PrimaryZincButton.normal(
          width: MediaQuery.of(context).size.width / 1.2,
          onTap: () {
            if (otpController.text.isNotEmpty) {
              _emailVerificationBloc.verifyOTP(
                  otpController.text, emailController.text);
            } else {
              showZincToast(AppStrings.enterOTPVerify);
            }
          },
          title: AppStrings.verifyOTP,
        ),
        const SizedBox(height: 15),
        _buildResendOTPButton(context, state),
      ],
    );
  }

  Widget _buildResendOTPButton(
      BuildContext context, EmailVerificationState state) {
    bool isButtonDisabled = state is! ResendOTPEnabledState;

    return Column(
      children: [
        PrimaryZincButton.normal(
            width: MediaQuery.of(context).size.width / 1.2,
            bgColor: isButtonDisabled ? ZincColors.grey : ZincColors.black,
            onTap: isButtonDisabled
                ? null
                : () {
                    _emailVerificationBloc.sendOTPToEmail(emailController.text);
                    otpController.clear();
                  },
            title: isButtonDisabled
                ? "${AppStrings.resendOTPIn} $_countdown s"
                : AppStrings.resendOTP),
      ],
    );
  }

  @override
  String get pageName => EmailVerificationScreen.pageName;
}
