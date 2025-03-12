import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/core/theme/app_colours.dart';
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      6, (index) => _buildOtpField(index, controller)),
                ),
                const SizedBox(height: 32),
                Obx(() => SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: controller.isVerifying.value
                            ? null
                            : controller.verifyOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          disabledBackgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: controller.isVerifying.value
                            ? const CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 3)
                            : const Text("Verify & Continue",
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                      ),
                    )),
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

  Widget _buildOtpField(int index, OtpController controller) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
            color: controller.focusNodes[index].hasFocus
                ? Colors.black
                : Colors.transparent,
            width: 1.5),
      ),
      child: TextField(
        controller: controller.otpControllers[index],
        focusNode: controller.focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
            counterText: '',
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            controller.focusNodes[index + 1].requestFocus();
          }
          if (index == 5 && value.isNotEmpty) {
            controller.verifyOtp();
          }
        },
      ),
    );
  }
}
