import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotOtpVerifyInLogin extends StatelessWidget{

  final ForgoOtpVerifyInLoginController controller = Get.put(ForgoOtpVerifyInLoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
        const BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
        child: SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomBackButtonAppBar(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Verification Code',
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(color: AppTheme.whiteColor, fontSize: 25, fontFamily: AppFontFamily.generalSansMedium),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Obx(() =>
                      Text(
                        'Please enter the verification code sent to ${controller.email.value}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppTheme.whiteColor, fontFamily: AppFontFamily.generalSansRegular),
                        textAlign: TextAlign.center,
                      ),
                  ),
                ),
                const SizedBox(height: 60),
                Flexible(
                  flex: 2,
                  child: Material(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: controller.formKey,
                        child: GetBuilder<ForgoOtpVerifyInLoginController>(
                          builder: (context) {
                            return Column(
                              children: [
                                WidgetDesigns.hBox(20),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Pinput(
                                      controller: controller.otpController,
                                      length: 5,
                                      onChanged: (value) => controller.updateOtpError(''),
                                      errorTextStyle: WidgetDesigns.errorTextStyle(),
                                      forceErrorState: true,
                                      validator: (value) {
                                        if(controller.otpController.text == "" || controller.otpController.text.isEmpty){
                                          return "Enter OTP";
                                        }
                                        return null;
                                      },
                                      defaultPinTheme: PinTheme(
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(60),
                                              color: Color(0xffF4F5F7))),
                                    ),
                                    Obx(() {
                                      return controller.otpError.value !=""?Text(controller.otpError.value,style: WidgetDesigns.errorTextStyle(),).paddingOnly(top: 10):SizedBox();
                                    },),
                                  ],
                                ),
                                WidgetDesigns.hBox(30),
                                CustomAnimatedButton(
                                  onTap: () {
                                    if(controller.formKey.currentState!.validate()){
                                      controller.verifyOtp();
                                    }
                                  },
                                  text: 'Verify',
                                ),

                                const SizedBox(height: 20),
                                Obx(() => TextButton(
                                  onPressed: controller.resendEnabled.value ? () {
                                    // Reset timer and resend OTP
                                    controller.startTimer();
                                    controller.otpController.clear();
                                    controller.otpError.value ='';
                                    controller.resendOTPForEmail();
                                  } : null,
                                  child: Text(
                                    controller.resendEnabled.value
                                        ? 'Resend Code'
                                        : 'Resend Code in ${controller.remainingTime.value}s',
                                    style: TextStyle(
                                      color: controller.resendEnabled.value
                                          ? AppTheme.primaryColor
                                          : Colors.grey,
                                      decoration: controller.resendEnabled.value
                                          ? TextDecoration.underline
                                          : null,
                                      decorationColor: AppTheme.primaryColor,
                                      decorationThickness: 2,
                                    ),
                                  ),
                                )),
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

}