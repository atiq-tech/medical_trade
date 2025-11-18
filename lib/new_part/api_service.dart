import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' hide Response;
import 'package:medical_trade/config/app_url.dart';
import 'package:medical_trade/model/get_category_product_model.dart';
import 'package:medical_trade/new_part/model/client_post_model.dart';
import 'package:medical_trade/new_part/model/new_category_model.dart';
import 'package:medical_trade/new_part/model/wall_post_new_model.dart';

class ApiServiceNew {
  // Read token from GetStorage
  static String getToken() {
    final box = GetStorage();
    return box.read('loginToken') ?? "";
  }

  //========= fetch categories
  static Future<List<NewCategoryModel>?> fetchCategoryApi() async {
    try {
      String url = AppUrl.getcategoriesEndPoint;
      final token = getToken();

      Response response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      var data = response.data;
      print("Category data === $data");
      return List.from(data).map((e) => NewCategoryModel.fromMap(e)).toList();
    } catch (e) {
      print("API ERROR fetchCategoryApi === $e");
      return null;
    }
  }

  //========= fetch client posts
  static Future<List<ClientPostModel>?> fetchClientPostApi() async {
    try {
      String url = AppUrl.myWallEndPint;
      final token = getToken();

      Response response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      var data = response.data;
      print("API DATA === $data");

      return List.from(data["data"])
          .map((e) => ClientPostModel.fromMap(e))
          .toList();
    } catch (e) {
      print("API ERROR fetchClientPostApi === $e");
      return null;
    }
  }

  //========= fetch wall posts
  static Future<List<WallPostNewModel>?> fetchWallPostNewApi() async {
    try {
      String url = AppUrl.myWallEndPint;
      final token = getToken();

      Response response = await Dio().get(
        url,
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );

      var data = response.data;
      print("API DATA myWallEndPint === $data");

      return List.from(data)
          .map((e) => WallPostNewModel.fromMap(e))
          .toList();
    } catch (e) {
      print("API ERROR fetchWallPostNewApi === $e");
      return null;
    }
  }


    //========= fetch categories
 static Future<List<GetCategoryProductModel>?> fetchGetProductsApi(String? productCategoryId,String? type) async { 
  try {
    String url = AppUrl.getProductsEndPoint;
    final token = getToken();

    Response response = await Dio().get(url,
      data: {
          "product_category_id": productCategoryId,
          "type": type
      },
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
      ),
    );

    var data = response.data;
    print("get products data === $data");
    // Use fromJson instead of fromMap
    return List.from(data["data"]).map((e) => GetCategoryProductModel.fromJson(e)).toList();

  } catch (e) {
    print("API ERROR products === $e");
    return null;
  }
}

}
