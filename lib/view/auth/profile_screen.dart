import 'dart:io';
import 'package:get_storage/get_storage.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/diagnostic_module/utils/all_textstyle.dart';
import 'package:medical_trade/diagnostic_module/utils/animation_snackbar.dart';
import 'package:medical_trade/diagnostic_module/utils/app_colors.dart';
import 'package:medical_trade/diagnostic_module/utils/utils.dart';
import 'package:medical_trade/utilities/color_manager.dart';
import 'package:medical_trade/view/auth/login_register_auth.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _currentPController = TextEditingController();
  final TextEditingController _newPController = TextEditingController();
  final TextEditingController _confirmPController = TextEditingController();
  bool _isObscureCP = true;
  bool _isObscureNP = true;
  bool _isObscureCnFP = true;
  bool isLoading = false;

  // SharedPreferences? sharedPreferences;
  // Future<void> _initializeData() async {
  //   sharedPreferences = await SharedPreferences.getInstance();
  //   userName = "${sharedPreferences?.getString('userName')}";
  //   userImage = "${sharedPreferences?.getString('userImage')}";
  //   userType = "${sharedPreferences?.getString('userType')}";
  //   print("profile userName====$userName");
  //   print("profile userImage====$userImage");
  //   print("profile userType====$userType");
  //   setState(() {
  //   });
  // }
  String? userName = "";
  String? userImage = "";
  String? userType = "";
  String? userImageName;
  String? role;
  
  File? _image;
  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      print("picked image : ${_image}");
    }
  }
  @override
  void initState() {
    ///_initializeData();
    final box = GetStorage();
    userName = box.read('username');
    userImageName = box.read('image');
    role = box.read('role');
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.appbarColor,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 18.sp),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        child:  SingleChildScrollView(
          child: Column(
              children: [
                Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120.w,
                      height: 120.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.appColor, width: 3.w),
                      ),
                      child: CircleAvatar(
                      radius: 50.r,
                      backgroundColor: Colors.white,
                      backgroundImage: _image != null
                          ? FileImage(_image!) as ImageProvider
                          : (userImageName != null && userImageName!.isNotEmpty && userImageName != 'null'
                              ? NetworkImage("https://app.medicaltradeltd.com/${userImageName!}") as ImageProvider
                              : null),
                      child: (_image == null && (userImageName == null || userImageName!.isEmpty || userImageName == 'null'))
                          ? Icon(Icons.person,size: 60.sp,color: AppColors.appColor)
                          : null,
                     ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 14.r,
                          backgroundColor: AppColors.appColor,
                          child: Icon(Icons.camera_alt,size: 14.sp,color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(double.infinity, 30.h),
                        padding: EdgeInsets.all(5.r),
                        backgroundColor: const Color(0xff84BA40)
                    ),
                    onPressed: () {
                      setState(() {
                        isLoading = true;
                      });
                      setState(() {
                        changeProfile(image: _image);
                      });
                    },
                    child: isLoading ? const CircularProgressIndicator(
                      color: Colors.white) : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text("Image Upload",style: AllTextStyle.saveButtonTextStyle),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                    padding: EdgeInsets.all(10.r),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey.shade200),
                        borderRadius: BorderRadius.circular(10..r)),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text("Username        :  ",style: AllTextStyle.profileTextStyle),
                            Text("${userName??""}",style: TextStyle(color: Colors.black,fontSize: 13.sp)),
                          ],
                        ),
                        Row(
                          children: [
                            Text("Role                  :  ",style: AllTextStyle.profileTextStyle),
                            Text("${role??""}",style: TextStyle(color: Colors.black,fontSize: 13.sp)),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 10.h),
                Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueGrey.shade200),
                      borderRadius: BorderRadius.circular(10.r)),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(flex: 6,child: Text("Current Password",style: AllTextStyle.profileTextStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 9,
                            child: SizedBox(
                              height: 30.h,
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                obscureText: _isObscureCP,
                                onChanged: (value) {
                                  setState(() {
                                    _isObscureCP = true;
                                  });
                                },
                                style: TextStyle(fontSize: 13.sp),
                                controller: _currentPController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Icon(_isObscureCP ? Icons.visibility : Icons.visibility_off,color: Colors.grey,size: 16.r),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscureCP = !_isObscureCP;
                                      });
                                    },
                                  ),
                                  suffixIconColor: Colors.grey,
                                  hintText: "Current Password",
                                  contentPadding: EdgeInsets.only(left: 5.w),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder: TextFieldInputBorder.focusEnabledBorder
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Expanded(flex: 6,child: Text("New Password",style: AllTextStyle.profileTextStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 9,
                            child: SizedBox(
                              height: 30.h,
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                obscureText: _isObscureNP,
                                onChanged: (value) {
                                  setState(() {
                                    _isObscureNP = true;
                                  });
                                },
                                style: TextStyle(fontSize: 13.sp),
                                controller: _newPController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Icon(_isObscureNP ? Icons.visibility : Icons.visibility_off,color: Colors.grey,size: 16.r),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscureNP = !_isObscureNP;
                                      });
                                    },
                                  ),
                                  suffixIconColor: Colors.grey,
                                  hintText: "New Password",
                                  contentPadding: EdgeInsets.only(left: 5.w),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder: TextFieldInputBorder.focusEnabledBorder
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          Expanded( flex: 6,child: Text("Confirm Password",style: AllTextStyle.profileTextStyle)),
                          const Expanded(flex: 1, child: Text(":")),
                          Expanded(
                            flex: 9,
                            child: SizedBox(
                              height: 30.h,
                              width: MediaQuery.of(context).size.width / 2,
                              child: TextField(
                                obscureText: _isObscureCnFP,
                                onChanged: (value) {
                                  setState(() {
                                    _isObscureCnFP = true;
                                  });
                                },
                                style: TextStyle(fontSize: 13.sp),
                                controller: _confirmPController,
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    icon: Padding(
                                      padding: EdgeInsets.only(left: 10.w),
                                      child: Icon(_isObscureCnFP ? Icons.visibility : Icons.visibility_off,color: Colors.grey,size: 16.r),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _isObscureCnFP = !_isObscureCnFP;
                                      });
                                    },
                                  ),
                                  suffixIconColor: Colors.grey,
                                  hintText: "Confirm Password",
                                  contentPadding: EdgeInsets.only(left: 5.w),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: InputBorder.none,
                                  focusedBorder: TextFieldInputBorder.focusEnabledBorder,
                                  enabledBorder: TextFieldInputBorder.focusEnabledBorder
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    padding: EdgeInsets.only(top: 20.h,bottom: 20.h),
                    child: InkWell(
                      onTap: () async {
                        setState(() {
                          isLoadingPChange = true;
                        });
                        fetchPasswordChange(
                            _currentPController.text,
                            _newPController.text,
                            _confirmPController.text,
                            context);
                      },
                      child:Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                        elevation: 6.0,
                        child: Container(
                          height: MediaQuery.of(context).size.width/9,
                          width: MediaQuery.of(context).size.width/1,
                          decoration: BoxDecoration(
                            color: AppColors.appColor,
                            borderRadius: BorderRadius.circular(100.r),
                          ),
                          child: Center(
                              child: isLoadingPChange ? SizedBox(height: 20.0.h, width: 20.0.w,
                                child: CircularProgressIndicator(color: Colors.white)):
                              Text("Update", style: AllTextStyle.saveButtonTextStyle),
                            ),
                          ),
                      ),
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
 static String getToken() {
  final box = GetStorage();
  return box.read('loginToken') ?? "";
}

Future<bool> changeProfile({File? image}) async {
  print("image ====== $image");

  String link = AppUrl.uploadProfileImgEndPint;
  final token = getToken();

  try {
    setState(() {
      isLoading = true;
    });

    final formData = FormData.fromMap({
      if (image != null)
        'image': await MultipartFile.fromFile(
          image.path,
          filename: "${DateTime.now().millisecondsSinceEpoch}.jpg",
        ),
    });

    final response = await Dio().post(
      link,
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    final item = response.data;
    print("profile image response ====> $item");

    setState(() {
      isLoading = false;
    });

    if (item is Map && item["status"] == "success") {
     // final imageUrl = item["image"];

      /// চাইলে image url save করতে পারেন
      // final box = GetStorage();
      // box.write("profileImage", imageUrl);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(255, 4, 108, 156),
          duration: const Duration(seconds: 2),
          content: Center(
            child: Text(
              item["message"] ?? "Profile image updated successfully",
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.black,
          duration: const Duration(seconds: 2),
          content: Center(
            child: Text(
              item["message"] ?? "Image upload failed",
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      );
      return false;
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    print("Error upload profile image ====> $e");

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Something went wrong. Please Select Image and try again"),
      ),
    );
    return false;
  }
}



bool isLoadingPChange = false;

Future<bool> fetchPasswordChange(
  String oldPass,
  String newPass,
  String confirmPass,
  BuildContext context,
) async {

  String link = AppUrl.updatePasswordEndPint;
  final token = getToken();

  try {
    isLoadingPChange = true;
    setState(() {});

    final formData = FormData.fromMap({
      "current_password": oldPass.trim(),
      "password": newPass.trim(),
      "password_confirmation": confirmPass.trim(),
    });

    final response = await Dio().post(
      link,
      data: formData,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    final item = response.data;
    print("change password response ====> $item");

    isLoadingPChange = false;
    setState(() {});

    if (item is Map && item["status"] == "success") {
      emptyMethod();

      CustomSnackBar.showTopSnackBar(
        context,
        item["message"] ?? "Password updated successfully",
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginView(isLogin: true),
        ),
      );
      return true;
    } else {
      Utils.showTopSnackBar(
        context,
        item["message"] ?? "Password not updated",
      );
      return false;
    }
  } catch (e) {
    isLoadingPChange = false;
    setState(() {});
    print("Error change password ====> $e");

    Utils.showTopSnackBar(
      context,
      "Something went wrong. Please try again",
    );
    return false;
  }
}


emptyMethod() {
  setState(() {
    _currentPController.clear();
    _newPController.clear();
    _confirmPController.clear();
  });
}
}