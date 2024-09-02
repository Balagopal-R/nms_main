import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nms/models/documents_list_model/documensts_list_model.dart';
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
                icon: Image.asset('assets/png/arrow_left.png',
                    height: 24, width: 24),
                onPressed: () {
                  Get.back();
                },
              ),
              title: const Text('My Documents'),
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Image.asset(isSearching
                      ? 'assets/png/cross.png'
                      : 'assets/png/search.png'),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: 48.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4.0),
                                    border: Border.all(
                                        color: const Color(0xFFB7B7B7)),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: const Row(
                                    children: [
                                      Icon(Icons.search, color: Colors.grey),
                                      SizedBox(width: 8.0),
                                      Text('My Documents',
                                          style: TextStyle(color: Colors.grey)),
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
                                  border: Border.all(
                                      color: const Color(0xFFB7B7B7)),
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
            body: PagedListView<int, DocumentsListModel>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<DocumentsListModel>(
                itemBuilder: (context, item, index) => Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 10.0),
                  child: ListTile(
                    leading: IconButton(
                      icon: SvgPicture.asset('assets/svg/document.svg'),
                      iconSize: 15,
                      onPressed: () {},
                    ),
                    title: Text(item.displayName),
                    subtitle: Row(
                      children: [
                        Text(controller
                            .epochTimeToFormattedDate(item.createdAt)),
                        const SizedBox(width: 10.0),
                        const CircleAvatar(
                          radius: 2.0,
                          backgroundColor: Color(0xFFE3E3E3),
                        ),
                        const SizedBox(width: 5.0),
                        Text(controller.capitalizeFirstLetter(item.category)),
                      ],
                    ),
                    trailing: IconButton(
                      icon: SvgPicture.asset('assets/svg/download.svg'),
                      onPressed: () {
                        controller.downloadFile(item.fileName);
                      },
                    ),
                    tileColor: const Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ),
                firstPageErrorIndicatorBuilder: (context) => Center(
                  child: Text('Error occurred, please try again.'),
                ),
                noItemsFoundIndicatorBuilder: (context) => Center(
                  child: Text('No Documents found.'),
                ),
                newPageProgressIndicatorBuilder: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                controller.clearFields();
                _showBottomSheet(context);
              },
              backgroundColor: const Color(0xFF3BBCA0),
              child: const Image(
                image: AssetImage('assets/png/plus.png'),
              ),
            ),
          );
        });
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
  // List<PlatformFile> _files = [];

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
                      width: 80,
                      height: 4,
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF7A7A7A),
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    const Text(
                      'Add Document',
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
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
                        style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff7A7A7A)),
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    Obx(
                      () => DropdownButtonFormField2<String>(
                        iconStyleData:const IconStyleData(icon: const SizedBox()),
                        
                        dropdownStyleData: DropdownStyleData(
                          maxHeight: 150
                        ),
                        menuItemStyleData: MenuItemStyleData(),

                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(0),
                          errorText: controller.isCategoryValid.value
                              ? null
                              : 'Please select Category',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                const BorderSide(color: Color(0xFFB7B7B7)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                const BorderSide(color: Color(0xFFB7B7B7)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:
                                const BorderSide(color: Color(0xFF3BBCA0)),
                          ),
                          filled: true,
                          fillColor: const Color(0xFFFFFFFF),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Image.asset(
                              'assets/png/arrow_down.png', // Replace with your asset path
                              height: 24,
                              width: 24,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Select',
                            style: TextStyle(fontSize: 16.0,fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,color: Color(0xffB7B7B7)),
                          ),
                        ),
                        items: controller.category
                            .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 2.0),
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: controller.selectedCategory.value.isEmpty
                            ? null
                            : controller.selectedCategory.value,
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
                        // icon: const SizedBox.shrink(), // Hides the default dropdown icon
                        // dropdownColor: Colors.white, // White dropdown menu
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
                          color: controller.files.length == 3
                              ? Colors.grey.shade400
                              : const Color(0xff7A7A7A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    GestureDetector(
                      onTap: controller.files.length == 3
                          ? null
                          : controller.pickFiles,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          color: controller.files.length == 3
                              ? Color(0xFFF1F1F1)
                              : Color(0xFFD9D9D9), // Use theme color
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/png/export.png', // Replace with actual image path
                                width: 24.0, // Adjust icon size as needed
                                height: 24.0, // Adjust icon size as needed
                              ),
                              const SizedBox(
                                  width:
                                      10.0), // Add spacing between icon and text
                              const Text(
                                'Choose File',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
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
                          color: controller.files.length == 3
                              ? Colors.grey.shade400
                              : const Color(0xFF7A7A7A),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    _buildFileList(controller),
                    const SizedBox(height: 10.0),
                    CorneredButton(
                      height: 40,
                      color: primaryColor,
                      title: 'Submit',
                      textcolor: backgroundColor,
                      onPress: () async {
                        controller.validateForm();
                        if (controller.isCategoryValid.value) {
                          await controller.uploadFiles(controller.files, context);
                        }
                      },
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget _buildFileList(MyDocumentsController controller) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: controller.files.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(2.0),
          ),
          child: ListTile(
            leading: const Icon(Icons.insert_drive_file),
            title: Text(controller.files[index].name),
            trailing: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                controller.showCustomDialog(context,index);
              }
            ),
          ),
        );
      },
    );
  }

}
