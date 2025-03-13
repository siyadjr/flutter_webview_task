import 'package:flutter/material.dart';
import 'package:flutter_task/controller/otp_controller.dart';
import 'package:flutter_task/view/authentication/widgets/otp_text_field.dart';

class OtpVerificationButtonContainer extends StatelessWidget {
  const OtpVerificationButtonContainer({
    super.key,
    required this.controller,
  });

  final OtpController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
          6, (index) => OtpTextField(index: index, controller: controller)),
    );
  }
}

