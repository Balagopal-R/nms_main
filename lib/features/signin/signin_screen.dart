import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../constants/app_texts.dart';
import '../../utils/theme/device_type.dart';
import '../../utils/utils.dart';
import '../../widgets/cornered_button.dart';
import '../../widgets/custom_login_textfield.dart';
import 'signin_controller.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPhone = getDeviceTypeGetx() == DeviceType.phone;

    final width = MediaQuery.of(context).size.width;
    final height = isPhone ? width / 1080 * 1920 : width / 2048 * 2732;

    return GetBuilder<SignInController>(
        init: SignInController(),
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
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 60,
                            ),
                            SvgPicture.asset(
                              "assets/svg/logo.svg",
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Text('Hi there!',
                                style: AppTheme
                                    .lightTheme.textTheme.headlineLarge
                                    ?.copyWith(
                                        color: primaryTextColor, fontSize: 32)
                                        ),
                            Text('Welcome.',
                                style: AppTheme
                                    .lightTheme.textTheme.headlineLarge
                                    ?.copyWith(
                                        color: primaryTextColor, fontSize: 32)
                                        ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
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
                              CustomLoginTextField(
                                context: context,
                                labelText: passwordLabel,
                                obscureText: controller.isObscure,
                                controller: controller.passwordController,
                                keyboardType: TextInputType.visiblePassword,
                                suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.isObscure
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: secondaryMediumColor,
                                      size: 24,
                                    ),
                                    onPressed: () {
                                      controller.onPasswordVisible();
                                    }),
                                autovalidateMode: controller.validationDisplay
                                    ? AutovalidateMode.always
                                    : AutovalidateMode.disabled,
                                validator: (password) {
                                  return controller
                                      .passwordValidator(password!);
                                },
                              ),
                              const SizedBox(
                                height: 2,
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                   onTap: () {
                                      Get.offAndToNamed('/reset_password_screen');
                                    },
                                    child: const Text('Forgot Password ?',
                                    style: TextStyle(color: lightGreenTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),),
                                  ),
                                ],
                              ),

                              const SizedBox(
                                height: 8,
                              ),

                              CorneredButton(
                                height: 40,
                                color: primaryColor,
                                title: login,
                                textcolor: backgroundColor,
                                onPress: () async {
                                  await controller.login();
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
