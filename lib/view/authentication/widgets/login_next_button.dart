import 'package:flutter/material.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/core/theme/app_colours.dart';

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
      child: ValueListenableBuilder<bool>(
        valueListenable: controller.isloading,
        builder: (context, isLoading, _) {
          return ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    controller.isloading.value = true;
                    // Call sendOtp without expecting a Future
                    controller.sendOtp(context);
                    // You may want to add a delayed reset of loading state
                    // since sendOtp doesn't return a Future to track completion
                    Future.delayed(const Duration(seconds: 1), () {
                      if (controller.isloading.value == true) {
                        controller.isloading.value = false;
                      }
                    });
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
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColours().titleColour),
                    ),
                  )
                : Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColours().titleColour,
                    ),
                  ),
          );
        },
      ),
    );
  }
}
