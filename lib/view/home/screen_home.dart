import 'package:flutter/material.dart';
import 'package:flutter_task/controller/web_view_controller.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({super.key});

  @override
  Widget build(BuildContext context) {
    final WebViewControllerX controller =
        Get.put(WebViewControllerX()); // Initialize Controller

    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(controller: controller.webViewController),
      ),
    );
  }
}
