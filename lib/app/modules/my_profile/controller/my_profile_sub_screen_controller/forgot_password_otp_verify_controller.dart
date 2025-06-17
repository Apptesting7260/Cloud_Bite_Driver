import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotPasswordOtpVerifyController extends GetxController{

  TextEditingController otpController = TextEditingController();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  final Repository _repository = Repository();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.value = Get.arguments['email'];
    super.onInit();
  }

  RxString email = ''.obs;
  RxString otpError = "".obs;
  updateOtpError(String value) {
    otpError.value = value;
    update();
  }

  final resendEnabled = false.obs;
  final remainingTime = 60.obs;
  Timer? _timer;

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

  Future<void> verifyOtp() async {
    updateOtpError('');
    LoadingOverlay().showLoading();
    try {
      final data = {
        "type": "verify",
        "email": storageServices.getEmail() != '' ? storageServices.getEmail() : email.value,
        "otp": otpController.text,
      };

      final response = await _repository.verifyOTPForPassword(data);
      if (response.status == true) {
        LoadingOverlay().hideLoading();
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.primaryColor, tColor: AppTheme.white);
        Get.toNamed(Routes.changePasswordScreen, arguments: {"email": email.value});
      }
      else if(response.status == false && response.type == 'verifyAndReset'){
        LoadingOverlay().hideLoading();
        updateOtpError(response.message.toString());
      }
      else {
        LoadingOverlay().hideLoading();
        WidgetDesigns.consoleLog(response.message.toString(), 'Error While Forget Password');
        CustomSnackBar.show(message: response.message.toString(), color: AppTheme.redText, tColor: AppTheme.white);
      }
    } catch (e) {
      LoadingOverlay().hideLoading();
    } finally {
      LoadingOverlay().hideLoading();
    }
  }
}