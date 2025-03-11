import 'package:flutter/material.dart';
import 'package:flutter_task/model/country_model.dart';
import 'package:flutter_task/model/servieces/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
List<Country> countries = [
    Country(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
    Country(name: 'United States', code: 'US', dialCode: '+1', flag: '🇺🇸'),
    Country(name: 'United Kingdom', code: 'UK', dialCode: '+44', flag: '🇬🇧'),
  ];
  late var selectedCountry = countries.first.obs;
  TextEditingController phoneController = TextEditingController();


  void sendOtp(BuildContext context) {
    FirebaseAuthService()
        .sendOtp(context, phoneController.text, selectedCountry.value);
  }
}
