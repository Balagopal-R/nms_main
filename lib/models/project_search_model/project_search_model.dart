class ProjectSearchModel {
    String projectName;
    String projectAbbr;
    String clientId;
    String projectDescription;
    String startDate;
    String endDate;
    int etcInMinutes;
    bool isBillable;
    String status;
    String? projectImage;
    String? projectImageUrl;
    String orgId;
    String unitId;
    bool isDeleted;
    bool isArchived;
    dynamic documentsUrls;
    String projectId;
    List<Assignee> teamLeads;
    List<Assignee> assignees;
    dynamic tasks;
    Client client;

    ProjectSearchModel({
        required this.projectName,
        required this.projectAbbr,
        required this.clientId,
        required this.projectDescription,
        required this.startDate,
        required this.endDate,
        required this.etcInMinutes,
        required this.isBillable,
        required this.status,
        this.projectImage,
        this.projectImageUrl,
        required this.orgId,
        required this.unitId,
        required this.isDeleted,
        required this.isArchived,
        required this.documentsUrls,
        required this.projectId,
        required this.teamLeads,
        required this.assignees,
        required this.tasks,
        required this.client,
    });

    factory ProjectSearchModel.fromJson(Map<String, dynamic> json) => ProjectSearchModel(
        projectName: json["projectName"],
        projectAbbr: json["projectAbbr"],
        clientId: json["clientId"],
        projectDescription: json["projectDescription"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        etcInMinutes: json["etcInMinutes"],
        isBillable: json["isBillable"],
        status: json["status"],
        projectImage: json["projectImage"],
        projectImageUrl: json["projectImageUrl"],
        orgId: json["orgId"],
        unitId: json["unitId"],
        isDeleted: json["isDeleted"],
        isArchived: json["isArchived"],
        documentsUrls: json["documentsUrls"],
        projectId: json["projectId"],
        teamLeads: List<Assignee>.from(json["teamLeads"].map((x) => Assignee.fromJson(x))),
        assignees: List<Assignee>.from(json["assignees"].map((x) => Assignee.fromJson(x))),
        tasks: json["tasks"],
        client: Client.fromJson(json["client"]),
    );

    Map<String, dynamic> toJson() => {
        "projectName": projectName,
        "projectAbbr": projectAbbr,
        "clientId": clientId,
        "projectDescription": projectDescription,
        "startDate": startDate,
        "endDate": endDate,
        "etcInMinutes": etcInMinutes,
        "isBillable": isBillable,
        "status": status,
        "projectImage": projectImage,
        "projectImageUrl": projectImageUrl,
        "orgId": orgId,
        "unitId": unitId,
        "isDeleted": isDeleted,
        "isArchived": isArchived,
        "documentsUrls": documentsUrls,
        "projectId": projectId,
        "teamLeads": List<dynamic>.from(teamLeads.map((x) => x.toJson())),
        "assignees": List<dynamic>.from(assignees.map((x) => x.toJson())),
        "tasks": tasks,
        "client": client.toJson(),
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

class Client {
    String clientId;
    String clientName;
    String companyName;
    String companyAbbr;
    String? coverImageUrl;

    Client({
        required this.clientId,
        required this.clientName,
        required this.companyName,
        required this.companyAbbr,
        this.coverImageUrl,
    });

    factory Client.fromJson(Map<String, dynamic> json) => Client(
        clientId: json["clientId"],
        clientName: json["clientName"],
        companyName: json["companyName"],
        companyAbbr: json["companyAbbr"],
        coverImageUrl: json["coverImageUrl"],
    );

    Map<String, dynamic> toJson() => {
        "clientId": clientId,
        "clientName": clientName,
        "companyName": companyName,
        "companyAbbr": companyAbbr,
        "coverImageUrl": coverImageUrl,
    };
}