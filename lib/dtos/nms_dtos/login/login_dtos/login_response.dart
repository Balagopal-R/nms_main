import '../../../../models/login_screen/login_model.dart';
import '../../../api_response.dart';

class SubmitLoginResponse extends ApiResponse {
  SubmitLoginResponse({message, status, data, errors})
      : super(message: message, status: status, data: data, errors: errors);

  factory SubmitLoginResponse.fromJson(Map<String, dynamic> json) {
    return SubmitLoginResponse(
      message: json["message"],
      status: json["status"],
      data: json["data"]!,
      errors: json["errors"]
    );
  }

  LoginModel? getToken() {
    return (data != null) ? LoginModel.fromJson(data) : null;
  }
}
