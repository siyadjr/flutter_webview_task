import 'package:flutter/material.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/core/theme/app_colours.dart';
import 'package:get/get.dart';

class LoginNextButton extends StatelessWidget {
  const LoginNextButton({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            controller.sendOtp(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            // Prevent the button from changing appearance when disabled
            disabledBackgroundColor: Colors.black,
          ),
          // Wrap with Obx to listen to changes in isLoading
          child: Obx(() => controller.isLoading.value
              ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColours().titleColour),
                  ),
                )
              : Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColours().titleColour,
                  ),
                )),
        ));
  }
}
