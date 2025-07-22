import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordScreen extends StatelessWidget{

  final ChangePasswordController controller = Get.put(ChangePasswordController());

   ChangePasswordScreen({super.key});

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
                'Set Password',
                style: AppFontStyle.text_26_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(10),
              Text(
                'Your new password must be different from\nthe previously used password',
                style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(20),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    GetBuilder<ChangePasswordController>(
                        builder: (context) {
                          return CustomTextFormField(
                            controller: controller.newPassword,
                            hintText: "Password",
                            obscureText: controller.obscureNewPassword.value,
                            suffix: IconButton(
                              icon: Icon(
                                controller.obscureNewPassword.value ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                controller.toggleNewPasswordVisibility();
                              },
                            ),
                            onChanged: (value) {
                              controller.updateNewPasswordError('');
                            },
                            validator: (value) {
                              if(controller.newPasswordError.value.isNotEmpty || controller.newPasswordError.value != ''){
                                return controller.newPasswordError.value;
                              }
                              return FormValidators.validateStrongPassword(value!);
                            },
                          );
                        }
                    ),
                    WidgetDesigns.hBox(20),
                    GetBuilder<ChangePasswordController>(
                        builder: (context) {
                          return CustomTextFormField(
                            controller: controller.confirmPasswordP,
                            hintText: "Confirm Password",
                            obscureText: controller.obscureConfirmPassword.value,
                            suffix: IconButton(
                              icon: Icon(
                                controller.obscureConfirmPassword.value ? Icons.visibility_off : Icons.visibility,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                controller.toggleConfirmPasswordVisibility();
                              },
                            ),
                            onChanged: (value) {
                              controller.updateConfirmPasswordError('');
                            },
                            validator:(value) {
                              if(value == null || value.isEmpty|| value == ''){
                                return "Please Re-type password";
                              }
                              if(value != controller.newPassword.text){
                                return "Password mismatch";
                              }
                              return null;
                            },
                          );
                        }
                    ),
                  ],
                ),
              ),
              WidgetDesigns.hBox(20),
              CustomAnimatedButton(
                  onTap: () {
                    if(controller.formKey.currentState!.validate() || controller.newPassword.text.trim() == controller.confirmPasswordP.text.trim()){
                      controller.setPasswordAPI();
                    }
                  },
                  text: 'Save Password'
              )
            ],
          ),
        ),
      ),
    );
  }
}