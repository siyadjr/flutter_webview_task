import 'package:flutter/material.dart';
import 'package:flutter_task/controller/web_view_controller.dart';
import 'package:flutter_task/core/sharedpreferences/login_shared_preference.dart';
import 'package:flutter_task/view/authentication/screen_login.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewControllerX controller = Get.put(WebViewControllerX());
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller.webViewController),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            logutConfirmation(context);
          },
          child: const Icon(Icons.logout),
        ),
      ),
    );
  }

  Future<void> logutConfirmation(context) async {
    Get.defaultDialog(
      title: 'Logout',
      middleText: "Are you sure you want to Logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.back(); // Close dialog
        LoginSharedPreference().logOut();
        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (ctx) => ScreenLogin()), (_) => false);
      },
      onCancel: () {
        print("User cancelled");
      },
    );
  }
}
