import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/utils/helpers/validation.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class ResetPasswordController extends GetxController {
  late WebViewControllerPlus controler;
  double _height = 1.0;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    controler = WebViewControllerPlus()
      ..loadFlutterAssetServer('assets/index.html')
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            controler.getWebViewHeight().then((value) {
              var height = int.parse(value.toString()).toDouble();
              if (height != _height) {
                if (kDebugMode) {
                  print("Height is: $value");
                }

                _height = height;
              }
              update();
            });
          },
        ),
      );
  }

  final emailController = TextEditingController();

  final _validationDisplay = false.obs;
  bool get validationDisplay => _validationDisplay.value;

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return emailRequiredText;
    } else if (!isValidEmail(emailController.text)) {
      return invalidEmail;
    }
    return null;
  }
}
