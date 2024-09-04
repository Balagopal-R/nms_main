import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nms/mixins/snackbar_mixin.dart';

class ApplyLeaveBottomSheetController extends GetxController with SnackbarMixin{

  var isLeaveTypeValid = true.obs;
  var isDurationValid = true.obs;
  final selectedLeaveType = ''.obs;
  final selectedDuration = ''.obs;
    var isCommentValid = true.obs;
  var comment = ''.obs;

  List<PlatformFile> files = [];

  
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


  var leaveTypes = ['Casual', 'Sick', 'Family', 'Vacation'];
  var duration = ['Full Day', 'First half', 'Second half'];

  final FocusNode commentsFocusNode = FocusNode();
  final commentController = TextEditingController();

  void validateForm() {
   isLeaveTypeValid.value = selectedLeaveType.isNotEmpty;
   isDurationValid.value = selectedDuration.isNotEmpty;
   isCommentValid.value = comment.isNotEmpty;
     }

  DateTime selectedDate = DateTime.now().subtract(Duration(days: 1)); // Set initial date to yesterday

  Future<void> selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2018, 1, 1), // Earliest selectable date (you can adjust this)
    lastDate: DateTime.now().subtract(Duration(days: 1)), // Restrict to dates before today
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: Colors.green, // Selection color (e.g., selected date circle)
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

  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
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