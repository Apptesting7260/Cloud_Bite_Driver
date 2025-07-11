class AppUrls{

     // static const String baseUrl = 'https://97tzzv24-8000.inc1.devtunnels.ms/driver';
     static const String baseUrl = 'https://api.cloudbitesbw.com/driver';
     // static const String baseUrl = 'http://15.207.201.245:8000/driver';
     static const String imageUrl = "https://cloudbites.s3.af-south-1.amazonaws.com/";

     // Socket URL
     // static const String socketURl = 'http://15.207.201.245:8000/'; // live Socket URl
     static const String socketURl = 'https://api.cloudbitesbw.com/driver';
     // static const String socketURl = 'https://21qkztxl-8000.inc1.devtunnels.ms/';

  static const String verifyUser = "$baseUrl/verifyUser";
  static const String allAddressUrl = "$baseUrl/user-address";
  static const String addNewAddressUrl = "$baseUrl/add-user-address";
  static const String registerAPI = '$baseUrl/register';
  static const String resendOTPAPI = '$baseUrl/resend';
  static const String listDeliveryMethodAPI = '$baseUrl/ListDeliveryMethod';
  static const String selectDeliveryMethodAPI = '$baseUrl/setDeliveryModel';
  static const String documentListAPI = '$baseUrl/Listdocs';
  static const String listPersonalDocument = '$baseUrl/list_personal_documents';
  static const String vehicleDetailsUploadAPI = '$baseUrl/vehicle';
  static const String profilePhotoUploadAPI = '$baseUrl/personalUploads/profile_photo';
  static const String identityPhotoUploadAPI = '$baseUrl/personalUploads/identity';
  static const String licensePhotoUploadAPI = '$baseUrl/personalUploads/license';
  static const String bankDetailsUploadAPI = '$baseUrl/driver-account';
  static const String getDriverDataAPI = '$baseUrl/fetchingDriver';
  static const String loginAPI = '$baseUrl/login';
  static const String editProfile = '$baseUrl/editProfile';
  static const String finalPhaseAPI = '$baseUrl/finalPhase';
  static const String forgetPasswordAPI = '$baseUrl/forgetPassword';
  static const String verifyOTPForgetPassword = '$baseUrl/verifyPassword';
  static const String changeForgetPassword = '$baseUrl/changePassword';
  static const String homeStage = '$baseUrl/forgetStage';
  static const String logoutAPI = '$baseUrl/logout';
  static const String contactSupportAPI = '$baseUrl/support';
  static const String socialLoginAPI = '$baseUrl/socialLogin';
  static const String notificationSetAPI = '$baseUrl/SetNotify';
  static const String deliveryRatingsAPI = '$baseUrl/delivery-and-rating';
  static const String ratingAPI = '$baseUrl/rating';
}