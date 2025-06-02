import 'package:cloud_bites_driver/app/core/app_exports.dart';


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
  ];
}
