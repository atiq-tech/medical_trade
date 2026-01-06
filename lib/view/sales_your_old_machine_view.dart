import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
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

class SalesYourOldMachineView extends StatefulWidget {
  const SalesYourOldMachineView({super.key});

  @override
  State<SalesYourOldMachineView> createState() => _SalesYourOldMachineViewState();
}

class _SalesYourOldMachineViewState extends State<SalesYourOldMachineView> {
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
  final List<XFile> _imagesList = [];
  void _pickImage() async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Text("Select Image Option"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
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
                    _imagesList.add(photo);
                  });
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
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
    print("Image _imagesList: ${_imagesList}");
    return Scaffold(
        appBar: CustomAppBar(
          onTap: () {
            Navigator.pop(context);
          },
          title: "Sales Your Machine",
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
                    border: Border.all(color: const Color(0xFF2F6E9E), width: 0.5.w),
                    color: const Color.fromARGB(255, 173, 209, 174),
                    borderRadius: BorderRadius.all(Radius.circular(AppSize.s12.r)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.25),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                      padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 12.h, bottom: 4.h),
                      child: Column(children: [
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
                          _imagesList.isEmpty ? SizedBox() : Padding(
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
                                            file, 
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
                              List<File> images = _imagesList.map((e) => File(e.path)).toList();
                              await context
                                  .read<GetClientPostProvider>()
                                  .clientPostData(
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
                                    images: images,
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
                                      _imagesList.clear(); 
                                      setState(() {});
                                    },
                                  );
                            },
                            child: Container(
                              height: 30.h,
                              width: 60.w,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 34, 139, 34),
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
