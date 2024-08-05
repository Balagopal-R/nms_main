import 'package:dotted_border/dotted_border.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nms/utils/theme/app_theme.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:get/get.dart';

import '../../widgets/cornered_button.dart';
import 'my_documents_controller.dart';

class MyDocumentsScreen extends StatefulWidget {
  const MyDocumentsScreen({super.key});

  @override
  State<MyDocumentsScreen> createState() => _MyDocumentsScreenState();
}

class _MyDocumentsScreenState extends State<MyDocumentsScreen> {
   bool isSearching = false;


  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDocumentsController>(
      init: MyDocumentsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
        backgroundColor: Color(0xffFAFAFA),
        leading: IconButton(
          icon: Image.asset('assets/png/arrow_left.png',height: 24,width: 24),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text('My Documents'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Image.asset(isSearching ? 'assets/png/cross.png' : 'assets/png/search.png'),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
          ),
        ],
        bottom: isSearching
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 48.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(color: const Color(0xFFB7B7B7)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8.0),
                            child: const Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('My Documents', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 48.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: const Color(0xFFB7B7B7)),
                          ),
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/png/slider.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
          // ignore: unnecessary_null_comparison
          body: controller.listEmployeDocuments != null ?
          ListView.builder(
            itemCount: controller.listEmployeDocuments.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: ListTile(
                  leading: IconButton(
          icon: Image.asset('assets/png/document.png'),
          onPressed: () {
          },
        ),
                  title: Text(controller.listEmployeDocuments[index].displayName),
                  subtitle: Row(
                    children: [
                      Text(controller.epochTimeToFormattedDate(controller.listEmployeDocuments[index].createdAt)),
                     const SizedBox(width: 10.0),
                     const CircleAvatar(
                        radius: 2.0,
                        backgroundColor: Color(0xFFE3E3E3),
                      ),
                     const SizedBox(width: 5.0),
                      Text(controller.capitalizeFirstLetter(controller.listEmployeDocuments[index].category)),
                    ],
                  ),
                  trailing: IconButton(
          icon: Image.asset('assets/png/download.png'),
          onPressed: () {
            
          },
        ),
                  tileColor: const Color(0xFFFAFAFA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              );
            },
          ) : const Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showBottomSheet(context),
            backgroundColor: const Color(0xFF3BBCA0),
            child: const Image(
    image: AssetImage('assets/png/plus.png'),
  ),
          ),
        );
      }
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return AddDocumentBottomSheet();
      },
    );
  }
}



class AddDocumentBottomSheet extends StatefulWidget {
  const AddDocumentBottomSheet({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDocumentBottomSheetState createState() => _AddDocumentBottomSheetState();
}

class _AddDocumentBottomSheetState extends State<AddDocumentBottomSheet> {
  List<PlatformFile> _files = [];
  
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDocumentsController>(
      init: MyDocumentsController(),
      builder: (controller) {
        return Container(
          decoration: const BoxDecoration(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(16.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.zero,
      bottomRight: Radius.zero,
    ),
    color: Colors.white,
    boxShadow: [
      BoxShadow(
        offset: Offset(0, -5),
        blurRadius: 8.0,
        spreadRadius: -6.0,
        color: Color.fromRGBO(24, 39, 75, 0.08),
      ),
    ],
  ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF7A7A7A),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                  const Text(
                    'Add Document',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w700,color: Colors.black),
                  ),
                  const SizedBox(height: 6.0),
                 const Divider(
                    color: Color(0xFFF1F1F1),
                    thickness: 2.0,
                  ),
                 const SizedBox(height: 12.0),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Category *',
                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400,color: Color(0xff7A7A7A)),
                    ),
                  ),
                  const SizedBox(height: 8.0),
 
           Obx(() => DropdownButtonFormField2<String>(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0),
             errorText: controller.isCategoryValid.value ? null : 'Please select Category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFFB7B7B7)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(color: Color(0xFF3BBCA0)),
            ),
            filled: true,
            fillColor: const Color(0xFFFFFFFF),
          ),
          isExpanded: true,
          hint: const Text(
            'Select',
            style: TextStyle(fontSize: 16),
          ),
          items: controller.category
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ))
              .toList(),
          value: controller.selectedCategory.value.isEmpty ? null : controller.selectedCategory.value,
          validator: (value) {
            if (value == null) {
              return 'Select Category';
            }
            return null;
          },
          onChanged: (value) {
                controller.selectedCategory.value = value!;
                controller.isCategoryValid.value = true;
              },
        ),
    ),
          
          
                  const SizedBox(height: 12.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Add File',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                        color: _files.length == 3 ? Colors.grey.shade400 : const Color(0xff7A7A7A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),

// New Codeeeeeeeeeeeeeeeeeeeeeeeeee Just Borrow

                  // GestureDetector(
                  //                 onTap: () {
                  //                   showModalBottomSheet(
                  //                     context: context,
                  //                     builder: (BuildContext context) {
                  //                       return SafeArea(
                  //                         child: Column(
                  //                           mainAxisSize: MainAxisSize.min,
                  //                           children: <Widget>[
                  //                             ListTile(
                  //                               leading:
                  //                                   const Icon(Icons.camera),
                  //                               title: const Text(
                  //                                   'Take a picture'),
                  //                               onTap: () {
                  //                                 controller.pickImage(
                  //                                     ImageSource.camera);
                  //                                 Navigator.pop(context);
                  //                               },
                  //                             ),
                  //                             ListTile(
                  //                               leading:
                  //                                   const Icon(Icons.image),
                  //                               title: const Text(
                  //                                   'Choose from gallery'),
                  //                               onTap: () {
                  //                                 controller.pickImage(
                  //                                     ImageSource.gallery);
                  //                                 Navigator.pop(context);
                  //                               },
                  //                             ),
                  //                           ],
                  //                         ),
                  //                       );
                  //                     },
                  //                   );
                  //                 },
                  //                 child: 
                  //                 // DottedBorder(
                  //                 //   borderType: BorderType.RRect,
                  //                 //   color: primaryColor,
                  //                 //   strokeWidth: 1,
                  //                 //   dashPattern: const [6, 3, 6, 3],
                  //                 //   radius: const Radius.circular(5),
                  //                 //   child: 
                  //                   Container(
                  //                     height: 38,
                  //                     decoration: BoxDecoration(
                  //                       color: primaryLightColor,
                  //                       borderRadius: BorderRadius.circular(5),
                  //                     ),
                  //                     child: Center(
                  //                         child: Row(
                  //                       mainAxisAlignment:
                  //                           MainAxisAlignment.center,
                  //                       children: [
                  //                         SvgPicture.asset(
                  //                             "assets/svg/cake.svg"),

                  //                         Text("Upload Images",
                  //                             style: AppTheme.lightTheme
                  //                                 .textTheme.headlineSmall
                  //                                 ?.copyWith(
                  //                                     color: primaryColor)),
                                          
                  //                       ],
                  //                     )),
                  //                   ),
                  //                 // ),
                  //               ),
                  //               const SizedBox(
                  //                 height: 15,
                  //               ),
                  //               controller.uploadedImagevalue.isNotEmpty
                  //                   ? Center(
                  //                       child: ListView.separated(
                  //                         shrinkWrap: true,
                  //                         itemCount: controller
                  //                             .uploadedImagevalue.length,
                  //                         separatorBuilder: (context, index) =>
                  //                             const SizedBox(
                  //                           height: 5,
                  //                         ),
                  //                         itemBuilder: (context, index) {
                  //                           return Row(
                  //                             children: [
                  //                               SizedBox(
                  //                                 height: 50,
                  //                                 child: Image.network(
                  //                                   "${controller.extractedFirstPart}${controller.uploadedImagevalue[index]}",
                  //                                   loadingBuilder: (BuildContext
                  //                                           context,
                  //                                       Widget child,
                  //                                       ImageChunkEvent?
                  //                                           loadingProgress) {
                  //                                     if (loadingProgress ==
                  //                                         null) {
                  //                                       return child; // Return the image when it's fully loaded.
                  //                                     } else {
                  //                                       return const Center(
                  //                                         child:
                  //                                             CircularProgressIndicator(
                  //                                           color: primaryColor,
                  //                                         ),
                  //                                       );
                  //                                     }
                  //                                   },
                  //                                   errorBuilder:
                  //                                       (BuildContext context,
                  //                                           Object error,
                  //                                           StackTrace?
                  //                                               stackTrace) {
                  //                                     // Show a red container when image fails to load
                  //                                     return SizedBox(
                  //                                       width: 80,
                  //                                       height: 80,
                  //                                       child: Image.asset(
                  //                                           'assets/images/white_color.png'),
                  //                                     );
                  //                                   },
                  //                                 ),
                  //                               ),
                  //                               Expanded(
                  //                                   child: Column(
                  //                                 children: [
                  //                                   Text(controller
                  //                                           .uploadedImagevalue[
                  //                                       index]),
                  //                                 ],
                  //                               )),
                  //                               GestureDetector(
                  //                                   onTap: () {
                  //                                     controller.deleteFileByName(
                  //                                         controller
                  //                                                 .uploadedImagevalue[
                  //                                             index]);
                  //                                   },
                  //                                   child: const Icon(
                  //                                       Icons.close)),
                  //                             ],
                  //                           );
                  //                         },
                  //                       ),
                  //                     )
                  //                   : const Center(
                  //                       child: Text('No image selected.')),

          
                  ElevatedButton.icon(
                    onPressed: _files.length == 3 ? null : _pickFiles,
                    icon: Image.asset('assets/png/export.png', // Replace with actual image path
              width: 24.0, // Adjust icon size as needed
              height: 24.0, // Adjust icon size as needed
            ),
                    label: const Text('Choose File',style: TextStyle(color: Colors.black,fontSize: 16, fontWeight: FontWeight.w500),),
                    style: ElevatedButton.styleFrom(
                      maximumSize: const Size(double.infinity, 40.0),
                      backgroundColor:  Color(0xFFF1F1F1),
                      // onPrimary: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                  ),
                   const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'JPEG, JPG or PDF, file size no more than 5MB',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: _files.length == 3 ? Colors.grey.shade400 : const Color(0xFF7A7A7A),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  _buildFileList(),
                  const SizedBox(height: 10.0),
          
                  CorneredButton(
                          height: 40,
                          color: primaryColor,
                          title: 'Submit',
                          textcolor: backgroundColor,
                          onPress: () async {
                            controller.validateForm();
                            if (controller.isCategoryValid.value) {
                      
                    await controller.uploadFiles(_files);
                    }
          
                          },
                        ),
          
                  // ElevatedButton(
                  //   onPressed: _files.isNotEmpty ? _submit : null,
                  //   child: Text('Submit'),
                  //   style: ElevatedButton.styleFrom(
                  //     // primary: Color(0xFF3BBCA0),
                  //     // onPrimary: Colors.white,
                  //     minimumSize: Size(double.infinity, 50),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(4.0),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  void _pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result != null) {
      setState(() {
        _files.addAll(result.files);
        if (_files.length > 3) {
          _files = _files.sublist(0, 3); // Limit to 3 files
        }
      });
    }
  }

  void _removeFile(int index) {
    setState(() {
      _files.removeAt(index);
    });
  }

  void _submit() {
    // Implement your submit logic here
  }

  Widget _buildFileList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _files.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: Text(_files[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => _removeFile(index),
            ),
          ),
        );
      },
    );
  }
}