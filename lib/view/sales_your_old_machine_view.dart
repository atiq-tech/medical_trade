import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_trade/controller/get_client_post_api.dart';
import 'package:medical_trade/controller/get_district_api.dart';
import 'package:medical_trade/controller/get_division_api.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/model/district_model.dart';
import 'package:medical_trade/model/division_model.dart';
import 'package:medical_trade/utilities/custom_appbar.dart';
import 'package:medical_trade/utilities/custom_message.dart';
import 'package:medical_trade/utilities/custom_textfromfield_sales_old_machine.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/view/sales_old_machie_data.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_typeahead/flutter_typeahead.dart';

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
                    // _imagesList.clear(); // চাইলে আগের সব মুছতে পারেন
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

// void _pickImage() async {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return SafeArea(
//         child: Wrap(
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
//                     //_imagesList.clear(); // আগের সব ছবি রিমুভ
//                     _imagesList.add(photo);
//                   });
//                 }
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.photo_library),
//               title: Text("Gallery (Multi Image)"),
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

  String? firstPickedDate;
  var backEndFirstDate;
  var backEndSecondtDate;

  var toDay = DateTime.now();
  void _firstSelectedDate() async {
    final selectedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        lastDate: DateTime(2050));
    if (selectedDate != null) {
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(selectedDate);
        backEndFirstDate = Utils.formatBackEndDate(selectedDate);
      });
    }
    else{
      setState(() {
        firstPickedDate = Utils.formatFrontEndDate(toDay);
        backEndFirstDate = Utils.formatBackEndDate(toDay);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    firstPickedDate = Utils.formatFrontEndDate(DateTime.now());
    backEndFirstDate = Utils.formatBackEndDate(DateTime.now());

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final districtProvider = Provider.of<DistrictProvider>(context, listen: false);
      final divisionProvider = Provider.of<DivisionProvider>(context, listen: false);

      // Fetch data
      await Future.wait([
        districtProvider.fetchDistricts(),
        divisionProvider.fetchDivisions(),
      ]);
      // print("fgsdfg v1 1 1 1: ${divisionProvider.divisions}");
      // print("Districts v1 1 1 1: ${districtProvider.districts}");
      // Update divisionsNameMap after fetching divisons
       setState(() {
        divisionNameMap = Map.fromEntries(divisionProvider.divisions.map(
            (division) =>MapEntry(division.id.toString(), division.name)));
      });
      ///===old===
      // setState(() {
      //   divisionNameMap = Map.fromEntries(divisionProvider.divisions.map(
      //       (division) =>MapEntry(division.divisionSlNo, division.divisionName)));
      // });
      // Update districtsNameMap after fetching districts
      setState(() {
        districtsNameMap = Map.fromEntries(districtProvider.districts.map(
            (district) => MapEntry(district.id.toString(), district.areaName)));
      });
      // setState(() {
      //   districtsNameMap = Map.fromEntries(districtProvider.districts.map(
      //       (district) => MapEntry(district.districtSlNo, district.districtName)));
      // });
    });
  }

  @override
  Widget build(BuildContext context) {
    final districtProvider = Provider.of<DistrictProvider>(context);
    final divisionProvider = Provider.of<DivisionProvider>(context);
    //final registerProvider = Provider.of<GetClientPostProvider>(context);
    // print('Districts: ${districtProvider.districts}');
    // print('District Name Map: $districtsNameMap');
    print("Image _imagesList: ${_imagesList}");
    return Scaffold(
        appBar: CustomAppBar(
          onTap: () {
            Navigator.pop(context);
          },
          title: "Sales Your Old Machine",
        ),
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
                         
                      //   Padding(
                      //     padding: EdgeInsets.only(top: 12.h, bottom: 10.h),
                      //     child: Center(
                      //       child: GestureDetector(
                      //         onTap: _pickImage,
                      //         child: Stack(
                      //           clipBehavior: Clip.none,
                      //           children: [
                      //             Container(
                      //               width: 85.0.w,
                      //               height: 85.0.h,
                      //               decoration: BoxDecoration(
                      //                 shape: BoxShape.circle,
                      //                 border: Border.all(
                      //                   color: Colors.grey,
                      //                   width: 2.0.w,
                      //                 ),
                      //               ),
                      //               child: CircleAvatar(
                      //                 radius: 30.0.r,
                      //                 backgroundColor: Colors.white,
                      //                 child: Padding(
                      //                   padding: EdgeInsets.all(12.0.r),
                      //                   child: Image.asset(
                      //                     "assets/icons/machine.png",
                      //                     fit: BoxFit.cover,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //             Positioned(
                      //               bottom: 0,
                      //               right: 0,
                      //               child: Container(
                      //                 width: 30.0.w,
                      //                 height: 30.0.h,
                      //                 decoration: BoxDecoration(
                      //                   shape: BoxShape.circle,
                      //                   color: Colors.white,
                      //                   border: Border.all(
                      //                     color: Colors.grey,
                      //                     width: 1.0.w,
                      //                   ),
                      //                 ),
                      //                 child: InkWell(
                      //                   onTap: _pickImage,
                      //                   child: Icon(
                      //                     Icons.camera_alt,
                      //                     color: Colors.black,
                      //                     size: 16.0.sp,
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      //   ///====my contribute
                      //  _imagesList.isEmpty ? SizedBox() : Padding(
                      //     padding: EdgeInsets.symmetric(horizontal: 12.w),
                      //     child: SizedBox(
                      //       height: 80.h,
                      //       child: ListView.builder(
                      //         scrollDirection: Axis.horizontal,
                      //         itemCount: _imagesList.length,
                      //         itemBuilder: (context, index) {
                      //           final XFile imageFile = _imagesList[index];
                      //           final File file = File(imageFile.path);
                      //           return Padding(
                      //             padding: EdgeInsets.only(right: 10.w),
                      //             child: Stack(
                      //               children: [
                      //                 ClipRRect(
                      //                   borderRadius: BorderRadius.circular(5.r),
                      //                   child: Image.file(
                      //                     file, // Use the images from the list
                      //                     height: 80.h,
                      //                     width: 80.w,
                      //                     fit: BoxFit.cover,
                      //                     errorBuilder:
                      //                         (context, error, stackTrace) =>
                      //                             const Icon(
                      //                       Icons.error,
                      //                     ),
                      //                   ),
                      //                 ),
                      //                 Positioned(
                      //                   top: 4.0,
                      //                   right: 4.0,
                      //                   child: GestureDetector(
                      //                     onTap: () {
                      //                       setState(() {
                      //                         _imagesList.removeAt(index);
                      //                       });
                      //                     },
                      //                     child: Container(
                      //                       padding: EdgeInsets.all(4.0.r),
                      //                       decoration: BoxDecoration(
                      //                         color: Colors.grey.shade100,
                      //                         shape: BoxShape.circle,
                      //                       ),
                      //                       child: Icon(
                      //                         Icons.close,
                      //                         color: Colors.red,
                      //                         size: 12.0.sp,
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ],
                      //             ),
                      //           );
                      //         },
                      //       ),
                      //     ),
                      //   ),
                      //   //end image path

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
                        SizedBox(
                          height: 4.h,
                        ),
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
                            // Start of the widget
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
                                          // Display selected districts as text with a clear icon
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
                                                  overflow: TextOverflow.ellipsis, // Handle overflow if text is too long
                                                ),
                                              ),
                                            ),

                                          // TextField with TypeAhead suggestions
                                          ///=====new myTask TypeAheadField new 
                                          TypeAheadField<DivisionModel>(
                                            controller: _divisionController,
                                            /// TextField builder
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

                                            /// Suggestions callback
                                            suggestionsCallback: (pattern) {
                                              return divisionProvider.searchDivisions(pattern);
                                            },

                                            /// Suggestion list UI
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

                                            /// When a suggestion is selected
                                            onSelected: (DivisionModel suggestion) {
                                              setState(() {
                                                // Toggle selection
                                                if (_selectedDivisions.contains(suggestion)) {
                                                  _selectedDivisions.remove(suggestion);
                                                } else {
                                                  _selectedDivisions.add(suggestion);
                                                }
                                                // Clear the text field
                                                _divisionController.clear();
                                              });
                                            },

                                            /// Suggestion box decoration (optional)
                                            decorationBuilder: (context, child) => Material(
                                              elevation: 4,
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8.r),
                                              child: child,
                                            ),
                                          )

                                          //   ///=====old TypeAheadFormField code
                                          // TypeAheadFormField<DivisionModel>(
                                          //   textFieldConfiguration:
                                          //       TextFieldConfiguration(
                                          //     controller: _divisionController,
                                          //     decoration: InputDecoration(
                                          //       contentPadding: EdgeInsets.only(
                                          //           top: 2.h,
                                          //           bottom: 4.h,
                                          //           left: 8.0.w),
                                          //       hintText: 'Select Divisions',
                                          //       isDense: true,
                                          //       hintStyle: TextStyle(
                                          //         fontSize: 12.0.sp,
                                          //         color: Colors.grey[500],
                                          //       ),
                                          //       filled: true,
                                          //       fillColor: Colors.white,
                                          //       border: InputBorder.none,
                                          //     ),
                                          //   ),
                                          //   suggestionsCallback: (pattern) {
                                          //     return divisionProvider
                                          //         .searchDivisions(pattern);
                                          //   },
                                          //   itemBuilder: (context, suggestion) {
                                          //     return Padding(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 5.h,
                                          //           horizontal: 10.w),
                                          //       child: Text(
                                          //         suggestion.divisionName,
                                          //         style: TextStyle(
                                          //             fontSize: 14.sp),
                                          //         maxLines: 1,
                                          //         overflow:
                                          //             TextOverflow.ellipsis,
                                          //       ),
                                          //     );
                                          //   },
                                          //   transitionBuilder: (context,
                                          //       suggestionsBox, controller) {
                                          //     return suggestionsBox;
                                          //   },
                                          //   onSuggestionSelected:
                                          //       (DivisionModel suggestion) {
                                          //     setState(() {
                                          //       // Toggle selection
                                          //       if (_selectedDivisions
                                          //           .contains(suggestion)) {
                                          //         _selectedDivisions
                                          //             .remove(suggestion);
                                          //       } else {
                                          //         _selectedDivisions
                                          //             .add(suggestion);
                                          //       }
                                          //       // Clear the text field and update it with selected districts
                                          //       _divisionController.clear();
                                          //     });
                                          //   },
                                          // )
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

                        // District Multi-Select
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

                            // Start of the widget
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
                                          width: 0.5.w, // Set border width here
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Display selected districts as text with a clear icon
                                          if (_selectedDistricts.isNotEmpty)
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8.0.w),
                                              child: SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Text(
                                                  _selectedDistricts
                                                      .map((district) =>
                                                          district.areaName)
                                                      .join(', '),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 14.sp,
                                                    color: Colors.black,
                                                  ),
                                                  overflow: TextOverflow
                                                      .ellipsis, // Handle overflow if text is too long
                                                ),
                                              ),
                                            ),
                                          // TextField with TypeAhead suggestions
                                          ///=====new myTask TypeAheadField new
                                          TypeAheadField<DistrictModel>(
                                            controller: _districtController,
                                            /// TextField builder
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

                                            /// Suggestions callback
                                            suggestionsCallback: (pattern) {
                                              return districtProvider.searchDistricts(pattern);
                                            },

                                            /// Suggestion list UI
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

                                            /// When a suggestion is selected
                                            onSelected: (DistrictModel suggestion) {
                                              setState(() {
                                                // Toggle selection
                                                if (_selectedDistricts.contains(suggestion)) {
                                                  _selectedDistricts.remove(suggestion);
                                                } else {
                                                  _selectedDistricts.add(suggestion);
                                                }
                                                // Clear the text field
                                                _districtController.clear();
                                              });
                                            },

                                            /// Suggestion box decoration (optional)
                                            decorationBuilder: (context, child) => Material(
                                              elevation: 4,
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(8.r),
                                              child: child,
                                            ),
                                          )

                                          //   ///=====old TypeAheadFormField code
                                          // TypeAheadFormField<DistrictModel>(
                                          //   textFieldConfiguration:
                                          //       TextFieldConfiguration(
                                          //     controller: _districtController,
                                          //     decoration: InputDecoration(
                                          //       contentPadding: EdgeInsets.only(
                                          //           top: 2.h,
                                          //           bottom: 4.h,
                                          //           left: 8.0.w),
                                          //       hintText: 'Select District',
                                          //       isDense: true,
                                          //       hintStyle: TextStyle(
                                          //         fontSize: 12.0.sp,
                                          //         color: Colors.grey[500],
                                          //       ),
                                          //       filled: true,
                                          //       fillColor: Colors.white,
                                          //       border: InputBorder.none,
                                          //     ),
                                          //   ),
                                          //   suggestionsCallback: (pattern) {
                                          //     return districtProvider
                                          //         .searchDistricts(pattern);
                                          //   },
                                          //   itemBuilder: (context, suggestion) {
                                          //     return Padding(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 5.h,
                                          //           horizontal: 10.w),
                                          //       child: Text(
                                          //         suggestion.districtName,
                                          //         style: TextStyle(
                                          //             fontSize: 14.sp),
                                          //         maxLines: 1,
                                          //         overflow:
                                          //             TextOverflow.ellipsis,
                                          //       ),
                                          //     );
                                          //   },
                                          //   transitionBuilder: (context,
                                          //       suggestionsBox, controller) {
                                          //     return suggestionsBox;
                                          //   },
                                          //   onSuggestionSelected:
                                          //       (DistrictModel suggestion) {
                                          //     setState(() {
                                          //       // Toggle selection
                                          //       if (_selectedDistricts
                                          //           .contains(suggestion)) {
                                          //         _selectedDistricts
                                          //             .remove(suggestion);
                                          //       } else {
                                          //         _selectedDistricts
                                          //             .add(suggestion);
                                          //       }
                                          //       // Clear the text field and update it with selected districts
                                          //       _districtController.clear();
                                          //     });
                                          //   },
                                          // ),
                                        
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )

                            // data remove
                            // GestureDetector(
                            //   onTap: () {
                            //     setState(() {
                            //       if (_selectedDistricts
                            //           .isNotEmpty) {
                            //         _selectedDistricts
                            //             .removeLast(); // Remove the last selected district
                            //         if (_selectedDistricts
                            //             .isEmpty) {
                            //           _districtController
                            //               .clear(); // Clear text field if no districts are left
                            //         }
                            //       }
                            //     });
                            //   },
                            //   child: Padding(
                            //     padding:
                            //         EdgeInsets.all(5.r),
                            //     child: Icon(Icons.close,
                            //         size: 16.sp),
                            //   ),
                            // ),
                            //end
                            // End of the widget
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
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
                        Row(children: [
                          Expanded(flex:5, child: Text("Validity Date:",  style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w600),)),
                           SizedBox(width: 4.w),
                          SizedBox(
                            width: 4.w,
                            child: Text(
                              ":",
                              style: TextStyle(color: Colors.black, fontSize: 16.sp),
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            flex: 8,
                            child: Container(
                              height: 30.h,
                              child: GestureDetector(
                                onTap: (() {
                                  _firstSelectedDate();
                                }),
                                child: TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(contentPadding: EdgeInsets.only(left: 5.w),
                                    filled: true,
                                    fillColor: Colors.white,
                                    suffixIcon: Padding(padding: EdgeInsets.only(left: 20.w),
                                    child: Icon(Icons.calendar_month, color: Colors.black87,size: 16.r)),
                                    border: OutlineInputBorder(borderSide: BorderSide(color:  Colors.grey,width: 5.w)),
                                    hintText: firstPickedDate,
                                    hintStyle: AllTextStyle.dateFormatStyle
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ]),
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
                              child: Text(
                                ":",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16.sp),
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
                                    width: 0.5.w, // Set border width here
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
                                  text:
                                      "Please fill in all the required fields.",
                                  isSuccess: false,
                                );
                                return;
                              }

                              //List<String> selectedDivisionIds = _selectedDivisions.map((division) => division.id).toList();
                              List<String> selectedDivisionIds = _selectedDivisions.map((division) => division.id.toString()).toList();

                              //List<String> selectedDistrictIds = _selectedDistricts.map((district) => district.districtSlNo).toList();
                              List<String> selectedDistrictIds = _selectedDistricts.map((district) => district.id.toString()).toList();
                              // Convert _imagesList (XFile) to a list of File
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
                                    validityDate: firstPickedDate.toString(),
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
                                      firstPickedDate = "";  
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

          //end
          SizedBox(
            height: 10.h,
          ),

          const SalesOldMachieData()
        ])));
  }
}
