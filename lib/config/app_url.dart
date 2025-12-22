class AppUrl {
  //static var baseUrl = 'https://soft.madicaltrade.com';//sub
  static var baseUrl = 'https://app.medicaltradeltd.com/api/v1';//sub
  static var newImageUrl = 'https://app.medicaltradeltd.com/';//sub
  //static var baseUrl = 'https://medicaltradeltd.com'; //main
  static var baseImageUrl = 'https://soft.madicaltrade.com/uploads/products/';
  static var baseImageUrlTwo = 'https://madicaltrade.com/uploads/clientposts/';
  // Login Api
  static var loginEndPint = '$baseUrl/login';
  static var uploadProfileImgEndPint = '$baseUrl/upload-profile-image';
  static var updatePasswordEndPint = '$baseUrl/update-password';
  
  //end
  // Contact Api
  static var contactEndPint = '$baseUrl/get-company-profile';
  //end
// My Wall  Api
  static var myWallEndPint = '$baseUrl/get-wall-post';
  static var clientWallOrderEndPint = '$baseUrl/add-wall-order';
  static var generateWallOrderCodeEndPint = '$baseUrl/get-wall-order-code';
  //end
  // Customer Order   Api
  static var customerOrderEndPint = '$baseUrl/add-customer-order';
  static var generateCustomerOrderCodeEndPint = '$baseUrl/get-customer-order-code';
  //end

  //Register Api All
  static var registerEndPint = '$baseUrl/registration';
  static var getDivisionsEndPoint = '$baseUrl/get-divisions';
  static var getDistrictsEndPoint = '$baseUrl/get-districts';
  //static var getCustomerCodeEndPoint = '$baseUrl/get-customer-code';
  static var getBranchCodeEndPoint = '$baseUrl/get-branch-code';
  
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
  static var getClientPostEndPoint = '$baseUrl/get-client-post';
  static var addClientpostEndPoint = '$baseUrl/add-client-post';
  static var generateClientPostCodeEndPoint = '$baseUrl/get-client-post-code';
  //end

  
  //Diagnostic All Api 
  static var getPatientEndPoint = '$baseUrl/get-patient';
  static var getPatientCodeEndPoint = '$baseUrl/get-patient-code';
  static var addPatientEndPoint = '$baseUrl/add-patient';

  static var getPatientPayEndPoint = '$baseUrl/get-patient-payments';
  static var getPatientPayCodeEndPoint = '$baseUrl/get-patient-payment-code';
  static var getMadicinePatientDueEndPoint = '$baseUrl/get_madicine_patient_due';
  static var addPatientPayEndPoint = '$baseUrl/add-patient-payment';

  static var getDoctorEndPoint = '$baseUrl/get-doctor';
  static var getDepartmentEndPoint = '$baseUrl/get-departments';
  static var getDoctorCodeEndPoint = '$baseUrl/get-doctor-code';
  static var addDoctorEndPoint = '$baseUrl/add-doctor';
  
  static var getSpecimensEndPoint = '$baseUrl/get-specimens';
  static var getTestEntryEndPoint = '$baseUrl/get-test-entry';
  static var getTestCodeEndPoint = '$baseUrl/get-test-code';
  static var addTestEntryEndPoint = '$baseUrl/add-test-entry';

  static var getCommissionPayEndPoint = '$baseUrl/get-commission-payment';
  static var getAgentCommissionDue = '$baseUrl/agent-commission-due';
  static var getCommissionPayCodeEndPoint = '$baseUrl/get-commission-payment-code';
  static var getBankAccountEndPoint = '$baseUrl/get-bank-accounts';
  static var getAgentsEndPoint = '$baseUrl/get-agents';
  static var addCommissionPayEndPoint = '$baseUrl/add-commission-payment';

  static var getCashTrCodeEndPoint = '$baseUrl/get-cash-transaction-code';
  static var getCashTransactionEndPoint = '$baseUrl/get-cash-transactions';
  static var getAccountsEndPoint = '$baseUrl/get-accounts';
  static var addCashTrEndPoint = '$baseUrl/add-cash-transaction';
  
  static var getBankTrCodeEndPoint = '$baseUrl/get-bank-transaction-code';
  static var getBankTransactionEndPoint = '$baseUrl/get-bank-transactions';
  static var addBankTrEndPoint = '$baseUrl/add-bank-transaction';

  static var getAppointmentsEndPoint = '$baseUrl/get-appointments';
  static var getAvailableSlotsEndPoint = '$baseUrl/get-available-slots';
  static var getAppointmentTrIDEndPoint = '$baseUrl/get-appointment-tr-id';
  static var getAppointSerialNumberEndPoint = '$baseUrl/get-appointment-serial-number';
  static var addAppointmentEndPoint = '$baseUrl/add-appointment';

  //end
}



//old====
// class AppUrl {
//   //static var baseUrl = 'https://soft.madicaltrade.com';//sub
//   static var baseUrl = 'https://app.medicaltradeltd.com/api/v1/';//sub
//   //static var baseUrl = 'https://medicaltradeltd.com'; //main
//   static var baseImageUrl = 'https://soft.madicaltrade.com/uploads/products/';
//   static var baseImageUrlTwo = 'https://madicaltrade.com/uploads/clientposts/';
//   // Login Api
//   static var loginEndPint = '$baseUrl/user-Login';
//   //end
//   // Contact Api
//   static var contactEndPint = '$baseUrl/get-companyprofile';
//   //end
// // My Wall  Api
//   static var myWallEndPint = '$baseUrl/get-wallpost';
//   static var clientWallOrderEndPint = '$baseUrl/customer-addwallorder';
//   static var generateWallOrderCodeEndPint = '$baseUrl/generate-customerwallordercode';
//   //end
//   // Customer Order   Api
//   static var customerOrderEndPint = '$baseUrl/customer-addorder';
//   static var generateCustomerOrderCodeEndPint = '$baseUrl/generate-customerordercode';
//   //end

//   //Register Api All
//   static var registerEndPint = '$baseUrl/user-register';
//   static var getDivisionsEndPoint = '$baseUrl/get-divisions';
//   static var getDistrictsEndPoint = '$baseUrl/get-districts';
//   static var getCustomerCodeEndPoint = '$baseUrl/generate-customercode';
//   //end

//   //home Api All Detail & Categories
//   static var getcategoriesEndPoint = '$baseUrl/get-categories';
//   static var updatecategoriesEndPoint = '$baseUrl/update-categories';
//   static var deletecategoriesEndPoint = '$baseUrl/delete-categories';
//   static var addcategoriesEndPoint = '$baseUrl/add-categories';
//   static var getProductsEndPoint = '$baseUrl/get-products';
//   static var updateProductsEndPoint = '$baseUrl/update-products';
//   static var deleteProductsEndPoint = '$baseUrl/delete-products';
//   //end

//   // Engineers Support Page Api ALL
//   static var getProductEngineeringEndPoint = '$baseUrl/get-engineersuport';
//   static var addEngineerSuportEndPoint = '$baseUrl/add-engineersuport';
//   static var updateEngineerSuportEndPoint = '$baseUrl/update-engineersuport';
//   static var deleteEngineerSuportEndPoint = '$baseUrl/delete-engineersuport';
//   //end

//   //Sales Your Old Machine Page Api ALl
//   static var getClientPostEndPoint = '$baseUrl/get-clientpost';
//   static var addClientpostEndPoint = '$baseUrl/add-clientpost';
//   static var generateClientPostCodeEndPoint = '$baseUrl/generate-clientpostcode';
//   //end

//   //extra
//   // static var getProductEngineeringEndPoint = '$baseUrl/get-engineersuport';
//   //   static String getCategoryProduct(String productId) {
//   //   return '$baseUrl/get-products/$productId';
//   // }
// }
