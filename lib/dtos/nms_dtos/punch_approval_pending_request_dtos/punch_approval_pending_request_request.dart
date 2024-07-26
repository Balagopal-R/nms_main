class PunchApprovalPendingRequest {
  
int id;

PunchApprovalPendingRequest({required this.id});

   Map<String, dynamic> toBody() {
    final map = {"data":{"id":id}};
    return map;
  }

}