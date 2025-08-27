import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/routes/stage_navigator.dart';

class PhoneOtpVerifyController extends GetxController{

  TextEditingController otpController = TextEditingController();
  final resendEnabled = false.obs;
  final remainingTime = 60.obs;
  Timer? _timer;
  final bool _isFormValid = false;
  bool get isFormValid => _isFormValid;
  bool fromSignup = false;


  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  RxString otpError = "".obs;
  updateOtpError(String value) {
    otpError.value = value;
    update();
  }

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxString phoneNo = "".obs;
  RxString otp = "".obs;
  RxString countryString = "".obs;

  @override
  void onInit() {
    phoneNo.value = Get.arguments['phone'].toString();
    otp.value = Get.arguments['otp'].toString();
    countryString.value = Get.arguments['countryString'].toString();
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    _timer?.cancel();
    // otpController.dispose();
    super.onClose();
  }

  void startTimer() {
    resendEnabled.value = false;
    remainingTime.value = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime.value > 0) {
        remainingTime.value--;
      } else {
        resendEnabled.value = true;
        timer.cancel();
      }
    });
  }
  void resendOtp() {
    startTimer();
  }


  Future<void> loginWithPhoneAPI() async {
    String? fcmToken = await storageServices.returnFCMToken();
    updateOtpError('');
    LoadingOverlay().showLoading();
    try{
      final data = {
        "type": "phone",
        "phone": phoneNo.value,
        "country_code": countryString.value,
        "otpType": "verify",
        "otp": otpController.text,
        "id": storageServices.getDriverID(),
        "fcm_token": fcmToken ?? ''
      };

      final response = await _repository.phoneLoginVerifyAPI(data);

      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        response.data?.loginToken != null ? storageServices.saveToken("${response.data?.loginToken}") : storageServices.saveDriverID("${response.data?.id}");
        storageServices.saveToken("${response.data?.loginToken}");
        storageServices.saveStages("${response.data?.stages}");
        storageServices.saveFirstName("${response.data?.firstName}");
        storageServices.saveLastName("${response.data?.lastName}");
        storageServices.saveDriverID("${response.data?.id}");
        storageServices.saveAddress("${response.data?.address}");
        if(response.data?.stages == '1'){
          if(response.data?.otpVerified == true){
            Get.toNamed(Routes.signUpScreen, arguments: {
              "phone": phoneNo.value,
              "countryCode": countryString.value,
              "isPhoneVerified": true,
              "driverId": response.data?.id
            });
          }
        }else{
          StageNavigator.navigateToStage("${response.data?.stages}");
        }
      }
      else if(response.status == false && response.type == 'login'){
        LoadingOverlay().hideLoading();
        updateOtpError(response.message.toString());
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
      else {
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While login');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }

    }
    catch(e){
      print("$e---------3333333");
      LoadingOverlay().hideLoading();
    }
  }

  Future<void> resendOTPForPhone() async {
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "phone",
        "otpType": "+${countryString.value} ${phoneNo.value}",
      };

      final response = await _repository.resendOTPAPI(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        print(response.message);
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        CustomSnackBar.show(message: response.otpCode.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
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

}