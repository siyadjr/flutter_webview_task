import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewControllerX extends GetxController {
  late final WebViewController webViewController;
  var isLoading = true.obs; // Observable variable to track loading status
  var errorMessage = ''.obs; // Stores error messages

  @override
  void onInit() {
    super.onInit();
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoading.value = true; // Start loading
            errorMessage.value = ''; // Reset error message
          },
          onPageFinished: (String url) {
            isLoading.value = false; // Page loaded successfully
          },
          onWebResourceError: (WebResourceError error) {
            isLoading.value = false; // Stop loading if error occurs
            errorMessage.value = "Error: ${error.description}";
            Get.snackbar("WebView Error", errorMessage.value,
                backgroundColor: Get.theme.colorScheme.error,
                colorText: Get.theme.colorScheme.onError);
          },
        ),
      )
      ..loadRequest(Uri.parse("https://flutter.dev/showcase"));
  }

  void reloadWebView() {
    isLoading.value = true;
    errorMessage.value = '';
    webViewController.reload();
  }

}
