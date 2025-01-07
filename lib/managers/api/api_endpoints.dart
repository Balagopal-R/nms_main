//url endpoint
class ApiEndPoints {
  //user,auth-controller

  //nms
  static const String login = 'auth/login';
  static const String refresh = 'auth/refresh';
  static const String getEmploy = 'employee/get';
  static const String getEmployeeDashboard = 'punch/getEmployeeDashboard';
  static const String getPunchStatus = 'punch/punchStatus';
  static const String getAttendance = 'punch/getAttendance';
  static const String getBirthdays = 'employee/getUpcomingBirthdays';
  static const String getRemainingLeaves = 'leaveAllocation/getLeaves';
  static const String logout = 'auth/logout' ;
  static const String documentList = 'file/getAll' ;
  static const String teamListing = 'punch/punchBoard';
  static const String lastPunchIn = 'punch/lastPunchIn';
  static const String punchIn = 'punch/punchIn';
  static const String punchOut = 'punch/punchOut';
  static const String punchRequest = 'punch/punchRequest';
  static const String fileUpload = 'file/upload';
  static const String punchApprovals = 'punch/punchReqGetAll';
  static const String punchApprovalsPendingRequest = 'punch/getPendingRequest';
  static const String punchApprovalsCancel = 'punch/cancel';
  static const String leaveApprovals = 'leaveRequest/listEmployeeLeaveRequest';
  static const String leaveApprovalsCancel = 'leaveRequest/updateByUser';
  static const String leaveYearByLeaveDate = 'leaveRequest/getLeaveYearByLeaveDate';
  static const String getAllMin = 'leave/getAllMin';
  static const String leaveRequest = 'leaveRequest/create';
  static const String punchLine = 'punch/punchLine';
  static const String projectSearch = 'pm/project/search';
  static const String taskSearch = 'pm/task/search';

  static const String deleteFileByName = 'file/delete';
  static const String downloadFileByName = 'file/download';
}
