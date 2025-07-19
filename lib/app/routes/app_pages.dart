import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/screens/my_profile_sub_screens/deliveries_screen.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/screens/my_profile_sub_screens/earning_screen.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/screens/my_profile_sub_screens/notification_set.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/screens/my_profile_sub_screens/privacy_policy_screen.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/screens/my_profile_sub_screens/rating_screen.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/screens/my_profile_sub_screens/support_screen.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/screens/my_profile_sub_screens/terms_conditions_screen.dart';
import 'package:cloud_bites_driver/app/modules/no_internet_connection/bindings/no_internet_connection_binding.dart';
import 'package:cloud_bites_driver/app/modules/no_internet_connection/views/no_internet_connection_view.dart';

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
  static const drivingLicenseScreen = '/drivingLicenseScreen';
  static const registrationCompleteScreen = '/registrationCompleteScreen';
  static const homeScreen = '/homeScreen';
  static const myProfileScreen = '/myProfileScreen';
  static const personalDetailsScreen = '/personalDetailsScreen';
  static const editPersonalDetailsScreen = '/editPersonalDetailsScreen';
  static const settingsScreen = '/settingsScreen';
  static const helpCenterScreen = '/helpCenterScreen';
  static const changePasswordProcessScreen = '/changePasswordProcessScreen';
  static const forgotPasswordScreen = '/forgotPasswordScreen';
  static const forgotPasswordOtpVerifyScreen = '/forgotPasswordOtpVerifyScreen';
  static const changePasswordScreen = '/changePasswordScreen';
  static const notificationScreen = '/notificationScreen';
  static const documentsScreen = '/documentsScreen';
  static const myWalletScreen = '/myWalletScreen';
  static const withdrawScreen = '/withdrawScreen';
  static const addNewAddress = '/addNewAddress';
  static const no_internet_connection = '/no-internet-connection';
  static const support = '/support';
  static const notificationSet = '/notificationSet';
  static const privacyPolicy = '/privacyPolicy';
  static const termsCondition = '/termsCondition';
  static const ratings = '/ratings';
  static const earnings = '/earnings';
  static const deliveriesScreen = '/deliveriesScreen';

  static final routes = [
    GetPage(name: splash, page: () => SplashScreen(), binding: SplashBinding()),
    GetPage(
        name: onboarding,
        page: () => OnboardingScreen(),
        binding: OnboardingBinding()),
    GetPage(
        name: welcome,
        page: () => WelcomeScreen(),
        binding: WelcomeScreenBinding()),
    GetPage(name: phoneLogin, page: () => PhoneLoginView()),
    GetPage(name: phoneLoginOtpVerify, page: () => PhoneOtpVerifyScreen()),
    GetPage(name: emailLogin, page: () => EmailLoginScreen()),
    GetPage(
        name: forgotPasswordInLogin, page: () => ForgotPasswordScreenInLogin()),
    GetPage(name: forgotOtpVerifyInLogin, page: () => ForgotOtpVerifyInLogin()),
    GetPage(
        name: changePasswordInLogin, page: () => ChangePasswordInLoginScreen()),
    GetPage(
        name: signUpScreen,
        page: () => SignUpScreen(),
        binding: SignupBinding()),
    GetPage(name: deliveryMethodScreen, page: () => DeliveryMethodScreen()),
    GetPage(
        name: documentVerificationScreen,
        page: () => DocumentVerificationScreen()),
    GetPage(
        name: personalDocumentsScreen, page: () => PersonalDocumentScreen()),
    GetPage(name: vehicleDetailsScreen, page: () => VehicleDetailsScreen()),
    GetPage(name: bankDetailsScreen, page: () => BankDetailsScreen()),
    GetPage(name: profilePhotoScreen, page: () => ProfilePhotoScreen()),
    GetPage(
        name: identityVerificationScreen,
        page: () => IdentityVerificationScreen()),
    GetPage(name: drivingLicenseScreen, page: () => DrivingLicenseScreen()),
    GetPage(
        name: registrationCompleteScreen,
        page: () => RegistrationCompleteScreen()),
    GetPage(name: homeScreen, page: () => HomeScreen()),
    GetPage(name: myProfileScreen, page: () => MyProfileScreen()),
    GetPage(name: personalDetailsScreen, page: () => PersonalDetailsScreen()),
    GetPage(name: editPersonalDetailsScreen, page: () => EditPerosnalDetails()),
    GetPage(name: settingsScreen, page: () => SettingsScreen()),
    GetPage(name: helpCenterScreen, page: () => HelpCenterScreen()),
    GetPage(
        name: changePasswordProcessScreen,
        page: () => ChangePasswordProcessScreen()),
    GetPage(name: forgotPasswordScreen, page: () => ForgotPasswordScreen()),
    GetPage(
        name: forgotPasswordOtpVerifyScreen,
        page: () => ForgotPasswordOtpVerifyScreen()),
    GetPage(name: changePasswordScreen, page: () => ChangePasswordScreen()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: documentsScreen, page: () => DocumentsScreen()),
    GetPage(name: myWalletScreen, page: () => MyWalletScreen()),
    GetPage(name: withdrawScreen, page: () => WithdrawScreen()),
    GetPage(name: addNewAddress, page: () => AddNewAddress()),
    GetPage(
      name: no_internet_connection,
      page: () => NoInternetConnectionView(),
      binding: NoInternetConnectionBinding(),
    ),
    GetPage(name: support, page: () => SupportScreen()),
    GetPage(name: notificationSet, page: () => NotificationSettingsScreen()),
    GetPage(name: Routes.privacyPolicy, page: () => PrivacyPolicyScreen()),
    GetPage(name: Routes.termsCondition, page: () => TermsCondtion()),
    GetPage(name: Routes.ratings, page: () => RatingScreen()),
    GetPage(name: Routes.earnings, page: () => EarningsScreen()),
    GetPage(name: Routes.deliveriesScreen, page: () => DeliveriesScreen()),
  ];
}
