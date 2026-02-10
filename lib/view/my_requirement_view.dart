import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:medical_trade/controller/engineering_support_post_api.dart';
import 'package:medical_trade/diagnostic_module/utils/whats_up_fab.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_textfrom_field_two.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:provider/provider.dart';

class MyRequirementView extends StatefulWidget {
  const MyRequirementView({super.key});

  @override
  State<MyRequirementView> createState() => _MyRequirementViewState();
}

class _MyRequirementViewState extends State<MyRequirementView> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

// final List<XFile> _imagesList = [];
// void _pickImage() async {
//   showDialog(
//     context: context,
//     builder: (context) {
//       return AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15),
//         ),
//         title: Text("Select Image Option"),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             ListTile(
//               leading: Icon(Icons.camera_alt),
//               title: Text("Camera"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final XFile? photo = await ImagePicker().pickImage(
//                   source: ImageSource.camera,
//                 );
//                 if (photo != null) {
//                   setState(() {
//                     // _imagesList.clear(); 
//                     _imagesList.add(photo);
//                   });
//                 }
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text("Gallery"),
//               onTap: () async {
//                 Navigator.pop(context);
//                 final pickedFiles = await ImagePicker().pickMultiImage();
//                 if (pickedFiles.isNotEmpty) {
//                   setState(() {
//                     _imagesList.clear();
//                     _imagesList.addAll(pickedFiles);
//                   });
//                 }
//               },
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }

  @override
  Widget build(BuildContext context) {
    final supportProvider = Provider.of<EngineeringSupportProvider>(context);
    return Scaffold(
      appBar: CustomAppBar(
        onTap: () {
          Navigator.pop(context);
        },
        title: "My Requirement",
      ),
      floatingActionButton: const WhatsAppFAB(phone:  "8801711781111"),
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
                      border: Border.all(color: const Color(0xFF2F6E9E), width: 0.5.w),
                      color: const Color.fromARGB(255, 194, 228, 195),
                      borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.w, top: 4.h, bottom: 4.h),
                      child: Column(
                        children: [
                          CustomTextFromfieldTwo(
                            controller: _nameController,
                            keyboardType: TextInputType.text,
                            hintText: "Name",
                            title: "Name",
                          ),
                          SizedBox(height: 4.0.h),
                          CustomTextFromfieldTwo(
                            keyboardType: TextInputType.number,
                            controller: _phoneNoController,
                            hintText: "Enter Mobile Number",
                            title: "Mobile",
                          ),
                          SizedBox(height: 4.0.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Address",
                                      style: TextStyle(color: Colors.black,fontSize: 14.sp),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(":  ", style: TextStyle(color: Colors.black,fontSize: 16.sp)),
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  controller: _addressController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 2,
                                  style: TextStyle(fontSize: 12.sp),
                                  decoration: InputDecoration(
                                    hintText: "Enter Address",
                                    hintStyle: TextStyle(fontSize: 12.sp,color: Colors.grey[500]),
                                    contentPadding: EdgeInsets.symmetric(vertical: 7.h,horizontal: 8.w),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(AppSize.s8.r),
                                    ),
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10.w),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Description",
                                      style: TextStyle(color: Colors.black,fontSize: 14.sp),
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(":  ", style: TextStyle(color: Colors.black,fontSize: 16.sp)),
                              Expanded(
                                flex: 8,
                                child: TextFormField(
                                  controller: _descriptionController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 4,
                                  style: TextStyle(fontSize: 12.sp),
                                  decoration: InputDecoration(
                                    hintText: "Enter Description",
                                    hintStyle: TextStyle(fontSize: 12.sp,color: Colors.grey[500]),
                                    contentPadding: EdgeInsets.symmetric(vertical: 7.h,horizontal: 8.w),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(AppSize.s8.r),
                                    ),
                                    isDense: true,
                                    filled: true,
                                    fillColor: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.0.h),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: InkWell(
                              onTap: () async {
                                // if (_machineNameController.text.isEmpty ||
                                //     _modelController.text.isEmpty ||
                                //     _mobileController.text.isEmpty ||
                                //     _machineDetailsController.text.isEmpty ||
                                //     _originController.text.isEmpty ||
                                //     _imagesList.isEmpty) {
                                //   CustomToast.show(
                                //       context: context,
                                //       text: "Please fill all fields and select images.",
                                //       isSuccess: false);
                                //   return;
                                // }
                                // List<File> images = _imagesList.map((e) => File(e.path)).toList();
                                // await supportProvider.saveSupportData(
                                //   images: images,
                                //   model: _modelController.text,
                                //   origin: _originController.text,
                                //   context: context,
                                //   machineName: _machineNameController.text,
                                //   mobile: _mobileController.text,
                                //   machineDetails:_machineDetailsController.text,
                                //   onSuccess: () {
                                //     _machineNameController.clear();
                                //     _modelController.clear();
                                //     _originController.clear();
                                //     _mobileController.clear();
                                //     _machineDetailsController.clear();
                                //     _imagesList.clear();
                                //     debugPrint("Image list length: ${_imagesList.length}");
                                //   },
                                // );
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
                                        "Send",
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