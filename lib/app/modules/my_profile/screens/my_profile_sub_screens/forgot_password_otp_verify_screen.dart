import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotPasswordOtpVerifyScreen extends StatelessWidget{

  final ForgotPasswordOtpVerifyController controller = Get.put(ForgotPasswordOtpVerifyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: AppTheme.white),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Verification Code',
                    style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                  ),
                  WidgetDesigns.hBox(20),
                  Text(
                    'Please enter the verification code sent to',
                    style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                  ),
                  Text(
                    'example@gmail.com',
                    style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                  ),
                  WidgetDesigns.hBox(20.0),
                  Pinput(
                    length: 6,
                    controller: controller.otpController,
                    defaultPinTheme: PinTheme(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Color(0xffF4F5F7)
                        )
                    ),
                    onChanged: (value) => controller.updateOtpError(''),
                    validator: (value) {
                      if(value == '' || value!.isEmpty){
                        return 'Please Enter Otp';
                      }
                      if(value.length != 6){
                        return 'Please Enter 6 digit Otp';
                      }
                      return null;
                    },
                  ),
                  WidgetDesigns.hBox(30.0),
                  CustomAnimatedButton(
                      onTap: () {
                        Get.toNamed(Routes.changePasswordScreen);
                      },
                      text: 'Verify'
                  ),
                  WidgetDesigns.hBox(20.0),
                ],
              ),
              Obx(() => TextButton(
                onPressed: controller.resendEnabled.value
                    ? controller.resendOtp
                    : null,
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
          ),
        ),
      ),
    );
  }
}