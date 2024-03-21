import 'package:get/utils.dart';

const String firstnameRequiredText = 'First-name required';
const String lastnameRequiredText = 'Last-name required';
const String emailRequiredText = 'Email Required';
const String phonenoRequiredText = 'Phone-number required';
const String passwordRequiredText = 'Password Required';
const String confirmRequiredText = 'Confirm password required';
const String emiratesRequiredText = 'Emirates-id or Passport required';

const String emptyFields = "Please fill the field";
const String invalidEmail = "Please enter a valid email";
const String invalidZipcode = "Please enter a valid zip-code";
const String invalidMobile = "Please enter a valid mobile number.";
const String invalidPassword =
    ". Password must be 8 characters or more\n. At least 1 special characters needed \n. Lowercase and uppercase letters included";
// "Minimum 8 characters,at least 1 letter and 1 number";
const String invalidName =
    "Please enter a vaild  name.\n name shall\n- start with an alphabet.\n- have no special characters.\n- have minimum 2 characters.";
const String invalidOTP = "Please enter a valid OTP.";

const String nameValidationInfo =
    "name shall\n- start with an alphabet.\n- have no special characters.";

const String invalidRemark = "Please Enter a valid Reason";
const String fillRemark = "Please Enter Your Remark";

const String errorText = 'Error';
const String successText = 'Success';

const String errorOccuredText = 'Error Occured';

//change password validation
const String currentRequiredText = 'Current password required';
const String newRequiredText = 'New password required';

//search validation

const String minimumSearchCharacters = 'You should need minimum 3 characters';


abstract class ValidationStatus {}

class ValidationSuccess extends ValidationStatus {
  @override
  String toString() {
    return "success";
  }
}

class ValidationError extends ValidationStatus {
  final String errorMessage;

  ValidationError({required this.errorMessage});

  @override
  String toString() {
    return errorMessage;
  }
}

bool isValidPhone(String phone) {
  return RegExp(r"^[0-9]{0,20}$").hasMatch(phone);
}

bool isValidEmail(String email) {
  return GetUtils.isEmail(email);
}

bool isValidName(String name) {
  return RegExp(r"^[A-Za-z]{1,1}[A-Za-z ]{0,28}[A-Za-z]{1,1}$").hasMatch(name);
}

bool isValidPassword(String password) {
  return RegExp(
          r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=])[A-Za-z\d@#$%^&+=]{8,25}$")
      .hasMatch(password);
}

bool isValidAge(String age) {
  return RegExp(r"^[0-9]{0,}$").hasMatch(age);
}

bool isValidPrice(String price) {
  return RegExp(r"^[0-9]{0,}$").hasMatch(price);
}

bool isValidOtp(String otp) {
  return RegExp(r"^[0-9]{4}$").hasMatch(otp);
}

bool isValidZipCode(String zipCode) {
  return RegExp(r"^\d{5}$").hasMatch(zipCode);
}
