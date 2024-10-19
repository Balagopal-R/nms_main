import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/file_upload_model/file_upload_model.dart';
import 'package:nms/models/leave_approvals_model/leave_approvals_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';
import 'package:nms/utils/theme/theme.dart';
import '../../../../dtos/nms_dtos/file_upload_dtos/file_upload.dart';
import '../../../../dtos/nms_dtos/get_all_min_leave_dtos/get_all_min_leave.dart';
import '../../../../dtos/nms_dtos/get_leave_year_by_date_dtos/get_leave_year_by_date.dart';
import '../../../../dtos/nms_dtos/leave_request_create_dtos/leave_request_create.dart';
import '../../../../models/get_all_min_leave_model/get_all_min_leave_model.dart';
import '../../../../models/get_leave_year_by_date_model/get_leave_year_by_date_model.dart';

class ApplyLeaveBottomSheetController extends GetxController
    with SnackbarMixin {
  var isLeaveTypeValid = true.obs;
  var isDurationValid = true.obs;
  final selectedLeaveType = ''.obs;
  final selectedDuration = ''.obs;
  var isCommentValid = true.obs;
  var comment = ''.obs;
  final selectedId = 0.obs;
  final isEnforceAdjHoliday = false.obs;

  var leaveTypes = ['Casual', 'Sick', 'Family', 'Vacation'];
  var duration = ['FULL_DAY', 'FIRST_HALF', 'SECOND_HALF'];
  var multipleDuration = ['FULL_DAY'];
  List<String> leaveNames = ['No results found'];

  final FocusNode commentsFocusNode = FocusNode();
  final commentController = TextEditingController();

  var uploadedImageMessage = "".obs;

  final _getLeaveYearByDate = (List<GetLeaveYearByLeaveDateModel>.empty()).obs;
  List<GetLeaveYearByLeaveDateModel> get getLeaveYearByDate =>
      _getLeaveYearByDate;

  final _getAllMinLeav = (List<GetAllMinLeaveModel>.empty()).obs;
  List<GetAllMinLeaveModel> get getAllMinLeav => _getAllMinLeav;

  final _userFileUpload = Rx<FileUploadModel?>(null);
  FileUploadModel? get userFileUpload => _userFileUpload.value;

  final _leaveRequestMessage = ''.obs;
  String get leaveRequestMessage => _leaveRequestMessage.value;

  List<PlatformFile> files = [];

   List<LeaveDocument> leaveDocumentsUser = []; // List to hold leaveDocuments

  @override
  void onInit() async {
    super.onInit();
    clearLeaveDocuments();
    }

  List<String> getDurationList() {
    if (selectedDays != null && selectedDays! > 1) {
      return multipleDuration;
    } else {
      return duration;
    }
  }

  clearDurationDropdown(){
    selectedDuration.value = '';
  }

  clearLeaveDocuments(){
    leaveDocumentsUser.clear();
  }

  bool validateDates() {
    if (leaveFromDate == null || toDate == null) {
      // print('Please select both dates');
      return false;
    }

    if (toDate!.isBefore(leaveFromDate!)) {
      // print('To Date must not precede From Date');
      return false;
    }

    // print('Both dates are valid');
    return true;
  }

  String formatDate(DateTime? date) {
    if (date == null) {
      return ''; // Or return a default value if needed
    }

    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }

  //  Get leave year by Leave Date
  getLeaveYearByLeaveDate() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();

      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = GetLeaveYearByDateRequest(
          userId: userId,
          leaveStartDate: formatDate(leaveFromDate),
          leaveEndDate: formatDate(toDate),
        );
       
        final response =
            await ApiRepository.to.leaveYearByLeaveDate(request: request);

        if (response.status == 200) {
          _getLeaveYearByDate.value = response.data;
          update();
          await getAllMinLeave();
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
          update();
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  //  Get All Min Leaves
  getAllMinLeave() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();

      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        final request = GetAllMinLeaveRequest(
          id: getLeaveYearByDate[0].id,
          userId: userId,
        );

        final response = await ApiRepository.to.getAllMin(request: request);

        if (response.status == 200) {
          _getAllMinLeav.value = response.data;
          leaveNames = getAllMinLeav.map((leave) => leave.name).toList();

          update();
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
          update();
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      debugPrint(e.toString());
      update();
    }
  }

  Future<void> uploadFiles(List<PlatformFile> files) async {
    for (var file in files) {
      await uploadImage(file);
    }
  }

  // upload image api function
  Future<void> uploadImage(PlatformFile imageFile) async {
    String defaultMessage = '';

    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];
        File fileFromPath = File(imageFile.xFile.path);
        // File fileFromPath =
        final request = FileUploadRequest(
            userId: userId, file: fileFromPath, category: 'OTHERS');
        final response = await ApiRepository.to.fileUpload(request: request);

        if (response.status == 200) {
          _userFileUpload.value = response.data;

           // Create a new LeaveDocument object
        LeaveDocument document = LeaveDocument(
          filename: userFileUpload!.fileName,
          displayName: userFileUpload!.displayName,
          url: userFileUpload!.fileUrl,
        );

        // Add the document to the leaveDocuments list
        leaveDocumentsUser.add(document);
        // for(int i = 0; i< leaveDocumentsUser.length; i++) {
        //   print("------------");
        //  print(leaveDocumentsUser[i].url);
        //  print(leaveDocumentsUser[i].displayName);
        //  print(leaveDocumentsUser[i].filename);
        //  print("------------");
        // }
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      uploadedImageMessage.value = defaultMessage;
      debugPrint(e.toString());
    }
  }

  //  User Leave/WFH Request
  userLeaveRequest(BuildContext context) async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = LeaveRequestCreateRequest(
            userId: userId,
            duration: selectedDuration.value,
            id: selectedId.value,
            comments: comment.value,
            lengthOfLeave: selectedDays!.toInt(),
            leuOfStartDate: formatDate(lieuOfDate),
            leuOfEndDate: formatDate(lieuToDate),
            leaveYearId: 1,
            leaveStartDate: formatDate(leaveFromDate),
            leaveEndDate: formatDate(toDate),
            leaveDocuments: leaveDocumentsUser
            );

        final response = await ApiRepository.to.leaveRequest(request: request);

        if (response.status == 200) {
          _leaveRequestMessage.value = response.data;
          showSuccessSnackbar(
              title: 'Success',
              message: 'You have successfully submitted a new Leave request');
          await Future.delayed(const Duration(seconds: 4));
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      // showErrorSnackbar(message: 'Failed to submit a new Leave request');
    }
  }

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'pdf'],
    );

    if (result != null) {
      for (var file in result.files) {
        final fileExtension = file.extension?.toLowerCase();
        final fileSizeInMB = file.size / (1024 * 1024);

        if (!(fileExtension == 'jpg' ||
            fileExtension == 'jpeg' ||
            fileExtension == 'pdf')) {
          showErrorSnackbar(message: 'Please select a JPEG, JPG, or PDF file.');
        } else if (fileSizeInMB > 5) {
          showErrorSnackbar(message: 'The file size should not exceed 5MB.');
        } else {
          files.add(file);

          if (files.length > 3) {
            files = files.sublist(0, 3); // Limit to 3 files
          }
          update();
        }
      }
    }
  }

  void validateForm() {
    isLeaveTypeValid.value = selectedLeaveType.isNotEmpty;
    isDurationValid.value = selectedDuration.isNotEmpty;
    isCommentValid.value = comment.isNotEmpty;
  }

  DateTime? leaveFromDate; // Date selected in "Leave From"
  DateTime? toDate; // Date selected in "To"
  String? validationMessage; // To hold the validation message
  double? selectedDays; // To hold the number of days selected

  Future<void> selectLeaveFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: leaveFromDate ??
          DateTime.now(), // Default to today if no date selected
      firstDate: DateTime(2018, 1, 1), // Earliest selectable date
      lastDate: DateTime(2100), // Allow selecting any future date
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Selection color
              onPrimary:
                  Colors.white, // Text color inside the selected date circle
              surface: Colors.white, // Background color of the date picker
              onSurface: Colors.black, // Text color for dates
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != leaveFromDate) {
      leaveFromDate = picked;
      // Reset validation message when leave from date changes
      validationMessage = null;
      selectedDays = null; // Reset selected days
    }
    updateSelectedDays(); // Call function to update selected days after date change
    update(); // Update UI
  }

  Future<void> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          toDate ?? DateTime.now(), // Default to today if no date selected
      firstDate: DateTime(2018, 1, 1), // Earliest selectable date
      lastDate: DateTime(2100), // Allow selecting any future date
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Selection color
              onPrimary:
                  Colors.white, // Text color inside the selected date circle
              surface: Colors.white, // Background color of the date picker
              onSurface: Colors.black, // Text color for dates
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != toDate) {
      toDate = picked;

      // Validation: Check if "To" date precedes "Leave From" date
      if (leaveFromDate != null && toDate!.isBefore(leaveFromDate!)) {
        validationMessage =
            'To Date precedes From-date'; // Set validation message
      } else {
        validationMessage = null; // Clear validation message if valid
      }
    }
    updateSelectedDays(); // Call function to update selected days after date change
    update(); // Update UI
  }

  void updateSelectedDays() {
  // Check if dates are valid
  if (leaveFromDate != null && toDate != null && validationMessage == null) {
    // Calculate total days between leaveFromDate and toDate
    int totalDays = toDate!.difference(leaveFromDate!).inDays + 1;

    if (isEnforceAdjHoliday.value) {
      // Exclude Saturdays and Sundays from total days
      int weekendsCount = 0;
      for (int i = 0; i < totalDays; i++) {
        DateTime currentDate = leaveFromDate!.add(Duration(days: i));
        if (currentDate.weekday == DateTime.saturday ||
            currentDate.weekday == DateTime.sunday) {
          weekendsCount++;
        }
      }
      selectedDays = totalDays - weekendsCount.toDouble();
    } else {
      selectedDays = totalDays.toDouble(); // Include all days
    }

    // Check if selectedDuration is FIRST_HALF or SECOND_HALF
    if (selectedDuration.value == 'FIRST_HALF' ||
        selectedDuration.value == 'SECOND_HALF') {
      selectedDays = 0.5; // Set selectedDays to 0.5 for half days
    }
  } else {
    selectedDays = null; // Reset if dates are invalid
  }

  // Update the UI or any necessary state
  update();
}




  DateTime? lieuOfDate; // Date selected in "Leave From"
  DateTime? lieuToDate; // Date selected in "To"
  String? lieuValidationMessage; // To hold the validation message
  int? selectedLieuDays; // To hold the number of days selected

  Future<void> selectLieuFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          lieuOfDate ?? DateTime.now(), // Default to today if no date selected
      firstDate: DateTime(2018, 1, 1), // Earliest selectable date
      lastDate: DateTime(2100), // Allow selecting any future date
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Selection color
              onPrimary:
                  Colors.white, // Text color inside the selected date circle
              surface: Colors.white, // Background color of the date picker
              onSurface: Colors.black, // Text color for dates
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != lieuOfDate) {
      lieuOfDate = picked;
      // Reset validation message when leave from date changes
      lieuValidationMessage = null;
      selectedLieuDays = null; // Reset selected days
    }

    update(); // Update UI
  }

  Future<void> selectLieuToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          lieuToDate ?? DateTime.now(), // Default to today if no date selected
      firstDate: DateTime(2018, 1, 1), // Earliest selectable date
      lastDate: DateTime(2100), // Allow selecting any future date
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green, // Selection color
              onPrimary:
                  Colors.white, // Text color inside the selected date circle
              surface: Colors.white, // Background color of the date picker
              onSurface: Colors.black, // Text color for dates
            ),
            dialogBackgroundColor:
                Colors.white, // Background color of the dialog
          ),
          child: child!,
        );
      },
    );

//      if (picked != null && picked != lieuToDate) {
//     lieuToDate = picked;

//     // Validation: Check if "To" date precedes "Leave From" date
//     if (lieuOfDate != null && lieuToDate!.isBefore(lieuOfDate!)) {
//       lieuValidationMessage = 'Lieu of Date precedes to-date'; // Set validation message
//     } 
//     // Validation: Check if the selectedLieuDays differs from selectedDays
//     else if (selectedDays != null && selectedLieuDays != null && selectedDays != selectedLieuDays) {
//       lieuValidationMessage = 'Please select the correct date duration'; // Set validation message
//     } 
//     else {
//       lieuValidationMessage = null; // Clear validation message if valid
//     }
//   }

//   updateLieuSelectedDays(); // Call function to update selected lieu days after date change
//   update(); // Update UI
// }

    if (picked != null && picked != lieuToDate) {
      lieuToDate = picked;

      // Validation: Check if "To" date precedes "Leave From" date
      if (lieuOfDate != null && lieuToDate!.isBefore(lieuOfDate!)) {
        lieuValidationMessage =
            'Lieu of Date precedes to-date'; // Set validation message
      } else if (selectedDays == selectedLieuDays) {
        lieuValidationMessage =
            'Please select the correct date duration'; // Set validation message
      } else {
        lieuValidationMessage = null; // Clear validation message if valid
      }
    }
    updateLieuSelectedDays(); // Call function to update selected days after date change
    update(); // Update UI
  }

// Function to calculate and update the selected Lieu days
  void updateLieuSelectedDays() {
    if (lieuOfDate != null &&
        lieuToDate != null &&
        lieuValidationMessage == null) {
      // Calculate the difference in days and add 1 to include both dates
      selectedLieuDays = lieuToDate!.difference(lieuOfDate!).inDays + 1;
    } else {
      selectedLieuDays = null; // Reset if dates are invalid
    }
    update();
  }

  void removeFile(int index) {
    files.removeAt(index);
    update();
  }

  void showCustomDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: backgroundColor,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'Are you sure you want to delete this document?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: primaryTextColor,
                    fontFamily: 'Satoshi',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4, // 140% line height
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    removeFile(index);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: darkRed,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Handle 'No, go back' action
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: lightGreenTextColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        color: lightGreenTextColor,
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
