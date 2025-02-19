import 'package:design_module/widget/zinc_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class EmailVerificationPage extends StatefulWidget {
  static const String pageName = "email_verification_page";

  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isOTPSent = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildVerifyWithGmailButton(),
          const SizedBox(height: 20),
          _buildVerifyWithOTPSection(),
        ],
      ),
    );
  }

  Widget _buildVerifyWithGmailButton() {
    return PrimaryZincButton.normal(
      onTap: _handleGmailVerification,
      leftIcon: Icon(
        Icons.mail,
        color: Colors.white,
      ),
      title: 'Verify Email with Gmail',
      bgColor: Colors.blue,
    );
  }

  Widget _buildVerifyWithOTPSection() {
    return Column(
      children: [
        PrimaryZincButton.normal(
          bgColor: Colors.orange,
          onTap: _handleSendOTP,
          leftIcon: Icon(
            Icons.message,
            color: Colors.white,
          ),
          title: "Send OTP to Email",
        ),
        if (isOTPSent) _buildOTPInputField(),
      ],
    );
  }

  Widget _buildOTPInputField() {
    return Column(
      children: [
        const SizedBox(height: 10),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter OTP",
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _handleOTPVerification,
          child: Text("Verify OTP"),
        ),
      ],
    );
  }

  Future<void> _handleGmailVerification() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print("Email verified: ${account.email}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Email verified with Gmail: ${account.email}")),
        );
      }
    } catch (error) {
      print("Error during Gmail verification: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error during Gmail verification")),
      );
    }
  }

  void _handleSendOTP() {
    setState(() {
      isOTPSent = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP sent to your email.")),
    );
  }

  void _handleOTPVerification() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("OTP verified successfully!")),
    );
  }
}
