// import 'dart:io';

// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:medical_trade/controller/add_others_post_api.dart';
// import 'package:medical_trade/diagnostic_module/utils/whats_up_fab.dart';
// import 'package:medical_trade/utilities/custom_appbar.dart';
// import 'package:medical_trade/utilities/custom_message.dart';
// import 'package:medical_trade/utilities/custom_textfrom_field_two.dart';
// import 'package:medical_trade/utilities/values_manager.dart';
// import 'package:provider/provider.dart';

// class OthersView extends StatefulWidget {
//   const OthersView({super.key});

//   @override
//   State<OthersView> createState() => _OthersViewState();
// }

// class _OthersViewState extends State<OthersView> {
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _phoneNoController = TextEditingController();
//   final TextEditingController _addressController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();

//   File? _selectedImage;

//   // ✅ Image Picker Function
//   Future<void> pickImage() async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: ImageSource.camera);

//     if (pickedFile != null) {
//       setState(() {
//         _selectedImage = File(pickedFile.path);
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final addOthersProvider = Provider.of<AddOthersProvider>(context);
//     return Scaffold(
//       appBar: CustomAppBar(
//         onTap: () {
//           Navigator.pop(context);
//         },
//         title: "Others",
//       ),
//       floatingActionButton: const WhatsAppFAB(phone:  "8801711781111"),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 10.h),
//               child: FadeInUp(
//                 duration: const Duration(milliseconds: 1300),
//                 child: Card(
//                   elevation: 5,
//                   child: Container(
//                     width: double.infinity.w,
//                     decoration: BoxDecoration(
//                       color: const Color.fromARGB(255, 176, 223, 230),
//                       borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.only(right: 8.w, top: 4.h, bottom: 4.h),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 6.h),
//                           Stack(
//                             alignment: Alignment.bottomRight,
//                             children: [
//                               CircleAvatar(
//                                 radius: 60.r,
//                                 backgroundColor: Colors.white,
//                                 backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
//                                 child: _selectedImage == null
//                                     ? Icon(
//                                         Icons.person,
//                                         size: 50.sp,
//                                         color: Colors.grey,
//                                       )
//                                     : null,
//                               ),

//                               // 📷 Camera / Image Button
//                               Positioned(
//                                 bottom: 5,
//                                 right: 5,
//                                 child: GestureDetector(
//                                   onTap: pickImage,
//                                   child: Container(
//                                     height: 25.h,
//                                     width: 25.w,
//                                     decoration: BoxDecoration(
//                                       color: Colors.blue.shade900,
//                                       shape: BoxShape.circle,
//                                     ),
//                                     child: Icon(
//                                       Icons.camera_alt,
//                                       color: Colors.white,
//                                       size: 14.sp,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           CustomTextFromfieldTwo(
//                             controller: _nameController,
//                             keyboardType: TextInputType.text,
//                             hintText: "Name",
//                             title: "Name",
//                           ),
//                           SizedBox(height: 4.0.h),
//                           CustomTextFromfieldTwo(
//                             keyboardType: TextInputType.number,
//                             controller: _phoneNoController,
//                             hintText: "Enter Mobile Number",
//                             title: "Mobile",
//                           ),
//                           SizedBox(height: 4.0.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 10.w),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "Address",
//                                       style: TextStyle(color: Colors.black,fontSize: 14.sp),
//                                       textAlign: TextAlign.end,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 4.w),
//                               Text(":  ", style: TextStyle(color: Colors.black,fontSize: 16.sp)),
//                               Expanded(
//                                 flex: 8,
//                                 child: TextFormField(
//                                   controller: _addressController,
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: 2,
//                                   style: TextStyle(fontSize: 12.sp),
//                                   decoration: InputDecoration(
//                                     hintText: "Enter Address",
//                                     hintStyle: TextStyle(fontSize: 12.sp,color: Colors.grey[500]),
//                                     contentPadding: EdgeInsets.symmetric(vertical: 7.h,horizontal: 8.w),
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.circular(AppSize.s8.r),
//                                     ),
//                                     isDense: true,
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 4.0.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Expanded(
//                                 flex: 5,
//                                 child: Padding(
//                                   padding: EdgeInsets.only(left: 10.w),
//                                   child: Align(
//                                     alignment: Alignment.centerLeft,
//                                     child: Text(
//                                       "Description",
//                                       style: TextStyle(color: Colors.black,fontSize: 14.sp),
//                                       textAlign: TextAlign.end,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(width: 4.w),
//                               Text(":  ", style: TextStyle(color: Colors.black,fontSize: 16.sp)),
//                               Expanded(
//                                 flex: 8,
//                                 child: TextFormField(
//                                   controller: _descriptionController,
//                                   keyboardType: TextInputType.multiline,
//                                   maxLines: 4,
//                                   style: TextStyle(fontSize: 12.sp),
//                                   decoration: InputDecoration(
//                                     hintText: "Enter Description",
//                                     hintStyle: TextStyle(fontSize: 12.sp,color: Colors.grey[500]),
//                                     contentPadding: EdgeInsets.symmetric(vertical: 7.h,horizontal: 8.w),
//                                     border: OutlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.circular(AppSize.s8.r),
//                                     ),
//                                     isDense: true,
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 4.0.h),
//                           Align(
//                             alignment: AlignmentDirectional.centerEnd,
//                             child: InkWell(
//                               onTap: () async {
//                                 if (_nameController.text.isEmpty ||
//                                     _phoneNoController.text.isEmpty ||
//                                     _descriptionController.text.isEmpty ||
//                                     _addressController.text.isEmpty) {
//                                   CustomToast.show(
//                                       context: context,
//                                       text: "Please fill all fields",
//                                       isSuccess: false);
//                                   return;
//                                 }
//                                 await addOthersProvider.addOtherEntry(
//                                   name: _nameController.text,
//                                   mobile: _phoneNoController.text,
//                                   address: _addressController.text,
//                                   context: context,
//                                   description: _descriptionController.text,
//                                   imageFile: _selectedImage, 
//                                   onSuccess: () {
//                                     _nameController.clear();
//                                     _phoneNoController.clear();
//                                     _addressController.clear();
//                                     _descriptionController.clear();
//                                     setState(() {
//                                       _selectedImage = null;
//                                     });
//                                   },
//                                 );
//                               },
//                               child: Container(
//                                 height: 25.h,
//                                 width: 60.w,
//                                 decoration: BoxDecoration(
//                                   color: Colors.blue.shade900, 
//                                   borderRadius: BorderRadius.circular(AppSize.s8.r),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Colors.black.withOpacity( 0.25), 
//                                       offset: const Offset(0,4),
//                                       blurRadius: 8.0, 
//                                       spreadRadius: 1.0, 
//                                     ),
//                                   ],
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 6.h),
//                                 child: Center(
//                                   child: addOthersProvider.isLoading
//                                     ? SizedBox(
//                                         width: 15.w,
//                                         height: 15.h,
//                                         child: CircularProgressIndicator(
//                                           color: Colors.white,
//                                           strokeWidth: 2.0.w,
//                                         ),
//                                       )
//                                     : Text(
//                                         "Send",
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.bold,
//                                         ),
//                                       ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_trade/controller/add_others_post_api.dart';
import 'package:medical_trade/controller/get_client_post_api.dart';
import 'package:medical_trade/controller/get_district_api.dart';
import 'package:medical_trade/controller/get_division_api.dart';
import 'package:medical_trade/diagnostic_module/utils/whats_up_fab.dart';
import 'package:medical_trade/model/district_model.dart';
import 'package:medical_trade/model/division_model.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_message.dart';
import 'package:medical_trade/utilities/custom_textfromfield_sales_old_machine.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/view/sales_old_machie_data.dart';
import 'package:provider/provider.dart';

class OthersView extends StatefulWidget {
  const OthersView({super.key});

  @override
  State<OthersView> createState() => _OthersViewState();
}

class _OthersViewState extends State<OthersView> {
  final TextEditingController _machineNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _conditionController = TextEditingController();
  final TextEditingController _originController = TextEditingController();
  final TextEditingController _upazilaController = TextEditingController();
  final TextEditingController _machineDetailsController = TextEditingController();
  final TextEditingController _contactNumberController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  Map<String, String> divisionNameMap = {};
  Map<String, String> districtsNameMap = {};
  Map<String, String> divisionsNameMap = {};
  final List<DistrictModel> _selectedDistricts = [];
  final List<DivisionModel> _selectedDivisions = [];
  File? _selectedImage;

  // ✅ Image Picker Function
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final districtProvider = Provider.of<DistrictProvider>(context, listen: false);
      final divisionProvider = Provider.of<DivisionProvider>(context, listen: false);
      await Future.wait([
        districtProvider.fetchDistricts(),
        divisionProvider.fetchDivisions(),
      ]);
       setState(() {
        divisionNameMap = Map.fromEntries(divisionProvider.divisions.map(
            (division) =>MapEntry(division.id.toString(), division.name)));
      });
      setState(() {
        districtsNameMap = Map.fromEntries(districtProvider.districts.map(
            (district) => MapEntry(district.id.toString(), district.areaName)));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final districtProvider = Provider.of<DistrictProvider>(context);
    final divisionProvider = Provider.of<DivisionProvider>(context);
    return Scaffold(
        appBar: CustomAppBar(
          onTap: () {
            Navigator.pop(context);
          },
          title: "Others",
        ),
        floatingActionButton: const WhatsAppFAB(phone:  "8801711781111"),
        body: SingleChildScrollView(
         child: Column(children: [
          Padding(
            padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 12.h),
            child: FadeInUp(
              duration: const Duration(milliseconds: 1300),
              child: Card(
                elevation: 9,
                child: Container(
                  width: double.infinity.w,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 176, 223, 230),
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 12.h, bottom: 4.h),
                      child: Column(
                       children: [
                        SizedBox(height: 6.h),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 55.r,
                              backgroundColor: Colors.white,
                              backgroundImage: _selectedImage != null ? FileImage(_selectedImage!) : null,
                              child: _selectedImage == null ? Icon(Icons.person,size: 50.sp,color: Colors.grey) : null,
                            ),
                            // 📷 Camera / Image Button
                            Positioned(
                              bottom: 5.h,
                              right: 5.w,
                              child: GestureDetector(
                                onTap: pickImage,
                                child: Container(
                                  height: 25.h,
                                  width: 25.w,
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade900,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        CustomTextfromfieldSalesOldMachine(
                          controller: _machineNameController,
                          hintText: "Enter Machine Name",
                          title: "Machine Name",
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 4.0.h),
                        CustomTextfromfieldSalesOldMachine(
                          controller: _contactNumberController,
                          hintText: "Enter Contact Number",
                          title: "Contact Number",
                          keyboardType: TextInputType.number,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Division",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            SizedBox(
                              width: 4.w,
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: Colors.black,width: 0.5.w),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (_selectedDivisions.isNotEmpty)
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                  _selectedDivisions.map((division) => division.name).join(', '),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14.sp,
                                                      color: Colors.black),
                                                  overflow: TextOverflow.ellipsis, 
                                                ),
                                              ),
                                            ),
                                          TypeAheadField<DivisionModel>(
                                            controller: _divisionController,
                                            builder: (context, controller, focusNode) {
                                              return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(top: 2.h, bottom: 4.h, left: 8.0.w),
                                                  hintText: 'Select Divisions',
                                                  isDense: true,
                                                  hintStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[500],
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                            suggestionsCallback: (pattern) {
                                              return divisionProvider.searchDivisions(pattern);
                                            },
                                            itemBuilder: (context, DivisionModel suggestion) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                                child: Text(
                                                  suggestion.name,
                                                  style: TextStyle(fontSize: 14.sp),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              );
                                            },
                                            onSelected: (DivisionModel suggestion) {
                                              setState(() {
                                                if (_selectedDivisions.contains(suggestion)) {
                                                  _selectedDivisions.remove(suggestion);
                                                } else {
                                                  _selectedDivisions.add(suggestion);
                                                }
                                                _divisionController.clear();
                                              });
                                            },
                                            decorationBuilder: (context, child) => Material(
                                              elevation: 4,
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8.r),
                                              child: child,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "District",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            SizedBox(
                              width: 4.w,
                              child: Text(
                                ":",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              flex: 8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0.r),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 0.5.w, 
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          if (_selectedDistricts.isNotEmpty)
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                                              child: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                  _selectedDistricts.map((district) =>district.areaName).join(', '),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                  ),
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          TypeAheadField<DistrictModel>(
                                            controller: _districtController,
                                            builder: (context, controller, focusNode) {
                                              return TextField(
                                                controller: controller,
                                                focusNode: focusNode,
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.only(top: 2.h, bottom: 4.h, left: 8.0.w),
                                                  hintText: 'Select District',
                                                  isDense: true,
                                                  hintStyle: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[500],
                                                  ),
                                                  filled: true,
                                                  fillColor: Colors.white,
                                                  border: InputBorder.none,
                                                ),
                                              );
                                            },
                                            suggestionsCallback: (pattern) {
                                              return districtProvider.searchDistricts(pattern);
                                            },
                                            itemBuilder: (context, DistrictModel suggestion) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                                child: Text(
                                                  suggestion.areaName,
                                                  style: TextStyle(fontSize: 14.sp),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              );
                                            },
                                            onSelected: (DistrictModel suggestion) {
                                              setState(() {
                                                if (_selectedDistricts.contains(suggestion)) {
                                                  _selectedDistricts.remove(suggestion);
                                                } else {
                                                  _selectedDistricts.add(suggestion);
                                                }
                                                _districtController.clear();
                                              });
                                            },
                                            decorationBuilder: (context, child) => Material(
                                              elevation: 4,
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8.r),
                                              child: child,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 4.h),
                        CustomTextfromfieldSalesOldMachine(
                          controller: _upazilaController,
                          hintText: "Enter Upazila",
                          title: "Upazila",
                          keyboardType: TextInputType.text,
                        ),

                        SizedBox(
                          height: 4.h,
                        ),
                        CustomTextfromfieldSalesOldMachine(
                          controller: _priceController,
                          hintText: "Enter Price",
                          title: "Price",
                          keyboardType: TextInputType.text,
                        ),

                        SizedBox(
                          height: 4.h,
                        ),
                        CustomTextfromfieldSalesOldMachine(
                          controller: _modelController,
                          hintText: "Enter Model",
                          title: "Model",
                          keyboardType: TextInputType.text,
                        ),

                        SizedBox(
                          height: 4.h,
                        ),
                        CustomTextfromfieldSalesOldMachine(
                          controller: _conditionController,
                          hintText: "Enter Condition",
                          title: "Condition",
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 4.h),
                        CustomTextfromfieldSalesOldMachine(
                          controller: _originController,
                          hintText: "Enter Origin",
                          title: "Origin",
                          keyboardType: TextInputType.text,
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                "Machine Details",
                                style: TextStyle(
                                    fontSize: 14.0.sp,
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                            SizedBox(
                              width: 4.w,
                            ),
                            SizedBox(
                              width: 4.w,
                              child: Text(":",
                                style: TextStyle(color: Colors.black, fontSize: 16.sp),
                              ),
                            ),
                            SizedBox(
                              width: 12.w,
                            ),
                            Expanded(
                              flex: 8,
                              child: Container(
                                height: 50.0.h,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0.r),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 0.5.w, 
                                  ),
                                ),
                                child: TextFormField(
                                  controller: _machineDetailsController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: "Machine Details",
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
                        SizedBox(height: 4.0.h),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: InkWell(
                            onTap: () async {
                              if (_machineNameController.text.isEmpty ||
                                  _contactNumberController.text.isEmpty ||
                                  _selectedDivisions.isEmpty ||
                                  _selectedDistricts.isEmpty ||
                                  _priceController.text.isEmpty ||
                                  _modelController.text.isEmpty ||
                                  _upazilaController.text.isEmpty ||
                                  _conditionController.text.isEmpty ||
                                  _originController.text.isEmpty ||
                                  _machineDetailsController.text.isEmpty) {
                                CustomToast.show(
                                  context: context,
                                  text:"Please fill in all the required fields.",
                                  isSuccess: false,
                                );
                                return;
                              }
                              List<String> selectedDivisionIds = _selectedDivisions.map((division) => division.id.toString()).toList();
                              List<String> selectedDistrictIds = _selectedDistricts.map((district) => district.id.toString()).toList();
                              await context.read<AddOthersPostApi>().othersPostData(
                                    context: context,
                                    machineName: _machineNameController.text,
                                    price: _priceController.text,
                                    model: _modelController.text,
                                    condition: _conditionController.text,
                                    origin: _originController.text,
                                    upazila: _upazilaController.text,
                                    selectedDivisions: selectedDivisionIds,
                                    selectedDistricts: selectedDistrictIds,
                                    mobile: _contactNumberController.text,
                                    description: _machineDetailsController.text,
                                    image: _selectedImage,
                                    onSuccess: () {
                                      _machineNameController.clear();
                                      _priceController.clear();
                                      _upazilaController.clear();
                                      _modelController.clear();
                                      _conditionController.clear();
                                      _contactNumberController.clear();
                                      _machineDetailsController.clear();
                                      _originController.clear();
                                      _machineDetailsController.clear();
                                      _selectedDistricts.clear();
                                      _selectedDivisions.clear();
                                      _selectedImage = null;
                                    },
                                  );
                            },
                            child: Container(
                              height: 25.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade900,
                                borderRadius:
                                    BorderRadius.circular(AppSize.s8.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: const Offset(0, 4),
                                    blurRadius: 8.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(vertical: 6.h),
                              child: Center(
                                child: context
                                        .watch<GetClientPostProvider>()
                                        .isLoading
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
                      ])),
                ),
              ),
            ),
          ),
          SizedBox(height: 100.h),
          const SalesOldMachieData()
        ])));
  }
}