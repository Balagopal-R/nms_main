class SubmitLoginRequest {
  SubmitLoginRequest({
    required this.username,
    required this.password,
    required this.retryCount,
  });

  String username;
  String password;
  int retryCount;

  Map<String, dynamic> toBody() {
    final map = {
    "data": {
        "username": username,
        "password": password,
        "retryCount": retryCount
    }
};
    return map;
  }
}

