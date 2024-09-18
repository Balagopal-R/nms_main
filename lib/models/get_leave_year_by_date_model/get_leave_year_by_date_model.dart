class GetLeaveYearByLeaveDateModel {
    int id;
    String year;
    int startMonth;
    Config config;
    String orgId;

    GetLeaveYearByLeaveDateModel({
        required this.id,
        required this.year,
        required this.startMonth,
        required this.config,
        required this.orgId,
    });

    factory GetLeaveYearByLeaveDateModel.fromJson(Map<String, dynamic> json) => GetLeaveYearByLeaveDateModel(
        id: json["id"],
        year: json["year"],
        startMonth: json["startMonth"],
        config: Config.fromJson(json["config"]),
        orgId: json["orgId"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "year": year,
        "startMonth": startMonth,
        "config": config.toJson(),
        "orgId": orgId,
    };
}

class Config {
    int id;
    String leaveYearName;
    int startMonth;
    String orgId;
    bool isActive;

    Config({
        required this.id,
        required this.leaveYearName,
        required this.startMonth,
        required this.orgId,
        required this.isActive,
    });

    factory Config.fromJson(Map<String, dynamic> json) => Config(
        id: json["id"],
        leaveYearName: json["leaveYearName"],
        startMonth: json["startMonth"],
        orgId: json["orgId"],
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "leaveYearName": leaveYearName,
        "startMonth": startMonth,
        "orgId": orgId,
        "isActive": isActive,
    };
}
