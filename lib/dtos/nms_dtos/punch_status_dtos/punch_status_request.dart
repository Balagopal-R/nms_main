class PunchStatusRequest {
  String userId;

  PunchStatusRequest({required this.userId});

   Map<String, String> toMap() {
    return {"userId": userId,};
   }
}
