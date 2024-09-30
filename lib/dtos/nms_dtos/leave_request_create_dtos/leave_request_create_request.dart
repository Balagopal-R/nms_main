class LeaveRequestCreateRequest {
  String userId;
  String duration;
  int id;
  String comments;
  int lengthOfLeave;
  String? leuOfStartDate;
  String? leuOfEndDate;
  int leaveYearId;
  String leaveStartDate;
  String leaveEndDate;
  List<LeaveDocument> leaveDocuments;

  LeaveRequestCreateRequest({
    required this.userId,
    required this.duration,
    required this.id,
    required this.comments,
    required this.lengthOfLeave,
    this.leuOfStartDate,
    this.leuOfEndDate,
    required this.leaveYearId,
    required this.leaveStartDate,
    required this.leaveEndDate,
    required this.leaveDocuments,
  });

  Map<String, dynamic> toBody() {
    return {
      "data": {
        "employee": {"userId": userId},
        "duration": duration,
        "leaveType": {"id": id},
        "comments": comments,
        "lengthOfLeave": lengthOfLeave,
        "leuOfStartDate": leuOfStartDate,
        "leuOfEndDate": leuOfEndDate,
        "leaveYearId": leaveYearId,
        "leaveStartDate": leaveStartDate,
        "leaveEndDate": leaveEndDate,
        "leaveDocuments": leaveDocuments.map((doc) => doc.toJson()).toList(),
      }
    };
  }
}

class LeaveDocument {
  String filename;
  String displayName;
  String url;

  LeaveDocument({
    required this.filename,
    required this.displayName,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      "filename": filename,
      "displayName": displayName,
      "url": url,
    };
  }
}
