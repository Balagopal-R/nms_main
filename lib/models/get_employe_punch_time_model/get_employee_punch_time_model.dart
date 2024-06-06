class GetEmployeePunchTimeModel {
    int startDate;
    int endDate;
    int day;
    int clockedWorkingMinutes;
    int clockedBreakMinutes;

    GetEmployeePunchTimeModel({
        required this.startDate,
        required this.endDate,
        required this.day,
        required this.clockedWorkingMinutes,
        required this.clockedBreakMinutes,
    });

    factory GetEmployeePunchTimeModel.fromJson(Map<String, dynamic> json) => GetEmployeePunchTimeModel(
        startDate: json["startDate"],
        endDate: json["endDate"],
        day: json["day"],
        clockedWorkingMinutes: json["clockedWorkingMinutes"],
        clockedBreakMinutes: json["clockedBreakMinutes"],
    );

    Map<String, dynamic> toJson() => {
        "startDate": startDate,
        "endDate": endDate,
        "day": day,
        "clockedWorkingMinutes": clockedWorkingMinutes,
        "clockedBreakMinutes": clockedBreakMinutes,
    };
}
