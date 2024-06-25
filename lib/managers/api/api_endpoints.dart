//url endpoint
class ApiEndPoints {
  //user,auth-controller

  //nms
  static const String login = 'auth/login';
  static const String getEmploy = 'employee/get';
  static const String getEmployeeDashboard = 'punch/getEmployeeDashboard';
  static const String getPunchStatus = 'punch/punchStatus';
  static const String getAttendance = 'punch/getAttendance';
  static const String getBirthdays = 'employee/getUpcomingBirthdays';
  static const String getRemainingLeaves = 'leaveAllocation/getLeaves';
  static const String logout = 'auth/logout' ;
  static const String documentList = 'file/getAll' ;
}
