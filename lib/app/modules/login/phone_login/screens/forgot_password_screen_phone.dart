import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/login/phone_login/controllers/forgot_password_controller_phone_in_login.dart';

class ForgotPasswordPhoneScreenInLogin extends StatelessWidget{

  final ForgotPasswordControllerPhoneInLogin controller =Get.put(ForgotPasswordControllerPhoneInLogin());

  ForgotPasswordPhoneScreenInLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: CustomBackButtonAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: AppTheme.whiteColor,
                    fontSize: 27,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Enter your registered phone number to receive reset password code',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: AppTheme.whiteColor),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 60),
              Flexible(
                flex: 2,
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        Column(
                          children: [
                            GetBuilder<ForgotPasswordControllerPhoneInLogin>(
                                builder: (context) {
                                  return Form(
                                    key: controller.formKey,
                                    child: GetBuilder<ForgotPasswordControllerPhoneInLogin>(
                                        builder: (controller) {
                                          return CustomTextFormField(
                                            alignLabelWithHint: false,
                                            readOnly: false,
                                            controller: controller.phoneController,
                                            textInputType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(controller.checkCountryLength.value),
                                            ],
                                            prefix: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    CountryCodePicker(
                                                      padding: EdgeInsets.zero,
                                                      flagWidth: 40,
                                                      margin: EdgeInsets.zero,
                                                      flagDecoration: const BoxDecoration(
                                                          shape: BoxShape.circle
                                                      ),
                                                      boxDecoration: const BoxDecoration(color: AppTheme.boxBgColor,),
                                                      onChanged: (CountryCode countryCode) {

                                                        WidgetDesigns.consoleLog("${countryCode.code}","country code --->>");
                                                        WidgetDesigns.consoleLog("${countryCode.dialCode}","country dialCode --->>");
                                                        // controller.updateCountryString(countryCode.dialCode.toString().split("+").last);
                                                        controller.updateCountryString((countryCode.dialCode ?? '+91').replaceAll('+', ''));
                                                        if(controller.countryPhoneDigits[countryCode.code.toString()] != null){
                                                          controller.checkCountryLength.value = controller.countryPhoneDigits[countryCode.code] ?? 10;
                                                        } else {
                                                          controller.checkCountryLength.value = 10;
                                                        }
                                                        controller.update();
                                                      },
                                                      // initialSelection: "+${controller.countryString}",
                                                      initialSelection: 'BW',
                                                    ),
                                                    Positioned(
                                                      right: -6,
                                                      top: 2,
                                                      bottom: 2,
                                                      child: SvgPicture.asset(ImageConstants.downArrow),
                                                    ),
                                                  ],
                                                ),
                                                WidgetDesigns.wBox(15),
                                                Container(width: 1,height: 30,color: AppTheme.darkText14,),
                                                WidgetDesigns.wBox(10),
                                              ],
                                            ),
                                            hintText: "Phone Number",
                                            onChanged: (value) {
                                              controller.updatePhoneError("");
                                            },
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {

                                                return 'Phone number is required!';
                                              }
                                              if (value.length != controller.checkCountryLength.value) {

                                                return '${controller.checkCountryLength.value} digits required';
                                              }
                                              if(controller.phoneError.value != '' && controller.phoneError.value.isNotEmpty){
                                                return controller.phoneError.value;
                                              }
                                              return null;
                                            },
                                          );
                                        }
                                    ),
                                  );
                                }
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        CustomAnimatedButton(
                          onTap: () {
                            if(controller.formKey.currentState!.validate()){
                              controller.sendOtpForForget();
                            }
                          },
                          text: 'Send Code',
                        ),
                      ],
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