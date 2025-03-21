  import 'dart:developer';
  import 'package:firebase_auth/firebase_auth.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter_task/core/sharedpreferences/login_shared_preference.dart';
  import 'package:get/get.dart';
  import '../view/home/screen_home.dart';

  class OtpController extends GetxController {
    final String phoneNumber;
    final String verificationId;

    OtpController({required this.phoneNumber, required this.verificationId});

    var otpControllers = List.generate(6, (_) => TextEditingController());
    var focusNodes = List.generate(6, (_) => FocusNode());
    var isVerifying = false.obs;

    @override
    void onInit() {
      super.onInit();
      Future.delayed(const Duration(milliseconds: 500), () {
        focusNodes[0].requestFocus();
      });
    }

    @override
    @override
    void onClose() {
      log('called otp[ controler]');
      for (var controller in otpControllers) {
        controller.clear(); // Clear text before disposing
        controller.dispose();
      }
      otpControllers.clear(); // Remove references

      for (var node in focusNodes) {
        node.unfocus(); // Ensure focus is removed
        node.dispose();
      }
      focusNodes.clear(); // Remove references

      super.onClose();
    }

    void verifyOtp() async {
      String otp = otpControllers.map((c) => c.text).join();
      if (otp.length != 6) {
        Get.snackbar("Error", "Please enter a valid 6-digit OTP",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }

      isVerifying.value = true;
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: otp,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        LoginSharedPreference().loggedIn();
         Get.delete<OtpController>();Get.offAll(() => const ScreenHome());

      } catch (e) {
        log("OTP Verification Error: $e");
        isVerifying.value = false;

        String errorMessage = "Invalid OTP. Please try again.";
        if (e is FirebaseAuthException) {
          if (e.code == 'invalid-verification-code') {
            errorMessage = "The verification code entered is invalid.";
          } else if (e.code == 'session-expired') {
            errorMessage = "Session expired. Please request a new code.";
          }
        }

        Get.snackbar("Error", errorMessage,
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    }
  }
