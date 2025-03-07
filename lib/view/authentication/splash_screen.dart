import 'package:flutter/material.dart';
import 'package:flutter_task/view/authentication/screen_login.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (ctx) => const ScreenLogin()));
      });
    });
    return const Scaffold(
      body: Center(child: Text('Hello welcome back'),),
    );
  }
}
