import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/constants/app_texts.dart';
import 'package:nms/features/splash/splash_controller.dart';
import 'package:nms/utils/theme/app_theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenController>(
        init: SplashScreenController(),
        builder: (controller) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/svg/logo.svg",
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(appName.tr,
                      style: AppTheme.lightTheme.textTheme.displayMedium)
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
