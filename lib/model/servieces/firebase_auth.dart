import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> sendOtp(String phone) async {
    try {
      log('reached');
      await initializeFirebase(); // Ensure Firebase is initialized
      await _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          log("Phone number automatically verified and user signed in: $credential");
        },
        verificationFailed: (FirebaseAuthException e) {
          log("Verification failed: ${e.message}");
        },
        codeSent: (String verificationId, int? resendToken) {
          log("OTP sent to $phone. Verification ID: $verificationId");
          // Store verificationId for later use if needed
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log("Auto retrieval timeout. Verification ID: $verificationId");
        },
      );
    } catch (e) {
      log("Error in sendOtp: $e");
    }
  }
}
