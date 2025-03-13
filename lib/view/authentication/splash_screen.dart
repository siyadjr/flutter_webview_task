import 'package:flutter/material.dart';
import 'package:flutter_task/core/theme/app_colours.dart';
import 'package:flutter_task/main.dart';
import 'package:flutter_task/view/authentication/screen_login.dart';
import 'package:flutter_task/view/home/screen_home.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AppColours appColors = AppColours();

    // Set up navigation after delay
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 3), () {
        checkLogged(context);
      });
    });

    return Scaffold(
      backgroundColor: appColors.mainColour,
      body: Center(
        child: TweenAnimationBuilder<double>(
          tween: Tween<double>(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 1500),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColours().titleColour,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 20,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.flutter_dash,
                      size: 80,
                      color: appColors.mainColour,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: AppColours().titleColour,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Your Flutter journey continues here',
                    style: TextStyle(
                      color: AppColours().titleColour.withOpacity(0.8),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          AppColours().titleColour),
                      strokeWidth: 3,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> checkLogged(BuildContext context) async {
    final sharedPref = await SharedPreferences.getInstance();
    final logged = sharedPref.getBool(isLogged) ?? false;

    if (!context.mounted) return; // Prevents calling setState after widget disposal

    if (logged) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => const ScreenHome()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (ctx) => ScreenLogin()),
      );
    }
  }
}
