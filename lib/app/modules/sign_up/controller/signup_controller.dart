import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController{

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
  RxString countryString = "+267".obs;

  updateCountryString(String value){
    countryString.value = value;
  }

  var firstNameError= "".obs;
  updateFirstNameError(String value) {
    firstNameError.value = value;
    update();
  }

  var lastNameError="".obs;
  updateLastNameError(String value) {
    lastNameError.value = value;
    update();
  }

  var emailError="".obs;
  updateEmailError(String value) {
    emailError.value = value;
    update();
  }

  var phoneError="".obs;
  updatePhoneError(String value) {
    phoneError.value = value;
    update();
  }

  var otpError="".obs;
  updateOTPError(String value) {
    otpError.value = value;
    update();
  }

  var dobError="".obs;
  updateDOBError(String value) {
    dobError.value = value;
    update();
  }

  var passwordError="".obs;
  updatePasswordError(String value) {
    passwordError.value = value;
    update();
  }

  var addressError="".obs;
  updateAddressError(String value) {
    addressError.value = value;
    update();
  }

  RxBool obscurePassword = true.obs;
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
    update();
  }


  final resendEnabled = false.obs;
  final remainingTime = 60.obs;
  Timer? _timer;

  RxString loginType = ''.obs; // this line

// Timer methods
  void startTimer() {
    resendEnabled.value = false;
    remainingTime.value = 60;
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }

  void stopTimer() {
    resendEnabled.value = false;
    _timer?.cancel();
    _timer = null;
  }

  void handleGoogleSignInArguments() {
    if (Get.arguments != null) {
      final email = Get.arguments['email'] ?? "";
      final isVerified = Get.arguments['isVerified'] ?? false;
      final loginTypeArg = Get.arguments['loginType'] ?? ""; // Add this line

      print("===================$email && $isVerified &&  $loginTypeArg=================");

      if (email != null && email != '') {
        emailController.text = email;
        disableEmailField.value = true;

        if (isVerified) {
          isEmailVerified.value = true;
          verifiedEmail.value = email;
        }
      }
      // this line
      if (loginTypeArg != null && loginTypeArg != '') {
        loginType.value = loginTypeArg;
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
        storageServices.saveDriverID(driverId);
      }
    }
  }


  Map<String, dynamic>? locationAddress;

  // Generate OTP for Phone
  /*Future<void> generateOTPForPhone() async {
    updatePhoneError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "phone",
        "otpType": "generate",
        "phone": phoneController.text,
        "country_code": countryCode.value,
        "id": storageServices.getDriverID()
      };

      final response = await _repository.getPhoneOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        customOtpDialog("${countryString.value} ${phoneController.text}", Get.context, "phone");
        print(response.message);
        storageServices.saveMobile(phoneController.text.toString());
        storageServices.saveDriverID("${response.updatedUser?.id}");
        driverId = "${response.updatedUser?.id}";
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else if(response.status == false && response.type == "phone"){
        LoadingOverlay().hideLoading();
        print(response.message);
        updatePhoneError(response.message.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Generate OTP');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(message: e.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      print(e);
    } finally {
      LoadingOverlay().hideLoading();
    }
  }*/

  Future<void> generateOTPForPhone() async {
    updatePhoneError('');
    LoadingOverlay().showLoading();
    try {
      String? storedPhone = storageServices.getMobile();
      String? storedId = storageServices.getDriverID();
      String idToSend = '';

      // चेक करें कि storage में id और नंबर मौजूद हैं और नया नंबर अलग है तो id खाली भेजें
      if (storedId != null && storedId.isNotEmpty && storedPhone != null && storedPhone.isNotEmpty) {
        if (storedPhone == phoneController.text) {
          idToSend = storedId;
        } else {
          idToSend = '';
        }
      }

      // अगर storage में id मौजूद नहीं है तो id खाली भेजें
      if (storedId == null || storedId.isEmpty) idToSend = '';

      final data = {
        "type": "phone",
        "otpType": "generate",
        "phone": phoneController.text,
        "country_code": countryString.value.replaceAll("+", ""),
        "id": idToSend
      };

      final response = await _repository.getPhoneOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        customOtpDialog("${countryString.value} ${phoneController.text}", Get.context, "phone");
        print(response.message);
        // नया नंबर और id storage में सेव करें
        storageServices.saveMobile(phoneController.text);
        storageServices.saveDriverID("${response.updatedUser?.id}");
        driverId = "${response.updatedUser?.id}";
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      } else if (response.status == false && response.type == "phone") {
        LoadingOverlay().hideLoading();
        print(response.message);
        updatePhoneError(response.message.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      } else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Generate OTP');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(message: e.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
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

      final response = await _repository.verifyOTpForPhone(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        isPhoneVerified.value = true;
        verifiedPhone.value = "${countryString.value}${phoneController.text}";
        if (Get.isDialogOpen == true) {
          Get.back();
        }
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else if(response.status == false &&  response.type.toString() == "phone"){
        LoadingOverlay().hideLoading();
        print(response.message);
        updateOTPError(response.message.toString());
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Verify OTP');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
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
    updateEmailError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "email",
        "otpType": "generate",
        "email": emailController.text,
        "id": storageServices.getDriverID()
      };
      final response = await _repository.getEmailOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        customOtpDialog(emailController.text, Get.context, "email");
        print(response.message);
        driverId = "${response.updatedUser?.id}";
        storageServices.saveDriverID("${response.updatedUser?.id}");
        storageServices.saveEmail(emailController.text.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else if(response.status == false && response.type == 'email'){
        LoadingOverlay().hideLoading();
        print(response.message);
        updateEmailError(response.message.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Generate OTP');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(message: e.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
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
        "id": driverId
      };

      final response = await _repository.verifyOTpForPhone(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        isEmailVerified.value = true;
        verifiedEmail.value = emailController.text;
        update();
        if (Get.isDialogOpen!) {
          Get.back();
        }
        storageServices.saveDriverID("${response.updatedUser?.id}");
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else if(response.status == false && response.type.toString() == "email"){
        LoadingOverlay().hideLoading();
        print(response.message);
        updateOTPError(response.message.toString() ?? "Something Went Wrong");
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Verify OTP');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
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

    if (isPhoneVerified.value==false) {
      phoneError.value = "Please verify phone no.";
      update();
      return;
    }else if (isEmailVerified.value==false) {
      emailError.value = "Please verify email address";
      update();
      return;
    }

    if (loginType.value != 'google' && passwordController.text.isEmpty) {
      updatePasswordError("Password is required");
      return;
    }

    LoadingOverlay().showLoading();
    String? fcmToken = await storageServices.returnFCMToken();
    try{
      final data = {
        "id": storageServices.getDriverID(),
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "dob": dobController.text,
        "latitude": locationAddress?['lat'].toString(),
        "longitude": locationAddress?['lng'].toString(),
        "address": locationController.text,
        "fcm_token": fcmToken ?? '',
        "phone": phoneController.text,
        "country_code": countryString.value
      };

      // Only add password if loginType is not google
      if (loginType.value != 'google') {
        data["password"] = passwordController.text;
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
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.toNamed(Routes.deliveryMethodScreen);
      }
      else if(response.status == false && response.type == 'first_name'){
        LoadingOverlay().hideLoading();
        updateFirstNameError(response.message.toString());
        print(response.message);
      }
      else if(response.status == false && response.type == 'last_name'){
        LoadingOverlay().hideLoading();
        updateLastNameError(response.message.toString());
        print(response.message);
      }
      else if(response.status == false && response.type == 'dob'){
        LoadingOverlay().hideLoading();
        updateDOBError(response.message.toString());
        print(response.message);
      }
      /*else if(response.status == false && response.type == 'password'){
        LoadingOverlay().hideLoading();
        updatePasswordError(response.message.toString());
        print(response.message);
      }*/
      else if(response.status == false && response.type == 'address'){
        LoadingOverlay().hideLoading();
        updateAddressError(response.message.toString());
        print(response.message);
      }
      else if(response.status == false && response.type == 'phone'){
        LoadingOverlay().hideLoading();
        updatePhoneError(response.message.toString());
        print(response.message);
      }
      else if(response.status == false && response.type == 'email'){
        LoadingOverlay().hideLoading();
        updateEmailError(response.message.toString());
        print(response.message);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Verify OTP');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }catch(e){
      LoadingOverlay().hideLoading();
      WidgetDesigns.consoleLog(e.toString(), 'Error While Verify OTP');
    }finally{
      LoadingOverlay().hideLoading();
    }
  }

  // Resend OTP For Phone
  Future<void> resendOTPForPhone(String type, String title) async {
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": type,
        "otpType": title,
      };

      final response = await _repository.resendOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else if(response.status == false){
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      }
      else {
        LoadingOverlay().hideLoading();
        print(response.message);
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Generate OTP');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
      CustomSnackBar.show(message: e.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
      print(e);
    } finally {
      LoadingOverlay().hideLoading();
    }
  }

  final Map<int, int> countryPhoneDigits = {
    93: 9,    // Afghanistan
    355: 9,   // Albania
    213: 9,   // Algeria
    376: 6,   // Andorra
    244: 9,   // Angola
    1268: 10, // Antigua and Barbuda
    54: 10,   // Argentina
    374: 8,   // Armenia
    61: 9,    // Australia
    43: 10,   // Austria
    994: 9,   // Azerbaijan
    1242: 10, // Bahamas
    973: 8,   // Bahrain
    880: 10,  // Bangladesh
    1246: 10, // Barbados
    375: 9,   // Belarus
    32: 9,    // Belgium
    501: 7,   // Belize
    229: 8,   // Benin
    975: 8,   // Bhutan
    591: 8,   // Bolivia
    387: 8,   // Bosnia and Herzegovina
    267: 8,   // Botswana
    55: 11,   // Brazil
    673: 7,   // Brunei
    359: 9,   // Bulgaria
    226: 8,   // Burkina Faso
    257: 8,   // Burundi
    238: 7,   // Cape Verde
    855: 9,   // Cambodia
    237: 9,   // Cameroon
    1: 10,    // Canada / USA / some Caribbean nations
    236: 8,   // Central African Republic
    235: 8,   // Chad
    56: 9,    // Chile
    86: 11,   // China
    57: 10,   // Colombia
    269: 7,   // Comoros
    242: 9,   // Congo
    506: 8,   // Costa Rica
    385: 9,   // Croatia
    53: 8,    // Cuba
    357: 8,   // Cyprus
    420: 9,   // Czech Republic
    45: 8,    // Denmark
    253: 8,   // Djibouti
    1767: 10, // Dominica
    1809: 10, // Dominican Republic (shared with 1829 and 1849)
    593: 9,   // Ecuador
    20: 10,   // Egypt
    503: 8,   // El Salvador
    240: 9,   // Equatorial Guinea
    291: 7,   // Eritrea
    372: 7,   // Estonia
    251: 9,   // Ethiopia
    679: 7,   // Fiji
    358: 10,  // Finland
    33: 9,    // France
    241: 7,   // Gabon
    220: 7,   // Gambia
    995: 9,   // Georgia
    49: 10,   // Germany
    233: 9,   // Ghana
    30: 10,   // Greece
    1473: 10, // Grenada
    502: 8,   // Guatemala
    224: 9,   // Guinea
    245: 7,   // Guinea-Bissau
    592: 7,   // Guyana
    509: 8,   // Haiti
    504: 8,   // Honduras
    36: 9,    // Hungary
    354: 7,   // Iceland
    91: 10,   // India
    62: 10,   // Indonesia
    98: 10,   // Iran
    964: 10,  // Iraq
    353: 9,   // Ireland
    972: 9,   // Israel
    39: 10,   // Italy
    1876: 10, // Jamaica
    81: 10,   // Japan
    962: 9,   // Jordan
    7: 10,    // Kazakhstan / Russia
    254: 10,  // Kenya
    686: 8,   // Kiribati
    850: 10,  // North Korea
    82: 10,   // South Korea
    965: 8,   // Kuwait
    996: 9,   // Kyrgyzstan
    856: 9,   // Laos
    371: 8,   // Latvia
    961: 8,   // Lebanon
    266: 8,   // Lesotho
    231: 7,   // Liberia
    218: 10,  // Libya
    423: 7,   // Liechtenstein
    370: 8,   // Lithuania
    352: 9,   // Luxembourg
    261: 9,   // Madagascar
    265: 9,   // Malawi
    60: 10,   // Malaysia
    960: 7,   // Maldives
    223: 8,   // Mali
    356: 8,   // Malta
    692: 7,   // Marshall Islands
    222: 8,   // Mauritania
    230: 8,   // Mauritius
    52: 10,   // Mexico
    691: 7,   // Micronesia
    373: 8,   // Moldova
    377: 8,   // Monaco
    976: 8,   // Mongolia
    382: 8,   // Montenegro
    212: 9,   // Morocco
    258: 9,   // Mozambique
    95: 9,    // Myanmar
    264: 9,   // Namibia
    674: 7,   // Nauru
    977: 10,  // Nepal
    31: 9,    // Netherlands
    64: 9,    // New Zealand
    505: 8,   // Nicaragua
    227: 8,   // Niger
    234: 10,  // Nigeria
    389: 8,   // North Macedonia
    47: 8,    // Norway
    968: 8,   // Oman
    92: 10,   // Pakistan
    680: 7,   // Palau
    507: 8,   // Panama
    675: 8,   // Papua New Guinea
    595: 9,   // Paraguay
    51: 9,    // Peru
    63: 10,   // Philippines
    48: 9,    // Poland
    351: 9,   // Portugal
    974: 8,   // Qatar
    40: 10,   // Romania
    250: 9,   // Rwanda
    1869: 10, // Saint Kitts and Nevis
    1758: 10, // Saint Lucia
    1784: 10, // Saint Vincent and the Grenadines
    685: 7,   // Samoa
    378: 8,   // San Marino
    239: 7,   // Sao Tome and Principe
    966: 9,   // Saudi Arabia
    221: 9,   // Senegal
    381: 9,   // Serbia
    248: 7,   // Seychelles
    232: 8,   // Sierra Leone
    65: 8,    // Singapore
    421: 9,   // Slovakia
    386: 9,   // Slovenia
    677: 7,   // Solomon Islands
    252: 8,   // Somalia
    27: 9,    // South Africa
    34: 9,    // Spain
    94: 10,   // Sri Lanka
    249: 9,   // Sudan
    597: 7,   // Suriname
    46: 9,    // Sweden
    41: 9,    // Switzerland
    963: 9,   // Syria
    886: 9,   // Taiwan
    992: 9,   // Tajikistan
    255: 9,   // Tanzania
    66: 9,    // Thailand
    228: 8,   // Togo
    676: 7,   // Tonga
    1868: 10, // Trinidad and Tobago
    216: 8,   // Tunisia
    90: 10,   // Turkey
    993: 8,   // Turkmenistan
    688: 7,   // Tuvalu
    256: 9,   // Uganda
    380: 9,   // Ukraine
    971: 9,   // United Arab Emirates
    44: 10,   // United Kingdom
    598: 9,   // Uruguay
    998: 9,   // Uzbekistan
    678: 7,   // Vanuatu
    379: 8,   // Vatican City
    58: 10,   // Venezuela
    84: 10,   // Vietnam
    967: 9,   // Yemen
    260: 9,   // Zambia
    263: 9,   // Zimbabwe
  };

  customOtpDialog(title, context, type)  {
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
              Text("Verification", style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular)),
              Text("Send an OTP to: $title", style: AppFontStyle.text_12_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular)).paddingOnly(bottom: 30),
              Pinput(
                length: 6, controller: otpController,
                onChanged: (value) {
                  updateOTPError('');
                },
                validator: (value) {
                  if(otpController.text == "" || otpController.text.isEmpty){
                    return "Enter OTP";
                  }
                  if(otpController.text.length != 6){
                    return "Enter 6 digit OTP";
                  }
                  return null;
                },
              ),
              Obx(() {
                return otpError.value !=""?Text(otpError.value, style: AppFontStyle.text_12_200(AppTheme.red, fontFamily: AppFontFamily.generalSansRegular), textAlign: TextAlign.start).paddingOnly(top: 10):SizedBox();
              },),
              Obx(() => TextButton(
                onPressed: resendEnabled.value ? () {
                  // Reset timer and resend OTP
                  startTimer();
                  if (type == "phone") {
                    otpController.clear();
                    otpError.value ='';
                    resendOTPForPhone(type, title);
                  } else {
                    resendOTPForPhone(type, title);
                  }
                } : null,
                child: Text(
                  resendEnabled.value
                      ? 'Resend Code'
                      : 'Resend Code in ${remainingTime.value}s',
                  style: TextStyle(
                    color: resendEnabled.value
                        ? AppTheme.primaryColor
                        : Colors.grey,
                    decoration: resendEnabled.value
                        ? TextDecoration.underline
                        : null,
                    decorationColor: AppTheme.primaryColor,
                    decorationThickness: 2,
                  ),
                ),
              )),


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
                        } else{
                          await verifyOTPForEmail();
                        }
                      },
                      text: "Ok",
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
    Uri uri = Uri.https("maps.googleapis.com", "maps/api/place/autocomplete/json", {
      "input": query,
      "key": googleAPIKey,
    });

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
    startTimer();
  }

  double? _latitude;
  double? _longitude;


  void _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      CustomSnackBar.show(message: "Location services are disabled.", tColor: AppTheme.white, color: AppTheme.redText);
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) {
      CustomSnackBar.show(message: "Permission permanently denied.", tColor: AppTheme.white, color: AppTheme.redText);
      return;
    }

    if (permission == LocationPermission.always || permission == LocationPermission.whileInUse) {
      try {
        Position locData = await Geolocator.getCurrentPosition();
        print("Position fetched: ${locData.latitude}, ${locData.longitude}");
        _latitude = locData.latitude;
        _longitude = locData.longitude;

        print("Notifier values: $_latitude, $_longitude");

        WidgetDesigns.consoleLog("Latitude: $_latitude", "");
        WidgetDesigns.consoleLog("Longitude: $_longitude", "");
      } catch (e) {
        CustomSnackBar.show(message: "Error getting location: $e", tColor: AppTheme.white, color: AppTheme.redText);
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
