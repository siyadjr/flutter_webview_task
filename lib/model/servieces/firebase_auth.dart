import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task/model/country_model.dart';
import 'package:flutter_task/view/authentication/otp_page.dart';

class FirebaseAuthService {
  Future<void> sendOtp(
      BuildContext context, String phoneNumber, Country country) async {
    if (phoneNumber.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid 10-digit phone number'),
            backgroundColor: Colors.red),
      );
      return;
    }
    // _showOtpSheet(context);

    String fullPhoneNumber = '${country.dialCode}${phoneNumber}';
    log('Sending OTP to: $fullPhoneNumber');

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.message}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Verification failed: ${e.message ?? 'Unknown error'}'),
              backgroundColor: Colors.red),
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        log('Code sent: $verificationId');

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => OtpVerificationPage(
                    // selectedCountry: country,
                    phoneNumber: phoneNumber,
                    verificationId: verificationId)));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Auto retrieval timeout: $verificationId');
      },
    );
  }
}
