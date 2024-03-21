class LoginModel {
  LoginModel({
    required this.accessToken,
    this.refreshToken,
  });

  String accessToken;

  String? refreshToken;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}