import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ForgotPasswordScreen extends StatelessWidget{

  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

   ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: AppTheme.white),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetDesigns.hBox(20),
              Text(
                'Forgot Password',
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(20),
              Text(
                'Enter your registered email to receive reset\npassword code',
                style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(20),
              Form(
                key: controller.formKey,
                child: GetBuilder<ForgotPasswordController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.emailAddressController,
                      hintText: "Email Address",
                      readOnly: false,
                      onChanged: (value) {
                        controller.emailError('');
                      },
                      validator: (value) {
                        if(controller.emailAddressController.text.isEmpty){
                          return 'Email address is required';
                        }
                        if(!FormValidators.isValidEmail(value)){
                          return "Please enter a valid email";
                        }
                        if(controller.emailError.value.isNotEmpty || controller.emailError.value != ''){
                          return controller.emailError.value;
                        }
                        return null;
                      },
                    );
                  }
                ),
              ),
              WidgetDesigns.hBox(20),
              CustomAnimatedButton(
                  onTap: () {
                    if(controller.formKey.currentState!.validate()){
                      controller.sendOtpForForget();
                    }
                  },
                  text: 'Send Code'
              )
            ],
          ),
        ),
      ),
    );
  }
}