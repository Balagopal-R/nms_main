class LeaveRequestCancelRequest {
  int leaveRequestId;

  LeaveRequestCancelRequest({required this.leaveRequestId});

  Map<String, int> toMap() {
    return {"leaveRequestId": leaveRequestId};
   }
}
