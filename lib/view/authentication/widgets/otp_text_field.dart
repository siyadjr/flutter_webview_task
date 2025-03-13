import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/controller/otp_controller.dart';

class OtpTextField extends StatelessWidget {
  const OtpTextField({
    super.key,
    required this.index,
    required this.controller,
  });

  final int index;
  final OtpController controller;

  @override
  Widget build(BuildContext context) {
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
