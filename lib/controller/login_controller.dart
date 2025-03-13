import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_task/model/models/country_model.dart';
import 'package:flutter_task/model/servieces/firebase_auth.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  List<Country> countries = [
    Country(name: 'Afghanistan', code: 'AF', dialCode: '+93', flag: '🇦🇫'),
    Country(name: 'Albania', code: 'AL', dialCode: '+355', flag: '🇦🇱'),
    Country(name: 'Algeria', code: 'DZ', dialCode: '+213', flag: '🇩🇿'),
    Country(name: 'Andorra', code: 'AD', dialCode: '+376', flag: '🇦🇩'),
    Country(name: 'Angola', code: 'AO', dialCode: '+244', flag: '🇦🇴'),
    Country(name: 'Argentina', code: 'AR', dialCode: '+54', flag: '🇦🇷'),
    Country(name: 'Armenia', code: 'AM', dialCode: '+374', flag: '🇦🇲'),
    Country(name: 'Australia', code: 'AU', dialCode: '+61', flag: '🇦🇺'),
    Country(name: 'Austria', code: 'AT', dialCode: '+43', flag: '🇦🇹'),
    Country(name: 'Azerbaijan', code: 'AZ', dialCode: '+994', flag: '🇦🇿'),
    Country(name: 'Bahamas', code: 'BS', dialCode: '+1-242', flag: '🇧🇸'),
    Country(name: 'Bahrain', code: 'BH', dialCode: '+973', flag: '🇧🇭'),
    Country(name: 'Bangladesh', code: 'BD', dialCode: '+880', flag: '🇧🇩'),
    Country(name: 'Belarus', code: 'BY', dialCode: '+375', flag: '🇧🇾'),
    Country(name: 'Belgium', code: 'BE', dialCode: '+32', flag: '🇧🇪'),
    Country(name: 'Belize', code: 'BZ', dialCode: '+501', flag: '🇧🇿'),
    Country(name: 'Bhutan', code: 'BT', dialCode: '+975', flag: '🇧🇹'),
    Country(name: 'Bolivia', code: 'BO', dialCode: '+591', flag: '🇧🇴'),
    Country(
        name: 'Bosnia and Herzegovina',
        code: 'BA',
        dialCode: '+387',
        flag: '🇧🇦'),
    Country(name: 'Botswana', code: 'BW', dialCode: '+267', flag: '🇧🇼'),
    Country(name: 'Brazil', code: 'BR', dialCode: '+55', flag: '🇧🇷'),
    Country(name: 'Brunei', code: 'BN', dialCode: '+673', flag: '🇧🇳'),
    Country(name: 'Bulgaria', code: 'BG', dialCode: '+359', flag: '🇧🇬'),
    Country(name: 'Burkina Faso', code: 'BF', dialCode: '+226', flag: '🇧🇫'),
    Country(name: 'Burundi', code: 'BI', dialCode: '+257', flag: '🇧🇮'),
    Country(name: 'Cambodia', code: 'KH', dialCode: '+855', flag: '🇰🇭'),
    Country(name: 'Cameroon', code: 'CM', dialCode: '+237', flag: '🇨🇲'),
    Country(name: 'Canada', code: 'CA', dialCode: '+1', flag: '🇨🇦'),
    Country(name: 'Chile', code: 'CL', dialCode: '+56', flag: '🇨🇱'),
    Country(name: 'China', code: 'CN', dialCode: '+86', flag: '🇨🇳'),
    Country(name: 'Colombia', code: 'CO', dialCode: '+57', flag: '🇨🇴'),
    Country(name: 'Costa Rica', code: 'CR', dialCode: '+506', flag: '🇨🇷'),
    Country(name: 'Croatia', code: 'HR', dialCode: '+385', flag: '🇭🇷'),
    Country(name: 'Cuba', code: 'CU', dialCode: '+53', flag: '🇨🇺'),
    Country(name: 'Cyprus', code: 'CY', dialCode: '+357', flag: '🇨🇾'),
    Country(name: 'Czech Republic', code: 'CZ', dialCode: '+420', flag: '🇨🇿'),
    Country(name: 'Denmark', code: 'DK', dialCode: '+45', flag: '🇩🇰'),
    Country(name: 'Ecuador', code: 'EC', dialCode: '+593', flag: '🇪🇨'),
    Country(name: 'Egypt', code: 'EG', dialCode: '+20', flag: '🇪🇬'),
    Country(name: 'Finland', code: 'FI', dialCode: '+358', flag: '🇫🇮'),
    Country(name: 'France', code: 'FR', dialCode: '+33', flag: '🇫🇷'),
    Country(name: 'Germany', code: 'DE', dialCode: '+49', flag: '🇩🇪'),
    Country(name: 'Greece', code: 'GR', dialCode: '+30', flag: '🇬🇷'),
    Country(name: 'Hong Kong', code: 'HK', dialCode: '+852', flag: '🇭🇰'),
    Country(name: 'Hungary', code: 'HU', dialCode: '+36', flag: '🇭🇺'),
    Country(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
    Country(name: 'Indonesia', code: 'ID', dialCode: '+62', flag: '🇮🇩'),
    Country(name: 'Iran', code: 'IR', dialCode: '+98', flag: '🇮🇷'),
    Country(name: 'Iraq', code: 'IQ', dialCode: '+964', flag: '🇮🇶'),
    Country(name: 'Ireland', code: 'IE', dialCode: '+353', flag: '🇮🇪'),
    Country(name: 'Italy', code: 'IT', dialCode: '+39', flag: '🇮🇹'),
    Country(name: 'Japan', code: 'JP', dialCode: '+81', flag: '🇯🇵'),
    Country(name: 'Kenya', code: 'KE', dialCode: '+254', flag: '🇰🇪'),
    Country(name: 'Malaysia', code: 'MY', dialCode: '+60', flag: '🇲🇾'),
    Country(name: 'Mexico', code: 'MX', dialCode: '+52', flag: '🇲🇽'),
    Country(name: 'Netherlands', code: 'NL', dialCode: '+31', flag: '🇳🇱'),
    Country(name: 'New Zealand', code: 'NZ', dialCode: '+64', flag: '🇳🇿'),
    Country(name: 'Nigeria', code: 'NG', dialCode: '+234', flag: '🇳🇬'),
    Country(name: 'Norway', code: 'NO', dialCode: '+47', flag: '🇳🇴'),
    Country(name: 'Pakistan', code: 'PK', dialCode: '+92', flag: '🇵🇰'),
    Country(name: 'Philippines', code: 'PH', dialCode: '+63', flag: '🇵🇭'),
    Country(name: 'Russia', code: 'RU', dialCode: '+7', flag: '🇷🇺'),
    Country(name: 'Saudi Arabia', code: 'SA', dialCode: '+966', flag: '🇸🇦'),
    Country(name: 'South Africa', code: 'ZA', dialCode: '+27', flag: '🇿🇦'),
    Country(name: 'South Korea', code: 'KR', dialCode: '+82', flag: '🇰🇷'),
    Country(name: 'Spain', code: 'ES', dialCode: '+34', flag: '🇪🇸'),
    Country(name: 'Sweden', code: 'SE', dialCode: '+46', flag: '🇸🇪'),
    Country(name: 'Switzerland', code: 'CH', dialCode: '+41', flag: '🇨🇭'),
    Country(name: 'Turkey', code: 'TR', dialCode: '+90', flag: '🇹🇷'),
    Country(name: 'United Kingdom', code: 'GB', dialCode: '+44', flag: '🇬🇧'),
    Country(name: 'United States', code: 'US', dialCode: '+1', flag: '🇺🇸'),
  ];

  late var selectedCountry = countries[45].obs;
  TextEditingController phoneController = TextEditingController();

  // Make isLoading reactive with .obs
  RxBool isLoading = false.obs;

  Future<void> sendOtp(BuildContext context) async {
    try {
      // Use value to update the observable
      isLoading.value = true;

      await FirebaseAuthService()
          .sendOtp(context, phoneController.text, selectedCountry.value);

      // Update the value after completion
      // isLoading.value = false;
      Future.delayed(const Duration(seconds: 3), () {
        isLoading.value = false;
      });
    } catch (e) {
      // Handle error and reset loading state
      print('Error sending OTP: $e');
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    log('called login controller');
    phoneController.dispose(); // Dispose the controller
    isLoading.value = false; // Reset loading state
    super.onClose();
  }
}
