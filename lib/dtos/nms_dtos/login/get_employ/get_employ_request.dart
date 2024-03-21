class GetEmpoyRequest {
  String userId;

  GetEmpoyRequest({required this.userId});

   Map<String, String> toMap() {
    return {"userId": userId,};
  }
}