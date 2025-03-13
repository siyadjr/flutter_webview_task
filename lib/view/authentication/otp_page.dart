import 'package:flutter/material.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/core/theme/app_colours.dart';
import 'package:flutter_task/view/authentication/widgets/otp_verification_button.dart';
import 'package:flutter_task/view/authentication/widgets/otp_verification_button_container.dart';
import 'package:get/get.dart';
import '../../controller/otp_controller.dart';

class OtpVerificationPage extends StatelessWidget {
  final String phoneNumber;
  final String verificationId;

  const OtpVerificationPage(
      {super.key, required this.phoneNumber, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    final OtpController controller = Get.put(OtpController(
        phoneNumber: phoneNumber, verificationId: verificationId));
    final loginController = Get.find<LoginController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColours().mainColour,
      ),
      backgroundColor: AppColours().mainColour,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Text("Verify Your Number",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColours().titleColour)),
                const SizedBox(height: 16),
                Text("Enter the verification code sent to\n$phoneNumber",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16, color: AppColours().titleColour)),
                const SizedBox(height: 40),
                OtpVerificationButtonContainer(controller: controller),
                const SizedBox(height: 32),
                OtpVerificationButton(controller: controller),
                const SizedBox(height: 24),
                TextButton(
                  onPressed: () {
                    loginController.sendOtp(
                      context,
                    );
                    Get.snackbar("Success", "OTP resent successfully",
                        backgroundColor: Colors.green, colorText: Colors.white);
                  },
                  child: Text("Didn't receive code? Resend",
                      style: TextStyle(
                          color: AppColours().titleColour,
                          fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

