import 'package:dio/dio.dart';
import 'package:medical_trade/config/app_url.dart';

class ApiServiceNew{
 static fetchAllArea() async {
    try {
      String url = AppUrl.getcategoriesEndPoint;
      Response response = await Dio().post(url,
          options: Options(headers: {
            "Content-Type": "application/json",
          }));
      var data = response.data;
      //return List.from(data).map((e) => GetCategoriesProvider.fromMap(e)).toList();
    } catch (e) {
      print(e);
    }
    return null;
  }
}