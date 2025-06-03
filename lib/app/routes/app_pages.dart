import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/bank_details/screen/bank_details_screen.dart';
import 'package:cloud_bites_driver/app/modules/personal_documents/screen/identity_verification/screen/identity_verification_screen.dart';
import 'package:cloud_bites_driver/app/modules/personal_documents/screen/profile_photo/screen/profile_photo_screen.dart';
import 'package:cloud_bites_driver/app/modules/vehicle_details/screen/vehicle_detail_screen.dart';


class Routes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const welcome = '/welcome';
  static const phoneLogin = '/login';
  static const phoneLoginOtpVerify = '/phoneLoginOtpVerify';
  static const emailLogin = '/emailLogin';
  static const forgotPasswordInLogin = '/forgotPasswordInLogin';
  static const forgotOtpVerifyInLogin = '/forgotOtpVerifyInLogin';
  static const changePasswordInLogin = '/changePasswordInLogin';
  static const signUpScreen = '/signUpScreen';
  static const deliveryMethodScreen = '/deliveryMethodScreen';
  static const documentVerificationScreen = '/documentVerificationScreen';
  static const personalDocumentsScreen = '/personalDocumentsScreen';
  static const vehicleDetailsScreen = '/vehicleDetailsScreen';
  static const bankDetailsScreen = '/bankDetailsScreen';
  static const profilePhotoScreen = '/profilePhotoScreen';
  static const identityVerificationScreen = '/identityVerificationScreen';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen()),
    GetPage(name: onboarding, page: () => OnboardingScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: phoneLogin, page: () => PhoneLoginView()),
    GetPage(name: phoneLoginOtpVerify, page: () => PhoneOtpVerifyScreen()),
    GetPage(name: emailLogin, page: () => EmailLoginScreen()),
    GetPage(name: forgotPasswordInLogin, page: () => ForgotPasswordScreen()),
    GetPage(name: forgotOtpVerifyInLogin, page: () => ForgotOtpVerifyInLogin()),
    GetPage(name: changePasswordInLogin, page: () => ChangePasswordScreen()),
    GetPage(name: signUpScreen, page: () => SignUpScreen()),
    GetPage(name: deliveryMethodScreen, page: () => DeliveryMethodScreen()),
    GetPage(name: documentVerificationScreen, page: () => DocumentVerificationScreen()),
    GetPage(name: personalDocumentsScreen, page: () => PersonalDocumentScreen()),
    GetPage(name: vehicleDetailsScreen, page: () => VehicleDetailsScreen()),
    GetPage(name: bankDetailsScreen, page: () => BankDetailsScreen()),
    GetPage(name: profilePhotoScreen, page: () => ProfilePhotoScreen()),
    GetPage(name: identityVerificationScreen, page: () => IdentityVerificationScreen()),
  ];
}
