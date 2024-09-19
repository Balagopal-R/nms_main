import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/file_upload_model/file_upload_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';

import '../../../../dtos/nms_dtos/file_upload_dtos/file_upload.dart';
import '../../../../dtos/nms_dtos/get_all_min_leave_dtos/get_all_min_leave.dart';
import '../../../../dtos/nms_dtos/get_leave_year_by_date_dtos/get_leave_year_by_date.dart';
import '../../../../dtos/nms_dtos/leave_request_create_dtos/leave_request_create.dart';
import '../../../../models/get_all_min_leave_model/get_all_min_leave_model.dart';
import '../../../../models/get_leave_year_by_date_model/get_leave_year_by_date_model.dart';

class ApplyLeaveBottomSheetController extends GetxController with SnackbarMixin{

  var isLeaveTypeValid = true.obs;
  var isDurationValid = true.obs;
  final selectedLeaveType = ''.obs;
  final selectedDuration = ''.obs;
    var isCommentValid = true.obs;
  var comment = ''.obs;

  
  var leaveTypes = ['Casual', 'Sick', 'Family', 'Vacation'];
  var duration = ['Full Day', 'First half', 'Second half'];

  final FocusNode commentsFocusNode = FocusNode();
  final commentController = TextEditingController();

  var uploadedImageMessage = "".obs;

    final _getLeaveYearByDate = (List<GetLeaveYearByLeaveDateModel>.empty()).obs;
  List<GetLeaveYearByLeaveDateModel> get getLeaveYearByDate => _getLeaveYearByDate;

  final _getAllMinLeav = (List<GetAllMinLeaveModel>.empty()).obs;
  List<GetAllMinLeaveModel> get getAllMinLeav => _getAllMinLeav;

    final _userFileUpload = Rx<FileUploadModel?>(null);
  FileUploadModel? get userFileUpload => _userFileUpload.value;

    final _leaveRequestMessage = ''.obs;
  String get leaveRequestMessage => _leaveRequestMessage.value;

  List<PlatformFile> files = [];

    @override
  void onInit() async {
  // await getLeaveYearByLeaveDate();
  // await getAllMinLeave();
  // await userLeaveRequest();
        super.onInit();
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
      leaveStartDate: '2024-09-05',
      leaveEndDate: '2024-09-05',
      );

      final response = await ApiRepository.to.leaveYearByLeaveDate(request: request);

      if (response.status == 200) {
        _getLeaveYearByDate.value = response.data;

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

   Future<void> uploadFiles(
      List<PlatformFile> files) async {
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
            userId: userId,
            file: fileFromPath,
            category: 'OTHERS');
        print('request:${request.toString()}');

        final response = await ApiRepository.to.fileUpload(request: request);
        print('response:${response.toString()}');

        if (response.status == 200) {
          _userFileUpload.value = response.data;
          print(userFileUpload!.fileUrl);
          // showSuccessSnackbar(
          //     title: 'Success', message: 'File Upload Successfully');
          // await Future.delayed(Duration(seconds: 5));
          // Navigator.pop(context);
        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      uploadedImageMessage.value = defaultMessage;
      debugPrint(e.toString());
    }
  }

   //  User Leave/WFH Request
   userLeaveRequest() async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
       final userId = decodedToken["userId"];

        final request = LeaveRequestCreateRequest(
          userId: userId,
          duration: "FULL_DAY",
          id: 43,
          comments : "Sick",
          lengthOfLeave: 1,
          leuOfStartDate: 0,
          leuOfEndDate : 0,
          leaveYearId: 1,
          leaveStartDate: "2024-09-11",
          leaveEndDate: "2024-09-11",
          leaveDocuments: []
          );

        final response =
            await ApiRepository.to.leaveRequest(request: request);

        if (response.status == 200) {
        _leaveRequestMessage.value = response.data;
        print(leaveRequestMessage);
        showSuccessSnackbar(title: 'Success', message:'You have successfully submitted a new Leave request') ;
        // await Future.delayed(Duration(seconds: 4));
        // Navigator.pop(context);
        
       

        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
        }
      }
    } catch (e) {
      
      showErrorSnackbar(message: e.toString());
      showErrorSnackbar(message: 'Failed to submit a new Punch request');
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

      if (!(fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'pdf')) {
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
  DateTime? toDate;        // Date selected in "To"
  String? validationMessage; // To hold the validation message
  int? selectedDays; // To hold the number of days selected

 Future<void> selectLeaveFromDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: leaveFromDate ?? DateTime.now(), // Default to today if no date selected
    firstDate: DateTime(2018, 1, 1), // Earliest selectable date
    lastDate: DateTime(2100), // Allow selecting any future date
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.green, // Selection color
            onPrimary: Colors.white, // Text color inside the selected date circle
            surface: Colors.white, // Background color of the date picker
            onSurface: Colors.black, // Text color for dates
          ),
          dialogBackgroundColor: Colors.white, // Background color of the dialog
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
    initialDate: toDate ?? DateTime.now(), // Default to today if no date selected
    firstDate: DateTime(2018, 1, 1), // Earliest selectable date
    lastDate: DateTime(2100), // Allow selecting any future date
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.green, // Selection color
            onPrimary: Colors.white, // Text color inside the selected date circle
            surface: Colors.white, // Background color of the date picker
            onSurface: Colors.black, // Text color for dates
          ),
          dialogBackgroundColor: Colors.white, // Background color of the dialog
        ),
        child: child!,
      );
    },
  );

  if (picked != null && picked != toDate) {
    toDate = picked;

     // Validation: Check if "To" date precedes "Leave From" date
    if (leaveFromDate != null && toDate!.isBefore(leaveFromDate!)) {
      validationMessage = 'To Date precedes From-date'; // Set validation message
    } else {
      validationMessage = null; // Clear validation message if valid
    }
  }
  updateSelectedDays(); // Call function to update selected days after date change
  update(); // Update UI
}

// Function to calculate and update the selected days
void updateSelectedDays() {
  if (leaveFromDate != null && toDate != null && validationMessage == null) {
    // Calculate the difference in days and add 1 to include both dates
    selectedDays = toDate!.difference(leaveFromDate!).inDays + 1;
  } else {
    selectedDays = null; // Reset if dates are invalid
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
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  'Are you sure you want to delete this document?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF212121),
                    fontFamily: 'Satoshi',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.4, // 140% line height
                  ),
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    removeFile(index);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFFA5B5B),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: Text(
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
                SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    // Handle 'No, go back' action
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(
                        color: Color(0xFF3BBCA0),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: Color(0xFF3BBCA0),
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