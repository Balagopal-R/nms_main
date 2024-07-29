class PunchRequestCancelRequest {
  int punchRequestId;

  PunchRequestCancelRequest({required this.punchRequestId});

  Map<String, int> toMap() {
    return {"punchRequestId": punchRequestId};
   }
}
