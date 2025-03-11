import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/model/country_model.dart';
import 'package:get/get.dart';


class ScreenLogin extends StatelessWidget {
  ScreenLogin({super.key});
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[700],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Enter your phone number to continue',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton<Country>(
                              value: controller
                                  .selectedCountry.value, // Use .value here
                              icon: const Icon(Icons.arrow_drop_down,
                                  color: Colors.black),
                              elevation: 16,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 16),
                              onChanged: (Country? newValue) {
                                if (newValue != null) {
                                  controller.selectedCountry.value = newValue;
                                }
                              },
                              items: controller.countries
                                  .map<DropdownMenuItem<Country>>(
                                (Country country) {
                                  return DropdownMenuItem<Country>(
                                    value: country,
                                    child: Row(
                                      children: [
                                        Text(country.flag,
                                            style:
                                                const TextStyle(fontSize: 20)),
                                        const SizedBox(width: 8),
                                        Text(country.dialCode),
                                      ],
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          ),
                        ),
                        const VerticalDivider(
                            color: Colors.grey, thickness: 1, width: 32),
                        Expanded(
                          child: TextField(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => controller.sendOtp(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


