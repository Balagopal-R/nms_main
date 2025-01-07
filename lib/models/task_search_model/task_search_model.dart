class TaskSearchModel {
  String taskName;
  String taskCode;
  String startDate;
  String endDate;
  String taskType;
  int etcInMinutes;
  int priority;
  String status;
  String description;
  dynamic isBillable;
  dynamic documentsUrls;
  dynamic calenderTaskId;
  dynamic taskGroupId;
  String projectId;
  String clientId;
  String orgId;
  String unitId;
  bool isDeleted;
  String taskId;
  List<Assignee> assignees;
  String taskPriority;

  TaskSearchModel({
    required this.taskName,
    required this.taskCode,
    required this.startDate,
    required this.endDate,
    required this.taskType,
    required this.etcInMinutes,
    required this.priority,
    required this.status,
    required this.description,
    required this.isBillable,
    required this.documentsUrls,
    required this.calenderTaskId,
    required this.taskGroupId,
    required this.projectId,
    required this.clientId,
    required this.orgId,
    required this.unitId,
    required this.isDeleted,
    required this.taskId,
    required this.assignees,
    required this.taskPriority,
  });

  factory TaskSearchModel.fromJson(Map<String, dynamic> json) =>
      TaskSearchModel(
        taskName: json["taskName"],
        taskCode: json["taskCode"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        taskType: json["taskType"],
        etcInMinutes: json["etcInMinutes"],
        priority: json["priority"],
        status: json["status"],
        description: json["description"],
        isBillable: json["isBillable"],
        documentsUrls: json["documentsUrls"],
        calenderTaskId: json["calenderTaskId"],
        taskGroupId: json["taskGroupId"],
        projectId: json["projectId"],
        clientId: json["clientId"],
        orgId: json["orgId"],
        unitId: json["unitId"],
        isDeleted: json["isDeleted"],
        taskId: json["taskId"],
        assignees: List<Assignee>.from(
            json["assignees"].map((x) => Assignee.fromJson(x))),
        taskPriority: json["taskPriority"],
      );

  Map<String, dynamic> toJson() => {
        "taskName": taskName,
        "taskCode": taskCode,
        "startDate": startDate,
        "endDate": endDate,
        "taskType": taskType,
        "etcInMinutes": etcInMinutes,
        "priority": priority,
        "status": status,
        "description": description,
        "isBillable": isBillable,
        "documentsUrls": documentsUrls,
        "calenderTaskId": calenderTaskId,
        "taskGroupId": taskGroupId,
        "projectId": projectId,
        "clientId": clientId,
        "orgId": orgId,
        "unitId": unitId,
        "isDeleted": isDeleted,
        "taskId": taskId,
        "assignees": List<dynamic>.from(assignees.map((x) => x.toJson())),
        "taskPriority": taskPriority,
      };
}

class Assignee {
  String userId;
  String firstName;
  String lastName;
  String email;
  dynamic designation;
  dynamic department;
  dynamic workMobile;
  String? profileImgUrl;
  dynamic orgId;
  dynamic unitId;

  Assignee({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.designation,
    required this.department,
    required this.workMobile,
    this.profileImgUrl,
    required this.orgId,
    required this.unitId,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        designation: json["designation"],
        department: json["department"],
        workMobile: json["workMobile"],
        profileImgUrl: json["profileImgUrl"],
        orgId: json["orgId"],
        unitId: json["unitId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "designation": designation,
        "department": department,
        "workMobile": workMobile,
        "profileImgUrl": profileImgUrl,
        "orgId": orgId,
        "unitId": unitId,
      };
}
