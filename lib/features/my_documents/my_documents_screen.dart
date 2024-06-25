import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:nms/utils/theme/theme_constants.dart';
import 'package:get/get.dart';

import '../../widgets/cornered_button.dart';
import 'my_documents_controller.dart';

class MyDocumentsScreen extends StatefulWidget {
  MyDocumentsScreen({super.key});

  @override
  State<MyDocumentsScreen> createState() => _MyDocumentsScreenState();
}

class _MyDocumentsScreenState extends State<MyDocumentsScreen> {
   bool isSearching = false;

  final List<Map<String, String>> documents = [
    {'name': 'Ryan_resume2023.pdf', 'date': '05 Jan 22', 'category': 'Personal'},
    {'name': 'Offerletter2023.pdf', 'date': '03 Jan 22', 'category': 'Work'},
    {'name': 'Medicalcertificate.pdf', 'date': '03 Jan 22', 'category': 'Medical'},
    {'name': 'untitled.pdf', 'date': '02 Jan 22', 'category': 'Others'},
    {'name': 'DegreeCertificate.pdf', 'date': '02 Jan 22', 'category': 'Academic'},
    {'name': '12thclass.pdf', 'date': '02 Jan 22', 'category': 'Academic'},
  ];

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
        title: Text('Team Listing'),
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
                preferredSize: Size.fromHeight(60.0),
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
                              border: Border.all(color: Color(0xFFB7B7B7)),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              children: [
                                Icon(Icons.search, color: Colors.grey),
                                SizedBox(width: 8.0),
                                Text('My Documents', style: TextStyle(color: Colors.grey)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          height: 48.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            border: Border.all(color: Color(0xFFB7B7B7)),
                          ),
                          padding: EdgeInsets.all(8.0),
                          child: Image.asset('assets/png/slider.png'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : null,
      ),
          body: controller.listEmployeDocuments != null ?
          ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: ListTile(
                  leading: IconButton(
          icon: Image.asset('assets/png/document.png'),
          onPressed: () {
          },
        ),
                  title: Text(documents[index]['name']!),
                  subtitle: Row(
                    children: [
                      Text(documents[index]['date']!),
                      SizedBox(width: 10.0),
                      CircleAvatar(
                        radius: 2.0,
                        backgroundColor: Color(0xFFE3E3E3),
                      ),
                      SizedBox(width: 5.0),
                      Text(documents[index]['category']!),
                    ],
                  ),
                  trailing: IconButton(
          icon: Image.asset('assets/png/download.png'),
          onPressed: () {
          },
        ),
                  tileColor: Color(0xFFFAFAFA),
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
            child: Icon(Icons.add),
            backgroundColor: Color(0xFF3BBCA0),
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
  @override
  _AddDocumentBottomSheetState createState() => _AddDocumentBottomSheetState();
}

class _AddDocumentBottomSheetState extends State<AddDocumentBottomSheet> {
  List<PlatformFile> _files = [];
  String? _selectedCategory;
  final List<String> _categories = ['Personal', 'Academic', 'Work', 'Medical', 'Others'];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDocumentsController>(
      init: MyDocumentsController(),
      builder: (controller) {
        return Padding(
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
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF7A7A7A),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
                Text(
                  'Add document',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10.0),
                Divider(
                  color: Color(0xFFF1F1F1),
                  thickness: 1.0,
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Category *',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 8.0),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  hint: Text('Select'),
                  items: _categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide(
                        color: Color(0xFFB7B7B7),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Add File',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: _files.length == 3 ? Colors.grey.shade400 : Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
        
                ElevatedButton.icon(
                  onPressed: _files.length == 3 ? null : _pickFiles,
                  icon: Icon(Icons.upload_file),
                  label: Text('Choose File'),
                  style: ElevatedButton.styleFrom(
                    // primary: Color(0xFFF1F1F1),
                    // onPrimary: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'JPEG, JPG or PDF, file size no more than 5MB',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: _files.length == 3 ? Colors.grey.shade400 : Color(0xFF7A7A7A),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                _buildFileList(),
                SizedBox(height: 10.0),
        
                CorneredButton(
                        height: 35,
                        color: primaryColor,
                        title: 'Submit',
                        textcolor: backgroundColor,
                        onPress: () async {},
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
                SizedBox(height: 20.0),
              ],
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
          margin: EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text(_files[index].name),
            trailing: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => _removeFile(index),
            ),
          ),
        );
      },
    );
  }
}