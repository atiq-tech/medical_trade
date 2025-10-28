class AppUrl {
  static var baseUrl = 'https://soft.madicaltrade.com';
  static var baseImageUrl = 'https://soft.madicaltrade.com/uploads/products/';
  static var baseImageUrlTwo = 'https://madicaltrade.com/uploads/clientposts/';
  // Login Api
  static var loginEndPint = '$baseUrl/user-Login';
  //end
  // Contact Api
  static var contactEndPint = '$baseUrl/get-companyprofile';
  //end
// My Wall  Api
  static var myWallEndPint = '$baseUrl/get-wallpost';
  static var clientWallOrderEndPint = '$baseUrl/customer-addwallorder';
  static var generateWallOrderCodeEndPint = '$baseUrl/generate-customerwallordercode';
  //end
  // Customer Order   Api
  static var customerOrderEndPint = '$baseUrl/customer-addorder';
  static var generateCustomerOrderCodeEndPint = '$baseUrl/generate-customerordercode';
  //end

  //Register Api All
  static var registerEndPint = '$baseUrl/user-register';
  static var getDivisionsEndPoint = '$baseUrl/get-divisions';
  static var getDistrictsEndPoint = '$baseUrl/get-districts';
  static var getCustomerCodeEndPoint = '$baseUrl/generate-customercode';
  //end

  //home Api All Detail & Categories
  static var getcategoriesEndPoint = '$baseUrl/get-categories';
  static var updatecategoriesEndPoint = '$baseUrl/update-categories';
  static var deletecategoriesEndPoint = '$baseUrl/delete-categories';
  static var addcategoriesEndPoint = '$baseUrl/add-categories';
  static var getProductsEndPoint = '$baseUrl/get-products';
  static var updateProductsEndPoint = '$baseUrl/update-products';
  static var deleteProductsEndPoint = '$baseUrl/delete-products';
  //end

  // Engineers Support Page Api ALL
  static var getProductEngineeringEndPoint = '$baseUrl/get-engineersuport';
  static var addEngineerSuportEndPoint = '$baseUrl/add-engineersuport';
  static var updateEngineerSuportEndPoint = '$baseUrl/update-engineersuport';
  static var deleteEngineerSuportEndPoint = '$baseUrl/delete-engineersuport';
  //end

  //Sales Your Old Machine Page Api ALl
  static var getClientPostEndPoint = '$baseUrl/get-clientpost';
  static var addClientpostEndPoint = '$baseUrl/add-clientpost';
  static var generateClientPostCodeEndPoint = '$baseUrl/generate-clientpostcode';
  //end

  //extra
  // static var getProductEngineeringEndPoint = '$baseUrl/get-engineersuport';
  //   static String getCategoryProduct(String productId) {
  //   return '$baseUrl/get-products/$productId';
  // }
}
