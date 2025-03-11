import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/view/authentication/widgets/country_dropdown.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class LoginTextField extends StatelessWidget {
  const LoginTextField({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          DropDownButton(controller: controller),
          const VerticalDivider(
              color: Colors.grey, thickness: 1, width: 32),
          Expanded(
            child: TextFormField(
              autovalidateMode:
                  AutovalidateMode.onUserInteraction,
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Phone Number',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 16),
              ),
              style: const TextStyle(fontSize: 16),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a phone number';
                }
                if (!GetUtils.isPhoneNumber(value)) {
                  return 'Invalid phone number';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}

