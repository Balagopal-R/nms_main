import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/app_controller.dart';
import '../../dtos/nms_dtos/login/get_employ/get_employ.dart';
import '../../dtos/nms_dtos/login/login_dtos/login.dart';
import '../../managers/sharedpreferences/sharedpreferences.dart';
import '../../mixins/snackbar_mixin.dart';
import '../../models/login_screen/get_employee_model.dart';
import '../../repository/api_repository.dart';
import '../../utils/utils.dart';

class SignInController extends GetxController with SnackbarMixin {
  @override
  // ignore: unnecessary_overrides
  void onInit() async {
    super.onInit();
  }

  final _getEmployData = Rx<EmployeeData?>(null);
  EmployeeData? get getEmployData => _getEmployData.value;

  final loginFormKey = GlobalKey<FormState>();
  final _isLoadingOverlay = false.obs;
  bool get isLoadingOverlay => _isLoadingOverlay.value;

  final _retryCount = 3.obs;
  int get retryCount => _retryCount.value;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  var otpController = TextEditingController().obs;
  
  final _validationDisplay = false.obs;
  bool get validationDisplay => _validationDisplay.value;

  final isChecked = false.obs;

  //bool isChecked = false;

  bool isObscure = true;

  //password hide
  final _obsecureText = true.obs;
  bool get obsecureText => _obsecureText.value;

  onPasswordVisible() {
    isObscure = !isObscure;
    update();
  }

  oncheckBox(value) {
    isChecked.value = value!;
    update();
  }

  String? emailValidator(String value) {
    if (value.isEmpty) {
      return emailRequiredText;
    } else if (!isValidEmail(emailController.text)) {
      return invalidEmail;
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty
        //  || value.length < 7
        ) {
      return passwordRequiredText;
    } 
    // else if (value.length < 5) {
    //   return "Minimum 5 Characters";
    // }
    return null;
  }

  passwordAndEmailValidation() {
    if (emailController.text.isEmpty && passwordController.text.isEmpty) {
      _validationDisplay.value = true;
      return false;
    } else if (emailController.text.isEmpty &&
        passwordController.text.isNotEmpty) {
      _validationDisplay.value = true;
      return false;
    } else if (emailController.value.text.isNotEmpty &&
        passwordController.value.text.isEmpty) {
      if (!isValidEmail(emailController.value.text)) {
        showErrorSnackbar(message: invalidEmail);
        return false;
      } else {
        _validationDisplay.value = true;
        return false;
      }
    } else if (emailController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty) {
      if (!isValidEmail(emailController.value.text)) {
        showErrorSnackbar(message: invalidEmail);
        return false;
      } else {
        return true;
      }
    }
  }

  Future<void> login() async {
    //String platform = (Platform.isAndroid || Platform.isIOS) ? "MOBILE" : "WEB";
    if (passwordAndEmailValidation()) {
      try {
        final request = SubmitLoginRequest(
            username: emailController.text,
            // 'francis@nintriva.com',
            password: passwordController.text,
            // 'admin',
            retryCount: retryCount);

        final response =
            await ApiRepository.to.logInWithEmail(request: request);

        if (response.status == 200) {
          // debugPrint('----------${response.data['accessToken']}--------------');
          // debugPrint(
          //     '----------${response.data['refreshToken']}--------------');
          final nmsSharedPreferences = NMSSharedPreferences();
          String accessToken = response.data['accessToken'];
          String refreshToken = response.data['refreshToken'];
          await nmsSharedPreferences.saveTokensToPrefs(
              accessToken, refreshToken);

          await AppController.to.signedIn();

          emailController.clear();
          passwordController.clear();
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      } catch (e) {
        return catchErrorSection(e);
      }
    }
  }

  catchErrorSection(e) async {
    debugPrint('error-----${e.toString()}------');

    if (e.toString().isNotEmpty) {
      try {
        Map<String, dynamic> errorResponse = jsonDecode(e.toString());

        if (errorResponse.containsKey("errors")) {
          Map<String, dynamic> errors =
              Map<String, dynamic>.from(errorResponse["errors"]);
          if (errors.containsKey("errorMessage")) {
            String errorMessage = errors["errorMessage"];

            if (errorMessage.contains("Bad Credentials")) {
              if (retryCount > 0) {
                _retryCount.value = retryCount - 1;
                update();
                if (retryCount == 0) {
                  showErrorSnackbar(
                    message:
                        "incorrect Email-id or password, No attempts remaing",
                  );
                } else {
                  showErrorSnackbar(
                    message:
                        "incorrect Email-id or password, $retryCount attempts remaing  ",
                  );
                }
              } else if (retryCount == 0) {
                showErrorSnackbar(
                  message:
                      "Please visit NxtHR website to reset your password",
                );
              }
            }

            return;
          }
        }
      } catch (e) {
        debugPrint('Error decoding JSON: ${e.toString()}');
        showErrorSnackbar(
          message: e.toString(),
        );
        return e.toString();
      }
    }
  }

  //get employ details

  getEmployDetails() async {
    // _isLoading.value = true;
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = GetEmpoyRequest(userId: userId);
        final response =
            await ApiRepository.to.getEmployDetails(request: request);
        if (response.status == 200) {
          _getEmployData.value = response.data;


          update();
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      // _isLoading.value = false;
      debugPrint(e.toString());
    }
  }
}
