import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_trade/controller/engineering_support_post_api.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_message.dart';
import 'package:medical_trade/utilities/custom_textfrom_field_two.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:provider/provider.dart';

class EngineeringSupport extends StatefulWidget {
  const EngineeringSupport({super.key});

  @override
  State<EngineeringSupport> createState() => _EngineeringSupportState();
}

class _EngineeringSupportState extends State<EngineeringSupport> {
  final TextEditingController _machineNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _machineDetailsController = TextEditingController();

  // final List<XFile> _imagesList = [];
  // void _pickImage() async {
  //   final pickedFiles = await ImagePicker().pickMultiImage();

  //   if (pickedFiles.isNotEmpty) {
  //     setState(() {
  //       _imagesList.clear(); // Clear previous images
  //       for (var pickedFile in pickedFiles) {
  //         _imagesList.add(XFile(pickedFile.path));
  //       }
  //     });
  //   }
  // }

final List<XFile> _imagesList = [];

void _pickImage() async {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Camera"),
              onTap: () async {
                Navigator.pop(context);
                final XFile? photo = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );

                if (photo != null) {
                  setState(() {
                    //_imagesList.clear(); // আগের সব ছবি রিমুভ
                    _imagesList.add(photo);
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery (Multi Image)"),
              onTap: () async {
                Navigator.pop(context);
                final pickedFiles = await ImagePicker().pickMultiImage();

                if (pickedFiles.isNotEmpty) {
                  setState(() {
                    _imagesList.clear();
                    _imagesList.addAll(pickedFiles);
                  });
                }
              },
            ),
          ],
        ),
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    final supportProvider = Provider.of<EngineeringSupportProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: "Engineering Support",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h),
              child: FadeInUp(
                duration: const Duration(milliseconds: 1300),
                child: Card(
                  elevation: 9,
                  child: Container(
                    width: double.infinity.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color(0xFF2F6E9E), width: 0.5.w),
                      color: const Color.fromARGB(255, 194, 228, 195),
                      borderRadius:
                          BorderRadius.all(Radius.circular(AppSize.s12.r)),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.only(right: 8.w, top: 4.h, bottom: 4.h),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
                            child: Center(
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 85.0.w,
                                      height: 85.0.h,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 2.0.w,
                                        ),
                                      ),
                                      child: CircleAvatar(
                                        radius: 30.0.r,
                                        backgroundColor: Colors.white,
                                        child: Padding(
                                          padding: EdgeInsets.all(12.0.r),
                                          child: Image.asset(
                                            "assets/icons/machine.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: Container(
                                        width: 30.0.w,
                                        height: 30.0.h,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                          border: Border.all(
                                            color: Colors.grey,
                                            width: 1.0.w,
                                          ),
                                        ),
                                        child: InkWell(
                                          onTap: _pickImage,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                            size: 16.0.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: SizedBox(
                              height: 80.h,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: _imagesList.length,
                                itemBuilder: (context, index) {
                                  final XFile imageFile = _imagesList[index];
                                  final File file = File(imageFile.path);
                                  return Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          child: Image.file(
                                            file, // Use the images from the list
                                            height: 80.h,
                                            width: 80.w,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) =>
                                                    const Icon(
                                              Icons.error,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: 4.0,
                                          right: 4.0,
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _imagesList.removeAt(index);
                                              });
                                            },
                                            child: Container(
                                              padding: EdgeInsets.all(4.0.r),
                                              decoration: BoxDecoration(
                                                color: Colors.grey.shade100,
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red,
                                                size: 12.0.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                         
                          SizedBox(height: 16.h),
                          CustomTextFromfieldTwo(
                            controller: _machineNameController,
                            keyboardType: TextInputType.name,
                            hintText: "Machine Name",
                            title: "Machine Name",
                          ),
                          SizedBox(height: 4.0.h),
                          CustomTextFromfieldTwo(
                            keyboardType: TextInputType.text,
                            controller: _modelController,
                            hintText: "Model",
                            title: "Model",
                          ),
                          SizedBox(height: 4.0.h),
                          CustomTextFromfieldTwo(
                            keyboardType: TextInputType.text,
                            controller: _originController,
                            hintText: "Origin",
                            title: "Origin",
                          ),
                          SizedBox(height: 4.0.h),
                          CustomTextFromfieldTwo(
                            keyboardType: TextInputType.number,
                            controller: _mobileController,
                            hintText: "Enter Mobile Number",
                            title: "Mobile",
                          ),
                          SizedBox(height: 4.0.h),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 10.w, bottom: 3.h, top: 4.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 5,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Machine Problem",
                                      style: TextStyle(
                                        fontSize: 12.5.sp,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.end,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                SizedBox(
                                  width: 4.w,
                                  child: Text(
                                    ":",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16.sp),
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  flex: 9,
                                  child: Container(
                                    height: 50.0.h,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(5.0.r),
                                      border: Border.all(
                                        color: Colors.grey,
                                        width: 0.5.w, // Set border width here
                                      ),
                                    ),
                                    child: TextFormField(
                                      style: TextStyle(fontSize: 12.sp),
                                      controller: _machineDetailsController,
                                      maxLines: 3,
                                      decoration: InputDecoration(
                                        hintText:"Enter Machine Problem Details",
                                        hintStyle: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.grey[500],
                                        ),
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 5.h,
                                          horizontal: 8.0.w,
                                        ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        isDense: true,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4.0.h),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: InkWell(
                              onTap: () async {
                                // Validate required fields
                                if (_machineNameController.text.isEmpty ||
                                    _modelController.text.isEmpty ||
                                    _mobileController.text.isEmpty ||
                                    _machineDetailsController.text.isEmpty ||
                                    _originController.text.isEmpty ||
                                    _imagesList.isEmpty) {
                                  CustomToast.show(
                                      context: context,
                                      text: "Please fill all fields and select images.",
                                      isSuccess: false);
                                  return;
                                }
                                // Convert _imagesList (XFile) to a list of File
                                List<File> images = _imagesList.map((e) => File(e.path)).toList();
                                // Call the saveSupportData function
                                await supportProvider.saveSupportData(
                                  images: images,
                                  model: _modelController.text,
                                  origin: _originController.text,
                                  context: context,
                                  machineName: _machineNameController.text,
                                  mobile: _mobileController.text,
                                  machineDetails:_machineDetailsController.text,
                                  onSuccess: () {
                                    _machineNameController.clear();
                                    _modelController.clear();
                                    _originController.clear();
                                    _mobileController.clear();
                                    _machineDetailsController.clear();
                                    _imagesList.clear();
                                    debugPrint("Image list length: ${_imagesList.length}");
                                  },
                                );
                              },
                              child: Container(
                                height: 30.h,
                                width: 60.w,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 34, 139, 34), 
                                  borderRadius: BorderRadius.circular(AppSize.s8.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity( 0.25), 
                                      offset: const Offset(0,4),
                                      blurRadius: 8.0, 
                                      spreadRadius: 1.0, 
                                    ),
                                  ],
                                ),
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                child: Center(
                                  child: supportProvider.isLoading
                                      ? SizedBox(
                                          width: 15.w,
                                          height: 15.h,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.0.w,
                                          ),
                                        )
                                      : Text(
                                          "POST",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
