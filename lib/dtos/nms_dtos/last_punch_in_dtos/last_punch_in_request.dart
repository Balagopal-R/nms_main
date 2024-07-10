class LastPunchInRequest {
  String userId;

  LastPunchInRequest({required this.userId});

  Map<String, String> toMap() {
    return {"userId": userId,};
   }
}
