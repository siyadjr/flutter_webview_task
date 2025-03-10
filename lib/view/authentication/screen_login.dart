import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/view/home/screen_home.dart';



class ScreenLogin extends StatefulWidget {
  const ScreenLogin({super.key});

  @override
  State<ScreenLogin> createState() => _ScreenLoginState();
}

class Country {
  final String name;
  final String code;
  final String dialCode;
  final String flag;

  Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flag,
  });
}

class _ScreenLoginState extends State<ScreenLogin> {
  List<Country> countries = [
    Country(name: 'India', code: 'IN', dialCode: '+91', flag: '🇮🇳'),
    Country(name: 'United States', code: 'US', dialCode: '+1', flag: '🇺🇸'),
    Country(name: 'United Kingdom', code: 'UK', dialCode: '+44', flag: '🇬🇧'),
  ];

  Country? _selectedCountry;
  final TextEditingController _phoneController = TextEditingController();
  String? _verificationId;

  @override
  void initState() {
    super.initState();
    _selectedCountry = countries.first;
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

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
                        DropdownButtonHideUnderline(
                          child: DropdownButton<Country>(
                            value: _selectedCountry,
                            icon: const Icon(Icons.arrow_drop_down,
                                color: Colors.black),
                            elevation: 16,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                            onChanged: (Country? newValue) {
                              setState(() {
                                _selectedCountry = newValue;
                              });
                            },
                            items: countries.map<DropdownMenuItem<Country>>(
                              (Country country) {
                                return DropdownMenuItem<Country>(
                                  value: country,
                                  child: Row(
                                    children: [
                                      Text(country.flag,
                                          style: const TextStyle(fontSize: 20)),
                                      const SizedBox(width: 8),
                                      Text(country.dialCode),
                                    ],
                                  ),
                                );
                              },
                            ).toList(),
                          ),
                        ),
                        const VerticalDivider(
                            color: Colors.grey, thickness: 1, width: 32),
                        Expanded(
                          child: TextField(
                            controller: _phoneController,
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
                    onPressed: () => _sendOtp(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Continue',
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

  Future<void> _sendOtp(BuildContext context) async {
    if (_phoneController.text.length != 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid 10-digit phone number'),
            backgroundColor: Colors.red),
      );
      return;
    }

    String fullPhoneNumber =
        '${_selectedCountry!.dialCode}${_phoneController.text}';
    log('Sending OTP to: $fullPhoneNumber');

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: fullPhoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
        _navigateToHome(context);
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
        setState(() {
          _verificationId = verificationId;
        });
        _showOtpSheet(context);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        log('Auto retrieval timeout: $verificationId');
        setState(() {
          _verificationId = verificationId;
        });
      },
    );
  }

  void _showOtpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (context) => OtpVerificationSheet(
        selectedCountry: _selectedCountry,
        phoneNumber: _phoneController.text,
        verificationId: _verificationId!,
        onVerified: () => _navigateToHome(context),
      ),
    );
  }

  void _navigateToHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const ScreenHome()),
    );
  }
}

class OtpVerificationSheet extends StatefulWidget {
  final Country? selectedCountry;
  final String phoneNumber;
  final String verificationId;
  final VoidCallback onVerified;

  const OtpVerificationSheet({
    super.key,
    required this.selectedCountry,
    required this.phoneNumber,
    required this.verificationId,
    required this.onVerified,
  });

  @override
  State<OtpVerificationSheet> createState() => _OtpVerificationSheetState();
}

class _OtpVerificationSheetState extends State<OtpVerificationSheet> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

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
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 24,
          right: 24,
          top: 24),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Verify Your Number',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'Enter the code sent to ${widget.selectedCountry?.dialCode} ${widget.phoneNumber}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) => _buildOtpField(index)),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  'Verify & Continue',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpField(int index) {
    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: otpControllers[index],
        focusNode: focusNodes[index],
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        decoration:
            const InputDecoration(counterText: '', border: InputBorder.none),
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        onChanged: (value) {
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).requestFocus(focusNodes[index + 1]);
          } else if (value.isEmpty && index > 0) {
            FocusScope.of(context).requestFocus(focusNodes[index - 1]);
          }
        },
      ),
    );
  }

  Future<void> _verifyOtp() async {
    String otp = otpControllers.map((controller) => controller.text).join();
    if (otp.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please enter a valid 6-digit OTP'),
            backgroundColor: Colors.red),
      );
      return;
    }

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otp,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      widget.onVerified();
    } catch (e) {
      log('OTP Verification Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP: $e'), backgroundColor: Colors.red),
      );
    }
  }
}


