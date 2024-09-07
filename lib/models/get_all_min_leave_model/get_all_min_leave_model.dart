class GetAllMinLeaveModel {
    int id;
    String type;
    String name;
    bool isEnforceAdjHoliday;
    bool isEnforceAdjOffDay;
    String nameAbbr;

    GetAllMinLeaveModel({
        required this.id,
        required this.type,
        required this.name,
        required this.isEnforceAdjHoliday,
        required this.isEnforceAdjOffDay,
        required this.nameAbbr,
    });

    factory GetAllMinLeaveModel.fromJson(Map<String, dynamic> json) => GetAllMinLeaveModel(
        id: json["id"],
        type: json["type"],
        name: json["name"],
        isEnforceAdjHoliday: json["isEnforceAdjHoliday"],
        isEnforceAdjOffDay: json["isEnforceAdjOffDay"],
        nameAbbr: json["nameAbbr"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "name": name,
        "isEnforceAdjHoliday": isEnforceAdjHoliday,
        "isEnforceAdjOffDay": isEnforceAdjOffDay,
        "nameAbbr": nameAbbr,
    };
}
