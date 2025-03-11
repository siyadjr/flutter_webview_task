import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/model/country_model.dart';
import 'package:flutter_task/view/home/screen_home.dart';

class OtpVerificationPage extends StatefulWidget {
  final Country selectedCountry;
  final String phoneNumber;
  final String verificationId;

  const OtpVerificationPage({
    super.key,
    required this.selectedCountry,
    required this.phoneNumber,
    required this.verificationId,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());
  bool isVerifying = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(focusNodes[0]);
    });
  }

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify OTP'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Verify Your Number',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Enter the verification code sent to\n${widget.selectedCountry.dialCode} ${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) => _buildOtpField(index)),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isVerifying ? null : _verifyOtp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    disabledBackgroundColor: Colors.grey,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isVerifying
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        )
                      : const Text(
                          'Verify & Continue',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              TextButton(
                onPressed: () {
                  // Add resend OTP logic here
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('OTP resent successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text(
                  "Didn't receive code? Resend",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
  return RawKeyboardListener(
    focusNode: FocusNode(), // Required for RawKeyboardListener
    onKey: (RawKeyEvent event) {
      if (event is RawKeyDownEvent &&
          event.logicalKey == LogicalKeyboardKey.backspace &&
          otpControllers[index].text.isEmpty &&
          index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    },
    child: Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: focusNodes[index].hasFocus ? Colors.black : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          }
          if (index == 5 && value.isNotEmpty) {
            String otp = otpControllers.map((c) => c.text).join();
            if (otp.length == 6) {
              _verifyOtp();
            }
          }
        },
      ),
    ),
  );
}

  Future<void> _verifyOtp() async {
    String otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid 6-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isVerifying = true;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      _navigateToHome();
    } catch (e) {
      log('OTP Verification Error: $e');
      setState(() {
        isVerifying = false;
      });

      String errorMessage = 'Invalid OTP. Please try again.';
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-verification-code') {
          errorMessage = 'The verification code entered is invalid.';
        } else if (e.code == 'session-expired') {
          errorMessage =
              'The verification session has expired. Please request a new code.';
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const ScreenHome()),
    );
  }
}
