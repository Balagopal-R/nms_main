import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:nms/constants/app_texts.dart';
import 'package:nms/utils/theme/app_theme.dart';
import 'package:nms/utils/theme/device_type.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:nms/widgets/cornered_button.dart';
import 'package:nms/widgets/custom_login_textfield.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';
import 'reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final isPhone = getDeviceTypeGetx() == DeviceType.phone;
    final width = MediaQuery.of(context).size.width;
    final height = isPhone ? width / 1080 * 1920 : width / 2048 * 2732;
    
    return GetBuilder<ResetPasswordController>(
        init: ResetPasswordController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              backgroundColor: backgroundColor,
              resizeToAvoidBottomInset: true,
              body: SingleChildScrollView(
                reverse: true,
                child: Stack(children: [
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: width,
                      height: height,
                    ),
                  ),
                  SafeArea(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 80, 30, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 70,
                            ),
                            SvgPicture.asset(
                              "assets/svg/logo.svg",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(resetPassword,
                                style: AppTheme
                                    .lightTheme.textTheme.headlineLarge
                                    ?.copyWith(
                                        color: primaryTextColor, fontSize: 32)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
                        child: Obx(
                          () => Column(
                            children: [
                              CustomLoginTextField(
                                context: context,
                                controller: controller.emailController,
                                labelText: emailLabel,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                obscureText: false,
                                autovalidateMode: controller.validationDisplay
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (email) {
                                  return controller.emailValidator(email!);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),

                              SizedBox(
                                height: 100,
                                child: WebViewWidget(
                                              controller: controller.controler,
                                            ),
                              ),

                              const SizedBox(
                                height: 16,
                              ),
                              CorneredButton(
                                height: 50,
                                color: primaryColor,
                                title: resetPassword,
                                textcolor: backgroundColor,
                                onPress: () async {
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ]),
              ),
            ),
          );
        });
  }
}