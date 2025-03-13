import 'package:flutter/material.dart';
import 'package:flutter_task/controller/otp_controller.dart';
import 'package:flutter_task/core/theme/app_colours.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class OtpVerificationButton extends StatelessWidget {
  const OtpVerificationButton({
    super.key,
    required this.controller,
  });

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 55,
          child: ElevatedButton(
            onPressed: controller.isVerifying.value
                ? null
                : controller.verifyOtp,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColours().buttonBackground,
              disabledBackgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: controller.isVerifying.value
                ?  CircularProgressIndicator(
                    color: AppColours().titleColour, strokeWidth: 3)
                : const Text("Verify & Continue",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
          ),
        ));
  }
}
