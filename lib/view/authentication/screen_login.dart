import 'package:flutter/material.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/core/theme/app_colours.dart';
import 'package:flutter_task/view/authentication/widgets/login_next_button.dart';
import 'package:flutter_task/view/authentication/widgets/login_text_field.dart';
import 'package:get/get.dart';

class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours().mainColour,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColours().titleColour,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Enter your phone number to continue',
                  style:
                      TextStyle(fontSize: 16, color: AppColours().titleColour),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: AppColours().titleColour,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColours().buttonBackground,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: LoginTextField(controller: controller),
                ),
                const SizedBox(height: 30),
                LoginNextButton(controller: controller),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
