import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
//import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_trade/controller/get_district_api.dart';
import 'package:medical_trade/controller/get_division_api.dart';
import 'package:medical_trade/controller/login_auth.dart';
import 'package:medical_trade/controller/register_auth.dart';
import 'package:medical_trade/model/district_model.dart';
import 'package:medical_trade/model/division_model.dart';
import 'package:medical_trade/utilities/assets_manager.dart';
import 'package:medical_trade/utilities/custom_message.dart';
import 'package:medical_trade/utilities/custom_textfromfield_register.dart';
import 'package:medical_trade/utilities/font_manager.dart';
import 'package:medical_trade/utilities/sizebox_manager.dart';
import 'package:medical_trade/utilities/values_manager.dart';
import 'package:medical_trade/view/my_wall_post_view.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  final bool isLogin;
  const LoginView({
    super.key,
    required this.isLogin,
  });

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late bool _isLogin;
  @override
  void initState() {
    super.initState();
    _isLogin = widget.isLogin;
  }

  void _toggleView() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity.w,
        height: double.infinity.h,
        decoration: BoxDecoration(
          color: _isLogin ? Colors.transparent : const Color(0xFFEDF3E2),
          image: !_isLogin
              ? null
              : DecorationImage(
                  image: const AssetImage('assets/icons/background5.jpg'),
                  fit: BoxFit.fill,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.20),
                    BlendMode.color,
                  ),
                ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(AppPadding.p20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1300),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildCustomButton(
                                text: 'Login',
                                isActive: _isLogin,
                                onTap: () {
                                  if (!_isLogin) _toggleView();
                                },
                              ),
                              SizedBoxManager.width16(),
                              _buildCustomButton(
                                text: 'Register',
                                isActive: !_isLogin,
                                onTap: () {
                                  if (_isLogin) {
                                    _toggleView();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    _isLogin
                        ? SizedBox(
                            height: 40.h,
                          )
                        : SizedBoxManager.height8(),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: _isLogin
                          ? Center(
                              child: Container(
                                height: 90.h,
                                width: 90.w,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(45.r))),
                                child: Padding(
                                  padding: EdgeInsets.all(4.0.r),
                                  child: Center(
                                    child: Image.asset(
                                      ImageAssets.appBarIcon,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          // ? Center(
                          //     child: Image.asset(
                          //       ImageAssets.appBarIcon,
                          //       height: 80.h,
                          //       width: 200.w,
                          //     ),
                          //   )
                          : Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 35.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                    FadeInUp(
                      duration: const Duration(milliseconds: 1300),
                      child: _isLogin
                          ? Center(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10.h),
                                    child: Text("Medical Trade",
                                        style: FontManager.subheading.copyWith(
                                          color: const Color.fromARGB(
                                              255, 236, 73, 73),
                                          fontSize: 24.sp,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 20.h),
                                    child: Text("Sign In From",
                                        style: FontManager.subheading.copyWith(
                                          color: Colors.white,
                                          fontSize: 18.sp,
                                        )),
                                  )
                                ],
                              ),
                            )
                          : Text("Create an Account",
                              style: FontManager.subheading.copyWith(
                                color: Colors.black,
                                fontSize: 18.sp,
                              )),
                    ),
                  ],
                ),
              ),
              _isLogin ? SizedBox(height: 5.h) : SizedBox(height: 5.h),
              Row(
                children: [
                  _isLogin
                      ? Expanded(
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: const _LoginWidgets()),
                        )
                      : Expanded(
                          child: FadeInUp(
                              duration: const Duration(milliseconds: 1300),
                              child: const _RegisterWidgets()),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildCustomButton({
  required String text,
  required bool isActive,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Container(
        height: AppSize.s40.h,
        width: AppSize.s100.w,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              isActive ? const Color(0xFF007BFF) : const Color(0xFF6C757D),
              isActive ? const Color(0xFF0056B3) : const Color(0xFF5A6268),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: FontManager.bodyText.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp, // Adjusted font size
            ),
          ),
        ),
      ),
    ),
  );
}

class _RegisterWidgets extends StatefulWidget {
  const _RegisterWidgets();

  @override
  State<_RegisterWidgets> createState() => _RegisterWidgetsState();
}

class _RegisterWidgetsState extends State<_RegisterWidgets> {
  final TextEditingController _organizationController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _upazilaController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _rePasswordController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _divisionController = TextEditingController();
  String? _selectedDivision;
  String? _selectedDistrict;
  bool _obscureText = true;
  bool _obscureTextTwo = true;
  final List<DistrictModel> _selectedDistricts = [];
  final List<DivisionModel> _selectDivision = [];
  Map<String, String> districtsNameMap = {};
  Map<String, String> divisionsNameMap = {};

  @override
  void initState() {
    super.initState();
    // Add post frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final districtProvider =
          Provider.of<DistrictProvider>(context, listen: false);
      final divisionProvider =
          Provider.of<DivisionProvider>(context, listen: false);

      // Fetch data
      await Future.wait([
        districtProvider.fetchDistricts(),
        divisionProvider.fetchDivisions()
      ]);
      // Update DivisionMap after fetching dividions
      setState(() {
        divisionsNameMap = Map.fromEntries(divisionProvider.divisions.map(
            (division) =>
                MapEntry(division.divisionSlNo, division.divisionName)));
      });
      // Update districtsNameMap after fetching districts
      setState(() {
        districtsNameMap = Map.fromEntries(districtProvider.districts.map(
            (district) =>
                MapEntry(district.districtSlNo, district.districtName)));
      });
    });
  }

  @override
  void dispose() {
    _districtController.dispose();
    _divisionController.dispose();
    super.dispose();
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final districtProvider = Provider.of<DistrictProvider>(context);
    final divisionProvider = Provider.of<DivisionProvider>(context);

    return Consumer<RegisterAuthProvider>(
      builder: (context, registerProvider, child) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(60.0.r),
              topRight: Radius.circular(60.0.r),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0.w, vertical: 12.0.h),
            child: Column(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          width: 80.0.w,
                          height: 80.0.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.black,
                              width: 2.0.w,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 38.0.r,
                            backgroundColor: Colors.transparent,
                            backgroundImage:
                                _image != null ? FileImage(_image!) : null,
                            child: _image == null
                                ? Padding(
                                    padding: EdgeInsets.all(12.0.r),
                                    child: Image.asset(
                                      "assets/icons/machine.png",
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : null,
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
                SizedBox(height: 12.0.h),
                CustomTextFormField(
                  controller: _organizationController,
                  hintText: "Enter Organization Name",
                  title: "Organization Name",
                ),
                SizedBox(height: 4.0.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _customerNameController,
                        hintText: "Person Name",
                        title: "Person Name",
                      ),
                    ),
                    SizedBox(width: 4.0.w),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _titleController,
                        hintText: "Title",
                        title: "Title",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0.h),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField(
                        controller: _usernameController,
                        hintText: "Enter User Name",
                        title: "User Name",
                      ),
                    ),
                    SizedBox(width: 4.0.w),
                    Expanded(
                      child: CustomTextFormField(
                        controller: _mobileController,
                        hintText: "Mobile",
                        title: "Mobile",
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.0.w),
                      child: Text(
                        "Address",
                        style: TextStyle(
                            fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Container(
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0.r),
                      ),
                      child: TextFormField(
                        controller: _addressController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: "Address",
                          hintStyle: TextStyle(color: Colors.grey[500]),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 9.0.h,
                            horizontal: 8.w,
                          ),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0.w),
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0.w),
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0.w),
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0.h),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.0.w),
                            child: Text(
                              "Division",
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 2.0.h),
                          ///=====new myTask TypeAheadField new
                          Container(
                            height: 40.0.h,
                            padding: EdgeInsets.symmetric(vertical: 2.0.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.black, width: 1.0),
                              borderRadius: BorderRadius.circular(8.0.r),
                            ),

                            /// ✅ New flutter_typeahead ^5.2.0 compatible widget
                            child: TypeAheadField<DivisionModel>(
                              controller: _divisionController,
                              suggestionsCallback: (pattern) {
                                return divisionProvider.searchDivisions(pattern);
                              },
                              builder: (context, controller, focusNode) {
                                return TextField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 8.0.w, top: 5.h),
                                    hintText: 'Select Division',
                                    isDense: true,
                                    hintStyle:
                                        TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                                    suffixIcon: _selectDivision.isEmpty
                                        ? null
                                        : GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                _selectDivision.clear();
                                                _divisionController.clear();
                                                _selectedDivision = null;
                                              });
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  left: 4.w, top: 5.h, right: 8.w),
                                              child: Icon(Icons.close, size: 16.sp),
                                            ),
                                          ),
                                    suffixIconConstraints: BoxConstraints(maxHeight: 30.h),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                  ),
                                );
                              },

                              /// ✅ Suggestion list item UI
                              itemBuilder: (context, suggestion) {
                                return ListTile(
                                  title: Text(
                                    suggestion.divisionName,
                                    style: TextStyle(fontSize: 14.sp),
                                  ),
                                );
                              },

                              /// ✅ When user selects a suggestion
                              onSelected: (suggestion) {
                                setState(() {
                                  if (!_selectDivision.contains(suggestion)) {
                                    _selectDivision.add(suggestion);
                                    _divisionController.text = _selectDivision
                                        .map((division) => division.divisionName)
                                        .join(', ');
                                    _selectedDivision = suggestion.divisionSlNo;
                                  }
                                });
                              },

                              /// Optional: how suggestions box looks
                              decorationBuilder: (context, child) {
                                return Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(8),
                                  child: child,
                                );
                              },
                            ),
                          ),

                          //   ///=====old TypeAheadFormField code
                          // Container(
                          //   height: 40.0.h,
                          //   padding: EdgeInsets.symmetric(vertical: 2.0.h),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     border: Border.all(color: Colors.black, width: 1.0),
                          //     borderRadius: BorderRadius.circular(8.0.r),
                          //   ),
                          //   child: TypeAheadFormField<DivisionModel>(
                          //     textFieldConfiguration: TextFieldConfiguration(
                          //       controller: _divisionController,
                          //       decoration: InputDecoration(
                          //         contentPadding:EdgeInsets.only(left: 8.0.w, top: 5.h),
                          //         hintText: 'Select Division',
                          //         isDense: true,
                          //         hintStyle: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                          //         suffixIcon: _selectDivision.isEmpty
                          //             ? null
                          //             : GestureDetector(
                          //                 onTap: () {
                          //                   setState(() {
                          //                     _selectDivision.clear();
                          //                     _divisionController.clear();
                          //                   });
                          //                 },
                          //                 child: Padding(
                          //                   padding: EdgeInsets.only(left: 4.w,top: 5.h,right: 8.w),
                          //                   child:Icon(Icons.close, size: 16.sp),
                          //                 ),
                          //               ),
                          //         suffixIconConstraints:BoxConstraints(maxHeight: 30.h),
                          //         filled: true,
                          //         fillColor: Colors.white,
                          //         border: InputBorder.none,
                          //       ),
                          //     ),
                          //     suggestionsCallback: (pattern) {
                          //       return divisionProvider.searchDivisions(pattern);
                          //     },
                          //     itemBuilder: (context, suggestion) {
                          //       return Padding(
                          //         padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                          //         child: Text(
                          //           suggestion.divisionName,
                          //           style: TextStyle(fontSize: 14.sp),
                          //           maxLines: 1,
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       );
                          //     },
                          //     transitionBuilder:(context, suggestionsBox, controller) {
                          //       return suggestionsBox;
                          //     },
                          //     onSuggestionSelected: (DivisionModel suggestion) {
                          //       setState(() {
                          //         if (!_selectDivision.contains(suggestion)) {
                          //           _selectDivision.add(suggestion);
                          //           _divisionController.text = _selectDivision.map((division) => division.divisionName).join(', ');
                          //           _selectedDivision = suggestion.divisionSlNo;
                          //         }
                          //       });
                          //     },
                          //   ),
                          // ),
                       
                        ],
                      ),
                    ),
                    SizedBox(width: 8.0.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 4.0.w),
                            child: Text(
                              "District",
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 2.0.h),
                          ///=====new myTask TypeAheadField new
                          Container(
                          height: 40.0.h,
                          padding: EdgeInsets.symmetric(vertical: 2.0.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black, width: 1.0),
                            borderRadius: BorderRadius.circular(8.0.r),
                          ),
                          /// ✅ New flutter_typeahead ^5.2.0 compatible widget
                          child: TypeAheadField<DistrictModel>(
                            controller: _districtController,
                            suggestionsCallback: (pattern) {
                              return districtProvider.searchDistricts(pattern);
                            },
                            builder: (context, controller, focusNode) {
                              return TextField(
                                controller: controller,
                                focusNode: focusNode,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 8.0.w, top: 5.h),
                                  hintText: 'Select District',
                                  isDense: true,
                                  hintStyle: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                                  suffixIcon: _selectedDistricts.isEmpty
                                      ? null
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              _selectedDistricts.clear();
                                              _districtController.clear();
                                              _selectedDistrict = null;
                                            });
                                          },
                                          child: Padding(
                                            padding:EdgeInsets.only(left: 4.w, top: 5.h, right: 8.w),
                                            child: Icon(Icons.close, size: 16.sp),
                                          ),
                                        ),
                                  suffixIconConstraints: BoxConstraints(maxHeight: 30.h),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                ),
                              );
                            },
                            itemBuilder: (context, suggestion) {
                              return Padding(
                                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                child: Text(
                                  suggestion.districtName,
                                  style: TextStyle(fontSize: 14.sp),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            },
                            onSelected: (DistrictModel suggestion) {
                              setState(() {
                                if (!_selectedDistricts.contains(suggestion)) {
                                  _selectedDistricts.add(suggestion);
                                  _districtController.text = _selectedDistricts.map((district) => district.districtName).join(', ');
                                  _selectedDistrict = suggestion.districtSlNo;
                                }
                              });
                            },
                            decorationBuilder: (context, child) {
                              return Material(
                                elevation: 4,
                                borderRadius: BorderRadius.circular(8),
                                child: child,
                              );
                            },
                          ),
                        ),
                          //   ///=====old TypeAheadFormField code
                          // Container(
                          //   height: 40.0.h,
                          //   padding: EdgeInsets.symmetric(vertical: 2.0.h),
                          //   decoration: BoxDecoration(
                          //     color: Colors.white,
                          //     border: Border.all(color: Colors.black, width: 1.0),
                          //     borderRadius: BorderRadius.circular(8.0.r),
                          //   ),
                          //   child: TypeAheadFormField<DistrictModel>(
                          //     textFieldConfiguration: TextFieldConfiguration(
                          //       controller: _districtController,
                          //       decoration: InputDecoration(
                          //         contentPadding:EdgeInsets.only(left: 8.0.w, top: 5.h),
                          //         hintText: 'Select District',
                          //         isDense: true,
                          //         hintStyle: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                          //         suffixIcon: _selectedDistricts.isEmpty
                          //             ? null
                          //             : GestureDetector(
                          //                 onTap: () {
                          //                   setState(() {
                          //                     _selectedDistricts.clear();
                          //                     _districtController.clear(); // Clear the text field
                          //                   });
                          //                 },
                          //                 child: Padding(
                          //                   padding: EdgeInsets.only(left: 4.w,top: 5.h,right: 8.w),
                          //                   child:Icon(Icons.close, size: 16.sp),
                          //                 ),
                          //               ),
                          //         suffixIconConstraints:BoxConstraints(maxHeight: 30.h),
                          //         filled: true,
                          //         fillColor: Colors.white,
                          //         border: InputBorder.none,
                          //       ),
                          //     ),
                          //     suggestionsCallback: (pattern) {
                          //       return districtProvider.searchDistricts(pattern);
                          //     },
                          //     itemBuilder: (context, suggestion) {
                          //       return Padding(
                          //         padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                          //         child: Text(
                          //           suggestion.districtName,
                          //           style: TextStyle(fontSize: 14.sp),
                          //           maxLines: 1,
                          //           overflow: TextOverflow.ellipsis,
                          //         ),
                          //       );
                          //     },
                          //     transitionBuilder:(context, suggestionsBox, controller) {
                          //       return suggestionsBox;
                          //     },
                          //     // For District TypeAhead
                          //     onSuggestionSelected: (DistrictModel suggestion) {
                          //       setState(() {
                          //         if (!_selectedDistricts.contains(suggestion)) {
                          //           _selectedDistricts.add(suggestion);
                          //           _districtController.text =
                          //               _selectedDistricts.map((district) =>district.districtName).join(', ');
                          //           _selectedDistrict = suggestion.districtSlNo; // Store the selected district ID
                          //         }
                          //       });
                          //     },
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0.h),
                CustomTextFormField(
                  controller: _upazilaController,
                  hintText: "Enter Upazila Name",
                  title: "Upazila Name",
                ),
                SizedBox(height: 4.0.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscureText,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 9.h,
                            horizontal: 8.w,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.0.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        "Re-Password",
                        style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextFormField(
                        controller: _rePasswordController,
                        obscureText: _obscureTextTwo,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureTextTwo
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureTextTwo = !_obscureTextTwo;
                              });
                            },
                          ),
                          hintText: "Re-Password",
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 9.h,
                            horizontal: 8.w,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0.h),
                InkWell(
                  onTap: () async {
                    // Retrieve the text from the controllers
                    String organization = _organizationController.text.trim();
                    String customerName = _customerNameController.text.trim();
                    String title = _titleController.text.trim();
                    String username = _usernameController.text.trim();
                    String mobile = _mobileController.text.trim();
                    String address = _addressController.text.trim();
                    String upazila = _upazilaController.text.trim();
                    String password = _passwordController.text.trim();
                    String rePassword = _rePasswordController.text.trim();

                    // Check if passwords match
                    if (password != rePassword) {
                      CustomToast.show(
                        context: context,
                        text: "Passwords do not match.",
                        isSuccess: false,
                      );
                      return;
                    }
                    // Check if any of the fields are empty, except for the image
                    if (organization.isEmpty ||
                        customerName.isEmpty ||
                        title.isEmpty ||
                        username.isEmpty ||
                        mobile.isEmpty ||
                        address.isEmpty ||
                        _selectedDivision == null ||
                        _selectedDistrict == null ||
                        upazila.isEmpty ||
                        password.isEmpty) {
                      CustomToast.show(
                        context: context,
                        text: "Please fill all required fields.",
                        isSuccess: false,
                      );
                      return;
                    }

                    // Call the register method and check the result
                    bool success = await registerProvider.register(
                      context: context,
                      organizationName: organization,
                      customerName: customerName,
                      title: title,
                      username: username,
                      mobile: mobile,
                      address: address,
                      divisionId: _selectedDivision!,
                      districtId: _selectedDistrict!,
                      upazila: upazila,
                      password: password,
                      image: _image,
                    );

                    if (success) {
                      CustomToast.show(
                        // ignore: use_build_context_synchronously
                        context: context,
                        text: "Registration successful!",
                        isSuccess: true,
                      );
                      Navigator.pushReplacement(
                        // ignore: use_build_context_synchronously
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(isLogin: true),
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 19, 95, 177),
                      borderRadius: BorderRadius.circular(AppSize.s8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: AppPadding.p10.h),
                    child: Center(
                      child: registerProvider.isLoading
                          ? SizedBox(
                              width: 20.w,
                              height: 20.h,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2.0.w,
                              ),
                            )
                          : Text(
                              "REGISTER",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LoginWidgets extends StatefulWidget {
  const _LoginWidgets();

  @override
  State<_LoginWidgets> createState() => _LoginWidgetsState();
}

class _LoginWidgetsState extends State<_LoginWidgets> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.w, right: 12.w),
      child: Consumer<LoginAuthProvider>(
        builder: (context, loginProvider, child) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.4),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppSize.s12.r),
                topRight: Radius.circular(AppSize.s12.r),
                bottomLeft: Radius.circular(AppSize.s12.r),
                bottomRight: Radius.circular(AppSize.s12.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: 16.w, right: 16.w, top: 40.h, bottom: 40.h),
              child: Column(
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.s8.r),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5.w,
                      ),
                    ),
                    child: TextFormField(
                      controller: userNameController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.person),
                        hintText: "Enter User Name",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 9.h,
                          horizontal: 8.w,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(AppSize.s8.r),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Password TextFormField
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(AppSize.s8.r),
                      border: Border.all(
                        color: Colors.grey,
                        width: 0.5.w, // Set border width here
                      ),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        hintText: "Enter Password",
                        hintStyle: TextStyle(
                          color: Colors.grey[500],
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 9.h,
                          horizontal: 8.w,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(AppSize.s8.r),
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Login Button
                  InkWell(
                    onTap: () async {
                      // Retrieve the text from the controllers
                      String username = userNameController.text.trim();
                      String password = passwordController.text.trim();

                      // Check if both fields are empty
                      if (username.isEmpty && password.isEmpty) {
                        CustomToast.show(
                          context: context,
                          text: "Fill is required.",
                          isSuccess: false,
                        );
                        return; // Exit the onTap function if both fields are empty
                      }

                      // Check if username is empty
                      if (username.isEmpty) {
                        CustomToast.show(
                          context: context,
                          text: "Username is required.",
                          isSuccess: false,
                        );
                        return; // Exit the onTap function if username is empty
                      }

                      // Check if password is empty
                      if (password.isEmpty) {
                        CustomToast.show(
                          context: context,
                          text: "Password is required.",
                          isSuccess: false,
                        );
                        return; // Exit the onTap function if password is empty
                      }

                      // Proceed with login if both fields are filled
                      bool success = await loginProvider.login(username, password);

                      if (success) {
                        CustomToast.show(
                          // ignore: use_build_context_synchronously
                          context: context,
                          text: "Login successful!",
                          isSuccess: true,
                        );

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyWallPostView(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      }
                    },
                    child: Container(
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 19, 95, 177),
                        borderRadius: BorderRadius.circular(AppSize.s8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: AppPadding.p10.h),
                      child: Center(
                        child: loginProvider.isLoading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2.0.w,
                                ),
                              )
                            : Text(
                                "LOGIN",
                                style: FontManager.bodyText.copyWith(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
