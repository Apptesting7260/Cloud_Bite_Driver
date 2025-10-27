import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  var uid = "";
  // var loginType = "".obs;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final Repository _repository = Repository();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  var driverId = '';

  RxString verifiedPhone = ''.obs;
  RxBool isPhoneVerified = false.obs;

  var disableEmailField = false.obs;
  RxString verifiedEmail = ''.obs;
  RxBool isEmailVerified = false.obs;

  RxInt checkCountryLength = 8.obs;
  updateCountryLength(int value){
    checkCountryLength.value = value;
    update();
  }


  RxString countryString = "+267".obs;
  RxString countryString1 = "+267".obs;

  updateCountryString(String value) {
    if (!value.startsWith("+")) {
      value = "+$value";
    }
    countryString.value = value;
    countryString1.value = value;
  }

  var firstNameError = "".obs;
  updateFirstNameError(String value) {
    firstNameError.value = value;
    update();
  }

  var lastNameError = "".obs;
  updateLastNameError(String value) {
    lastNameError.value = value;
    update();
  }

  var emailError = "".obs;
  updateEmailError(String value) {
    emailError.value = value;
    update();
  }

  var phoneError = "".obs;
  updatePhoneError(String value) {
    phoneError.value = value;
    update();
  }

  var otpError = "".obs;
  updateOTPError(String value) {
    otpError.value = value;
    update();
  }

  var dobError = "".obs;
  updateDOBError(String value) {
    dobError.value = value;
    update();
  }

  var passwordError = "".obs;
  updatePasswordError(String value) {
    passwordError.value = value;
    update();
  }

  var confirmPasswordError = "".obs;
  updateConfirmPasswordError(String value) {
    confirmPasswordError.value = value;
    update();
  }

  var addressError = "".obs;
  updateAddressError(String value) {
    addressError.value = value;
    update();
  }

  RxBool obscurePassword = true.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    update();
  }

  RxBool obscureConfirmPassword = true.obs;
  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
    update();
  }

  final resendEnabled = false.obs;
  final remainingTime = 60.obs;
  Timer? _timer;

  RxString loginType = ''.obs; // this line


  RxBool showContinueWithoutVerify = false.obs;
  RxInt continueWithoutVerifyTime = 60.obs;
  Timer? _continueWithoutVerifyTimer;

  RxBool showDidNotReceiveText = false.obs;
  RxInt didNotReceiveTime = 60.obs;
  Timer? _didNotReceiveTimer;
  RxBool isFirstTime = true.obs;
  RxBool showResendCode = false.obs;

  // Timer methods
  void startTimer() {
    resendEnabled.value = false;
    remainingTime.value = 60;
    showDidNotReceiveText.value = false;
    showContinueWithoutVerify.value = false;
    showResendCode.value = false;

    _timer?.cancel();
    _didNotReceiveTimer?.cancel();
    _continueWithoutVerifyTimer?.cancel();

    // First timer for "Resend Code in Xs"
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        // First timer complete - show "Resend Code" button
        resendEnabled.value = true;
        showResendCode.value = true;
        timer.cancel();
      }
    });
  }

  void startDidNotReceiveTimer() {
    showDidNotReceiveText.value = true;
    didNotReceiveTime.value = 60;
    showResendCode.value = false;

    _didNotReceiveTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (didNotReceiveTime.value > 0) {
        didNotReceiveTime.value--;
      } else {
        // "Didn't receive the text?" timer complete - show "Continue without verifying"
        showDidNotReceiveText.value = false;
        showContinueWithoutVerify.value = true;
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    resendEnabled.value = false;
    showDidNotReceiveText.value = false;
    showContinueWithoutVerify.value = false;
    showResendCode.value = false;
    _timer?.cancel();
    _didNotReceiveTimer?.cancel();
    _continueWithoutVerifyTimer?.cancel();
    _timer = null;
    _didNotReceiveTimer = null;
    _continueWithoutVerifyTimer = null;
  }

  void handleGoogleSignInArguments() {
    if (Get.arguments != null) {
      print('${Get.arguments}---------------------------');
      uid = Get.arguments['id'] ?? "";
      final email = Get.arguments['email'] ?? "";
      final isVerified = Get.arguments['isVerified'] ?? false;
      final loginTypeArg = Get.arguments['loginType'] ?? "";
      var data = Get.arguments['data'] ?? UpdatedUser()  as UpdatedUser;
      final hasEmail = Get.arguments['hasEmail'] ?? true;
      final phone = Get.arguments['phone'] ?? "";
      final country = Get.arguments['country_code'] ?? '+267';
      updateCountryString(country);
      print("phone ${phone}");

      print("country code: ${countryString.value}");
      if(data.otpVerified==true){
        isPhoneVerified.value = true;
        phoneController.text = phone;
        countryString.value = country;
      }else{
        isPhoneVerified.value = false;

      }
      verifiedPhone.value = "${countryString.value}${phoneController.text}";

      final firstName = Get.arguments['firstName'] ?? '';
      final lastName = Get.arguments['lastName'] ?? '';

      print("---------------------${data.toString()}");

      if (firstName.isNotEmpty) {
        firstNameController.text = firstName;
      }
      if (lastName.isNotEmpty) {
        lastNameController.text = lastName;
      }

      if (data != null) {
        if (firstNameController.text.isEmpty && data.firstName != null) {
          firstNameController.text = data.firstName ?? '';
        }
        if (lastNameController.text.isEmpty && data.lastName != null) {
          lastNameController.text = data.lastName ?? '';
        }
      }


      print(
        "===================$email && $isVerified &&  $loginTypeArg=================",
      );

     /* if (email != null && email != '') {
        emailController.text = email;
        disableEmailField.value = true;

        if (isVerified) {
          isEmailVerified.value = true;
          verifiedEmail.value = email;
        }
      }*/

      if (hasEmail && email != null && email != '') {
        emailController.text = email;
        disableEmailField.value = true;

        if (isVerified) {
          isEmailVerified.value = true;
          verifiedEmail.value = email;
        }
      } else {
        // If no email from social provider, allow user to enter email
        disableEmailField.value = false;
        isEmailVerified.value = false;
      }
      // this line
      if (loginTypeArg != null && loginTypeArg != '') {
        loginType.value = loginTypeArg;
        update();
      }
    }
  }

  void handlePhoneVerificationArguments() {
    if (Get.arguments != null && Get.arguments['isPhoneVerified'] == true) {
      phoneController.text = Get.arguments['phone'] ?? '';
      updateCountryString("+${Get.arguments['countryCode']}");
      //countryString.value = Get.arguments['countryCode'] ?? "91";
      isPhoneVerified.value = true;
      verifiedPhone.value = "${countryString.value}${phoneController.text}";

      if (Get.arguments['driverId'] != null) {
        driverId = Get.arguments['driverId'];
      }
    }
  }

  Map<String, dynamic>? locationAddress;

  // Generate OTP for Phone

  Future<void> generateOTPForPhone() async {
    String? fcmToken = await storageServices.returnFCMToken();
    updatePhoneError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "phone",
        "otpType": "generate",
        "phone": phoneController.text,
        "country_code": countryString.value.replaceAll("+", ""),
        "fcm_token": fcmToken ?? '',
      };
      data.addIf(uid != "", "id", uid);
      print("uid --- $uid");
      print(data);

      final response = await _repository.getPhoneOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        isFirstTime .value =  true;
        if (response.updatedUser?.id != null && response.updatedUser!.id!.isNotEmpty) {
          uid = response.updatedUser!.id!;
          driverId = uid;
          print("Updated uid from response: $uid");
        }
        customOtpDialog(
          "${countryString.value} ${phoneController.text}",
          Get.context,
          "phone",
        );
        print(response.message);

        driverId = "${response.updatedUser?.id}";
        // uid = driverId;
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else if (response.status == false && response.type == "phone") {
        LoadingOverlay().hideLoading();
        print(response.message);
        updatePhoneError(response.message.toString());
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(
          response.message.toString(),
          'Error While Generate OTP',
        );
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(
        message: e.toString(),
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
      print(e);
    } finally {
      update();

      LoadingOverlay().hideLoading();
    }
  }

  // Verify OTP for Phone
  Future<void> verifyOTPForPhone() async {
    String? fcmToken = await storageServices.returnFCMToken();
    updateOTPError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "phone",
        "otpType": "verify",
        "phone": phoneController.text,
        "otp": otpController.text,
        "country_code": countryString.value.replaceAll("+", ""),
        "fcm_token": fcmToken ?? '',
      };
      data.addIf(uid != "", "id", uid);

      final response = await _repository.verifyOTpForPhone(data);
      if (response.status == true) {
        uid = response.updatedUser?.id ?? '';
        LoadingOverlay().hideLoading();
        isPhoneVerified.value = true;
        verifiedPhone.value = "${countryString.value}${phoneController.text}";
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else if (response.status == false &&
          response.type.toString() == "phone") {
        LoadingOverlay().hideLoading();
        print(response.message);
        updateOTPError(response.message.toString());
      } else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(
          response.message.toString(),
          'Error While Verify OTP',
        );
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      print(e);
    } finally {
      update();
      LoadingOverlay().hideLoading();
    }
  }

  // Generate OTP for Email
  Future<void> generateOTPForEmail() async {
    String? fcmToken = await storageServices.returnFCMToken();
    updateEmailError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "email",
        "otpType": "generate",
        "email": emailController.text,
        "fcm_token": fcmToken ?? '',
      };
      data.addIf(uid != "", "id", uid);

      final response = await _repository.getEmailOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        customOtpDialog(emailController.text, Get.context, "email");

        driverId = "${response.updatedUser?.id}";
        // uid = driverId;
        /* storageServices.saveDriverID("${response.updatedUser?.id}");
        storageServices.saveEmail(emailController.text.toString());
       */
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else if (response.status == false && response.type == 'email') {
        LoadingOverlay().hideLoading();
        print(response.message);
        updateEmailError(response.message.toString());
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else {
        LoadingOverlay().hideLoading();

        WidgetDesigns.consoleLog(
          response.message.toString(),
          'Error While Generate OTP',
        );
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(
        message: e.toString(),
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
      print(e);
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

  // Verify OTP for Email
  Future<void> verifyOTPForEmail() async {
    updateOTPError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "email",
        "otpType": "verify",
        "email": emailController.text,
        "otp": otpController.text,
      };
      data.addIf(uid != "", "id", uid);

      final response = await _repository.verifyOTpForPhone(data);
      if (response.status == true) {
        uid = response.updatedUser?.id ?? '';
        LoadingOverlay().hideLoading();
        print(response.message);
        isEmailVerified.value = true;
        verifiedEmail.value = emailController.text;
        update();
        if (Get.isDialogOpen!) {
          Get.back();
        }
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else if (response.status == false &&
          response.type.toString() == "email") {
        LoadingOverlay().hideLoading();
        print(response.message);
        updateOTPError(response.message.toString() ?? "Something Went Wrong");
      } else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(
          response.message.toString(),
          'Error While Verify OTP',
        );
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      print(e);
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

  void clearSignupToken() {
    if (storageServices.getToken().isNotEmpty) {
      storageServices.removeToken();
    }
  }

  Future<void> continueWithoutVerification() async {
    LoadingOverlay().showLoading();
    try {
      final data = {
         "id": uid
      };
      data.addIf(uid != "", "id", uid);
      final response = await _repository.signupWithoutVerifyModel(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        isPhoneVerified.value = true;
        stopTimer();
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        CustomSnackBar.show(
          message: "${response.message}",
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(
          message: response.message ?? "Failed to continue without verification",
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      // Even if API fails, allow user to continue
      isPhoneVerified.value = true;
      stopTimer();
      if (Get.isDialogOpen == true) {
        Get.back();
      }
      CustomSnackBar.show(
        message: "You can continue without phone verification",
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
    }
  }

  // Register API
  Future<void> registerDriverAPI() async {
    updateFirstNameError('');
    updateLastNameError('');
    updateEmailError('');
    updatePhoneError('');
    updateDOBError('');
    updateOTPError('');
    updateAddressError('');
    updatePasswordError('');
    updateConfirmPasswordError('');

    if (isPhoneVerified.value == false) {
      phoneError.value = "Please verify phone no.";
      update();
      return;
    } else if (isEmailVerified.value == false) {
      emailError.value = "Please verify email address";
      update();
      return;
    }

    if (loginType.value != 'google' && loginType.value != 'apple' && loginType.value != 'facebook' && passwordController.text.isEmpty) {
      updatePasswordError("Password is required");
      return;
    }
    if (loginType.value != 'google' && loginType.value != 'apple' && loginType.value != 'facebook' && confirmPasswordController.text.isEmpty) {
      updatePasswordError("Confirm Password is required");
      return;
    }

    LoadingOverlay().showLoading();
    String? fcmToken = await storageServices.returnFCMToken();
    try {
      final data = {
        "id": uid,
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "dob": dobController.text,
        "latitude": locationAddress?['lat'].toString(),
        "longitude": locationAddress?['lng'].toString(),
        "address": locationController.text,
        "fcm_token": fcmToken ?? '',
        "phone": phoneController.text,
        "country_code": countryString.value.replaceAll("+", ""),
      };


      // Only add password if loginType is not google
      if (loginType.value != 'google' && loginType.value != 'facebook' && loginType.value != 'apple') {
        data["password"] = passwordController.text;
        data["confirm_password"] = confirmPasswordController.text;
      }

      final response = await _repository.registerDriverAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        storageServices.saveStages("${response.data?.stages.toString()}");
        storageServices.saveDriverID("${response.data?.id}");
        storageServices.saveFirstName("${response.data?.firstName}");
        storageServices.saveLastName("${response.data?.lastName}");
        storageServices.saveAddress("${response.data?.address}");
        storageServices.saveDOB("${response.data?.dateOfBirth}");
        storageServices.saveToken("${response.loginToken}");
        storageServices.saveEmail("${response.data?.email}");
        storageServices.saveMobile("${response.data?.phone}");

        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
        Get.toNamed(Routes.deliveryMethodScreen);
      } else if (response.status == false && response.type == 'first_name') {
        LoadingOverlay().hideLoading();
        updateFirstNameError(response.message.toString());
        print(response.message);
      } else if (response.status == false && response.type == 'last_name') {
        LoadingOverlay().hideLoading();
        updateLastNameError(response.message.toString());
        print(response.message);
      } else if (response.status == false && response.type == 'dob') {
        LoadingOverlay().hideLoading();
        updateDOBError(response.message.toString());
        print(response.message);
      } else if (response.status == false && response.type == 'address') {
        LoadingOverlay().hideLoading();
        updateAddressError(response.message.toString());
        print(response.message);
      } else if (response.status == false && response.type == 'phone') {
        LoadingOverlay().hideLoading();
        updatePhoneError(response.message.toString());
        print(response.message);
      } else if (response.status == false && response.type == 'email') {
        LoadingOverlay().hideLoading();
        updateEmailError(response.message.toString());
        print(response.message);
      } else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(
          response.message.toString(),
          'Error While Verify OTP',
        );
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      WidgetDesigns.consoleLog(e.toString(), 'Error While Verify OTP');
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

  // Resend OTP For Phone
  /*Future<void> resendOTPForPhone(String type, String title) async {
    LoadingOverlay().showLoading();
    try {
      final data = {"type": type, "otpType": title};
      final response = await _repository.resendOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else if (response.status == false) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(
          response.message.toString(),
          'Error While Generate OTP',
        );
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(
        message: e.toString(),
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
      print(e);
    } finally {
      LoadingOverlay().hideLoading();
    }
  }*/
// Resend OTP method ko replace karen
  Future<void> resendOTPForPhone(String type, String title) async {
    LoadingOverlay().showLoading();
    try {
      final data = {"type": type, "otpType": title};
      final response = await _repository.resendOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);

        // Mark as not first time and start "Didn't receive the text?" timer
        isFirstTime.value = false;
        startDidNotReceiveTimer();

        CustomSnackBar.show(
          message: "OTP resent successfully",
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else if (response.status == false) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.primaryColor,
          tColor: AppTheme.white,
        );
      } else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(
          response.message.toString(),
          'Error While Generate OTP',
        );
        CustomSnackBar.show(
          message: response.message.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white,
        );
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(
        message: e.toString(),
        color: AppTheme.primaryColor,
        tColor: AppTheme.white,
      );
      print(e);
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

  final Map<int, int> countryPhoneDigits = {
    93: 9, // Afghanistan
    355: 9, // Albania
    213: 9, // Algeria
    376: 6, // Andorra
    244: 9, // Angola
    1268: 10, // Antigua and Barbuda
    54: 10, // Argentina
    374: 8, // Armenia
    61: 9, // Australia
    43: 10, // Austria
    994: 9, // Azerbaijan
    1242: 10, // Bahamas
    973: 8, // Bahrain
    880: 10, // Bangladesh
    1246: 10, // Barbados
    375: 9, // Belarus
    32: 9, // Belgium
    501: 7, // Belize
    229: 8, // Benin
    975: 8, // Bhutan
    591: 8, // Bolivia
    387: 8, // Bosnia and Herzegovina
    267: 8, // Botswana
    55: 11, // Brazil
    673: 7, // Brunei
    359: 9, // Bulgaria
    226: 8, // Burkina Faso
    257: 8, // Burundi
    238: 7, // Cape Verde
    855: 9, // Cambodia
    237: 9, // Cameroon
    1: 10, // Canada / USA / some Caribbean nations
    236: 8, // Central African Republic
    235: 8, // Chad
    56: 9, // Chile
    86: 11, // China
    57: 10, // Colombia
    269: 7, // Comoros
    242: 9, // Congo
    506: 8, // Costa Rica
    385: 9, // Croatia
    53: 8, // Cuba
    357: 8, // Cyprus
    420: 9, // Czech Republic
    45: 8, // Denmark
    253: 8, // Djibouti
    1767: 10, // Dominica
    1809: 10, // Dominican Republic (shared with 1829 and 1849)
    593: 9, // Ecuador
    20: 10, // Egypt
    503: 8, // El Salvador
    240: 9, // Equatorial Guinea
    291: 7, // Eritrea
    372: 7, // Estonia
    251: 9, // Ethiopia
    679: 7, // Fiji
    358: 10, // Finland
    33: 9, // France
    241: 7, // Gabon
    220: 7, // Gambia
    995: 9, // Georgia
    49: 10, // Germany
    233: 9, // Ghana
    30: 10, // Greece
    1473: 10, // Grenada
    502: 8, // Guatemala
    224: 9, // Guinea
    245: 7, // Guinea-Bissau
    592: 7, // Guyana
    509: 8, // Haiti
    504: 8, // Honduras
    36: 9, // Hungary
    354: 7, // Iceland
    91: 10, // India
    62: 10, // Indonesia
    98: 10, // Iran
    964: 10, // Iraq
    353: 9, // Ireland
    972: 9, // Israel
    39: 10, // Italy
    1876: 10, // Jamaica
    81: 10, // Japan
    962: 9, // Jordan
    7: 10, // Kazakhstan / Russia
    254: 10, // Kenya
    686: 8, // Kiribati
    850: 10, // North Korea
    82: 10, // South Korea
    965: 8, // Kuwait
    996: 9, // Kyrgyzstan
    856: 9, // Laos
    371: 8, // Latvia
    961: 8, // Lebanon
    266: 8, // Lesotho
    231: 7, // Liberia
    218: 10, // Libya
    423: 7, // Liechtenstein
    370: 8, // Lithuania
    352: 9, // Luxembourg
    261: 9, // Madagascar
    265: 9, // Malawi
    60: 10, // Malaysia
    960: 7, // Maldives
    223: 8, // Mali
    356: 8, // Malta
    692: 7, // Marshall Islands
    222: 8, // Mauritania
    230: 8, // Mauritius
    52: 10, // Mexico
    691: 7, // Micronesia
    373: 8, // Moldova
    377: 8, // Monaco
    976: 8, // Mongolia
    382: 8, // Montenegro
    212: 9, // Morocco
    258: 9, // Mozambique
    95: 9, // Myanmar
    264: 9, // Namibia
    674: 7, // Nauru
    977: 10, // Nepal
    31: 9, // Netherlands
    64: 9, // New Zealand
    505: 8, // Nicaragua
    227: 8, // Niger
    234: 10, // Nigeria
    389: 8, // North Macedonia
    47: 8, // Norway
    968: 8, // Oman
    92: 10, // Pakistan
    680: 7, // Palau
    507: 8, // Panama
    675: 8, // Papua New Guinea
    595: 9, // Paraguay
    51: 9, // Peru
    63: 10, // Philippines
    48: 9, // Poland
    351: 9, // Portugal
    974: 8, // Qatar
    40: 10, // Romania
    250: 9, // Rwanda
    1869: 10, // Saint Kitts and Nevis
    1758: 10, // Saint Lucia
    1784: 10, // Saint Vincent and the Grenadines
    685: 7, // Samoa
    378: 8, // San Marino
    239: 7, // Sao Tome and Principe
    966: 9, // Saudi Arabia
    221: 9, // Senegal
    381: 9, // Serbia
    248: 7, // Seychelles
    232: 8, // Sierra Leone
    65: 8, // Singapore
    421: 9, // Slovakia
    386: 9, // Slovenia
    677: 7, // Solomon Islands
    252: 8, // Somalia
    27: 9, // South Africa
    34: 9, // Spain
    94: 10, // Sri Lanka
    249: 9, // Sudan
    597: 7, // Suriname
    46: 9, // Sweden
    41: 9, // Switzerland
    963: 9, // Syria
    886: 9, // Taiwan
    992: 9, // Tajikistan
    255: 9, // Tanzania
    66: 9, // Thailand
    228: 8, // Togo
    676: 7, // Tonga
    1868: 10, // Trinidad and Tobago
    216: 8, // Tunisia
    90: 10, // Turkey
    993: 8, // Turkmenistan
    688: 7, // Tuvalu
    256: 9, // Uganda
    380: 9, // Ukraine
    971: 9, // United Arab Emirates
    44: 10, // United Kingdom
    598: 9, // Uruguay
    998: 9, // Uzbekistan
    678: 7, // Vanuatu
    379: 8, // Vatican City
    58: 10, // Venezuela
    84: 10, // Vietnam
    967: 9, // Yemen
    260: 9, // Zambia
    263: 9, // Zimbabwe
  };

  customOtpDialog(title, context, type) {
    otpController.clear();
    otpError.value = '';
    startTimer();

    return Get.dialog(
      barrierDismissible: false,
      Dialog(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Verification",
                style: AppFontStyle.text_16_400(
                  AppTheme.black,
                  fontFamily: AppFontFamily.generalSansRegular,
                ),
              ),
              Text(
                "Send an OTP to: $title",
                style: AppFontStyle.text_12_400(
                  AppTheme.grey,
                  fontFamily: AppFontFamily.generalSansRegular,
                ),
              ).paddingOnly(bottom: 30),
              Pinput(
                length: 6,
                controller: otpController,
                onChanged: (value) {
                  updateOTPError('');
                },
              ),
              Obx(() {
                return otpError.value != ""
                    ? Text(
                  otpError.value,
                  style: AppFontStyle.text_12_200(
                    AppTheme.red,
                    fontFamily: AppFontFamily.generalSansRegular,
                  ),
                  textAlign: TextAlign.start,
                ).paddingOnly(top: 10)
                    : SizedBox();
              }),

              // PHONE TYPE - COMPLEX FLOW
              if (type == "phone") ...[
                // STAGE 1: "Resend Code in Xs" (First 60 seconds)
                Obx(() {
                  return (!resendEnabled.value && !showResendCode.value)
                      ? TextButton(
                    onPressed: null,
                    child: Text(
                      'Resend Code in ${remainingTime.value}s',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : SizedBox();
                }),

                // STAGE 2: "Resend Code" Button (Clickable after first 60 seconds)
                Obx(() {
                  return (resendEnabled.value && showResendCode.value && isFirstTime.value)
                      ? TextButton(
                    onPressed: () {
                      otpController.clear();
                      otpError.value = '';
                      resendOTPForPhone(type, title);
                    },
                    child: Text(
                      'Resend Code',
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                        decoration: TextDecoration.underline,
                        decorationColor: AppTheme.primaryColor,
                        decorationThickness: 2,
                      ),
                    ),
                  )
                      : SizedBox();
                }),

                // STAGE 3: "Didn't receive the text? Xs" (After resend, 60 seconds)
                Obx(() {
                  return showDidNotReceiveText.value
                      ? TextButton(
                    onPressed: null,
                    child: Text(
                      'Didn\'t receive the text? ${didNotReceiveTime.value}s',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : SizedBox();
                }),

                // STAGE 4: "Continue without verifying" (Final option)
                Obx(() {
                  return showContinueWithoutVerify.value
                      ? Column(
                    children: [
                      SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          continueWithoutVerification();
                        },
                        child: Center(
                          child: Text(
                            "Continue without verifying",
                            style: AppFontStyle.text_14_400(
                              AppTheme.primaryColor,
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                      : SizedBox();
                }),
              ] else if (type == "email") ...[
                Obx(() {
                  return !resendEnabled.value && !showResendCode.value
                      ? TextButton(
                    onPressed: null,
                    child: Text(
                      'Resend Code in ${remainingTime.value}s',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  )
                      : TextButton(
                      onPressed: () {
                        otpController.clear();
                        otpError.value = '';
                        resendOTPForPhone(type, title);
                        startTimer();
                      },
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: AppTheme.primaryColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppTheme.primaryColor,
                          decorationThickness: 2,
                        ),
                      )
                  );
                })
              ],

              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: CustomAnimatedButton(
                      onTap: () {
                        stopTimer();
                        Get.back();
                      },
                      text: "Cancel",
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: CustomAnimatedButton(
                      onTap: () async {
                        if (type == "phone") {
                          await verifyOTPForPhone();
                        } else {
                          await verifyOTPForEmail();
                        }
                      },
                      text: "Verify",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  final GlobalKey addressKey = GlobalKey();
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  RxBool isValidAddress = true.obs;

  String googleAPIKey = "${dotenv.env['googleAPIKey']}";

  Future<List<Predictions>> searchAutocomplete(String query) async {
    Uri uri = Uri.https(
      "maps.googleapis.com",
      "maps/api/place/autocomplete/json",
      {"input": query, "key": googleAPIKey},
    );

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final parse = jsonDecode(response.body);
        if (parse['status'] == "OK") {
          SearchPlaceModel searchPlaceModel = SearchPlaceModel.fromJson(parse);
          return searchPlaceModel.predictions ?? [];
        }
      }
    } catch (err) {
      debugPrint("Error: $err");
    }
    return [];
  }

  Future<void> getLatLang(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      var first = locations.first;
      latitude.value = first.latitude;
      longitude.value = first.longitude;
      debugPrint("Latitude: ${latitude.value}, Longitude: ${longitude.value}");
    }
  }

  @override
  void onInit() {
    super.onInit();
    handlePhoneVerificationArguments();
    handleGoogleSignInArguments();
    _handleLocationPermission(Get.context!);
    // startTimer();
  }

  double? _latitude;
  double? _longitude;

  void _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CustomSnackBar.show(
        message: "Location services are disabled.",
        tColor: AppTheme.white,
        color: AppTheme.redText,
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      CustomSnackBar.show(
        message: "Permission permanently denied.",
        tColor: AppTheme.white,
        color: AppTheme.redText,
      );
      return;
    }

    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      try {
        Position locData = await Geolocator.getCurrentPosition();
        print("Position fetched: ${locData.latitude}, ${locData.longitude}");
        _latitude = locData.latitude;
        _longitude = locData.longitude;

        print("Notifier values: $_latitude, $_longitude");

        WidgetDesigns.consoleLog("Latitude: $_latitude", "");
        WidgetDesigns.consoleLog("Longitude: $_longitude", "");
      } catch (e) {
        CustomSnackBar.show(
          message: "Error getting location: $e",
          tColor: AppTheme.white,
          color: AppTheme.redText,
        );
      }
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    otpController.dispose();
    super.onClose();
  }
}
