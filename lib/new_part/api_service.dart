import 'package:dio/dio.dart';
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/new_part/model/client_post_model.dart';
import 'package:medical_trade/new_part/model/new_category_model.dart';
import 'package:medical_trade/new_part/model/wall_post_new_model.dart';

class ApiServiceNew{
 static fetchCategoryApi() async {
    try {
      String url = AppUrl.getcategoriesEndPoint;
      Response response = await Dio().get(url,
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      var data = response.data;
      print("Gategory data====$data");
      return List.from(data["data"]).map((e) => NewCategoryModel.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
  //=========client post
  static Future<List<ClientPostModel>?> fetchClientPostApi() async {
  try {
    String url = AppUrl.myWallEndPint;

    Response response = await Dio().get(url,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    var data = response.data;

    print("API DATA === $data");

    return List.from(data["data"]).map((e) => ClientPostModel.fromMap(e)).toList();
  } catch (e) {
    print("API ERROR === $e");
    return null;
  }
}

  //  static fetchClientPostApi() async {
  //   try {
  //     String url = AppUrl.getClientPostEndPoint;
  //     Response response = await Dio().get(url,
  //         options: Options(headers: {
  //           "Content-Type": "application/json",
  //         }));
  //     var data = response.data;
  //     print("getClientPost data====$data");
  //     return List.from(data["data"]).map((e) => ClientPostModel.fromMap(e)).toList();
  //   } catch (e) {
  //     print(e);
  //   }
  //   return null;
  // }

  
   //=========client post
  static Future<List<WallPostNewModel>?> fetchWallPostNewApi() async {
  try {
    String url = AppUrl.myWallEndPint;

    Response response = await Dio().get(url,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    var data = response.data;

    print("API DATA myWallEndPint === $data");

    return List.from(data["data"]).map((e) => WallPostNewModel.fromMap(e)).toList();
  } catch (e) {
    print("API ERROR === $e");
    return null;
  }
}
}