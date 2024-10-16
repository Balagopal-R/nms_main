import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:nms/dtos/nms_dtos/delete_file_by_name_dtos/delete_file_by_name.dart';
import 'package:nms/dtos/nms_dtos/file_download_dtos/file_download_request.dart';
import 'package:nms/managers/sharedpreferences/sharedpreferences.dart';
import 'package:nms/mixins/snackbar_mixin.dart';
import 'package:nms/models/documents_list_model/documensts_list_model.dart';
import 'package:nms/models/file_upload_model/file_upload_model.dart';
import 'package:nms/repository/api_repository.dart';
import 'package:nms/utils/helpers/validation.dart';
import 'package:nms/utils/theme/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../dtos/nms_dtos/documents_list_dtos/documents_list_request.dart';
import '../../dtos/nms_dtos/file_upload_dtos/file_upload.dart';

class MyDocumentsController extends GetxController with SnackbarMixin {
  var uploadedImageMessage = "".obs;

  // late File? imageFile = null;
  // late String? imageName = null;
  // late double? imageSize = null;

  var isCategoryValid = true.obs;
  var selectedCategory = ''.obs;
  var category = [
    'PROFILE_IMAGE',
    'PERSONAL',
    'ACADEMIC',
    'WORK',
    'MEDICAL',
    'OTHERS'
  ];

  List<PlatformFile> files = [];

  void validateForm() {
    isCategoryValid.value = selectedCategory.isNotEmpty;
  }

  void clearFields() {
    selectedCategory.value = '';
  }

  static const _pageSize = 10;
  final PagingController<int, DocumentsListModel> pagingController =
      PagingController(firstPageKey: 0);

  final _uploadedImagevalue = (List<String>.empty(growable: true)).obs;
  List<String> get uploadedImagevalue => _uploadedImagevalue.value;

  final _listEmployeDocuments = (List<DocumentsListModel>.empty()).obs;
  List<DocumentsListModel> get listEmployeDocuments => _listEmployeDocuments;

  final _employeDocumentDetails = (List<Map<String, String>>.empty()).obs;
  List<Map<String, String>> get employeDocumentDetails =>
      _employeDocumentDetails;

  final _userFileUpload = Rx<FileUploadModel?>(null);
  FileUploadModel? get userFileUpload => _userFileUpload.value;

  final _extractedFirstPart = "".obs;
  String get extractedFirstPart => _extractedFirstPart.value;

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) {
      listUserDocumentsPagination(pageKey);
    });
    // Trigger the initial page load
    pagingController.refresh();
    super.onInit();
    requestStoragePermission();
  }

  Future<void> requestStoragePermission() async {
    // Requesting MANAGE_EXTERNAL_STORAGE for Android 10+
    if (await Permission.manageExternalStorage.request().isGranted) {
      // Permission granted for Android 10+
      debugPrint("Manage External Storage Permission Granted");
    } else if (await Permission.storage.request().isGranted) {
      // Permission granted for Android 9 and below
      debugPrint("Storage Permission Granted");
    } else {
      // Handle permission denial
      debugPrint("Storage Permission Denied");
    }
  }

  String epochTimeToFormattedDate(int epochTime) {
    // Convert epoch time to DateTime object
    final dateTime = DateTime.fromMillisecondsSinceEpoch(epochTime);

    // Use DateFormat to format the date string
    final formattedDate = DateFormat('dd MMM yy').format(dateTime);

    return formattedDate;
  }

  String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;

    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  //  list uploaded user documents with Pagination
  Future<void> listUserDocumentsPagination(int pageKey) async {
    try {
      final authService = NMSJWTDecoder();
      final decodedToken = await authService.decodeAuthToken();
      if (decodedToken != null) {
        final userId = decodedToken["userId"];

        final request = DocumentsListRequest(
          field: "",
          sortOfOrder: "",
          page: pageKey,
          size: _pageSize,
          userId: userId,
        );

        final response = await ApiRepository.to.listDocuments(request: request);

        if (response.status == 200) {
          final isLastPage = response.pagination?.totalPages == pageKey;
          if (isLastPage) {
            pagingController.appendLastPage(response.data);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(response.data, nextPageKey);
          }
          // pagingController.appendPage(response.data , pageKey+1);
          _listEmployeDocuments.addAll(response.data);
          update();
        } else if (response.message == "Failed") {
          debugPrint(response.errors['errorMessage']);
          showErrorSnackbar(message: errorOccuredText);
          update();
        }
      }
    } catch (e) {
      pagingController.error = e.toString();
      update();
      return catchErrorSection(e);
    }
  }

  catchErrorSection(e) async {
    debugPrint('error-----${e.toString()}------');

    if (e.toString().isNotEmpty) {
      try {
        Map<String, dynamic> errorResponse = jsonDecode(e.toString());

        if (errorResponse.containsKey("errors")) {
          Map<String, dynamic> errors =
              Map<String, dynamic>.from(errorResponse["errors"]);
          if (errors.containsKey("errorMessage")) {
            String errorMessage = errors["errorMessage"];

            if (errorMessage.contains("Bad Credentials")) {
              debugPrint('error');
            }

            return;
          }
        }
      } catch (e) {
        debugPrint('Error decoding JSON: ${e.toString()}');
        showErrorSnackbar(
          message: e.toString(),
        );
        return e.toString();
      }
    }
  }

  Future<void> uploadFiles(
      List<PlatformFile> files, BuildContext context) async {
    for (var file in files) {
      await uploadImage(file, context);
    }
  }

  // upload image api function
  Future<void> uploadImage(PlatformFile imageFile, BuildContext context) async {
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
            // category: 'PERSONAL',
            category: selectedCategory.value);

        final response = await ApiRepository.to.fileUpload(request: request);

        if (response.status == 200) {
          _userFileUpload.value = response.data;
          showSuccessSnackbar(
              title: 'Success', message: 'File Upload Successfully');
          await Future.delayed(const Duration(seconds: 5));
          Navigator.pop(context);
          onInit();

        }
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      uploadedImageMessage.value = defaultMessage;
      debugPrint(e.toString());
    }
  }

  deleteFileByName(String name) async {
    // _isLoading.value = true;
    try {
      final request = DeleteFileByNameRequest(fileName: name);
      final response =
          await ApiRepository.to.deleteFileByName(request: request);
      if (response.status == 200) {
        // _categoryTypeListModelData.value = response.data;
        debugPrint("length is ${response.message}");
        uploadedImagevalue.remove(name);

        update();

        debugPrint("success ");
      } else {
        // _isLoading.value = false;
        debugPrint("Error");
      }
    } catch (e) {
      showErrorSnackbar(message: e.toString());
      // _isLoading.value = false;
      debugPrint(e.toString());
    }
  }

  Future<void> downloadFile(String fileName) async {
    await requestStoragePermission();
    try {
      final request = FileDownloadRequest(fileName: fileName);
      final response = await ApiRepository.to.fileDownload(request: request);

      print(response.toString());
      showSuccessSnackbar(
          title: 'Success', message: 'File Downloaded Successfully');
    } catch (e) {
      update();
      return catchErrorSection(e);
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
                        color: backgroundColor,
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
