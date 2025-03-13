
import 'package:flutter/material.dart';
import 'package:flutter_task/controller/login_controller.dart';
import 'package:flutter_task/model/models/country_model.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton({
    super.key,
    required this.controller,
  });

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
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
    );
  }
}


