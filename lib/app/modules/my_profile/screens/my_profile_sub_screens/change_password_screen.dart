import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordScreen extends StatelessWidget{

  final ChangePasswordController controller = Get.put(ChangePasswordController());

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
                'Change Password',
                style: AppFontStyle.text_26_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(10),
              Text(
                'Your new password must be different from\nthe previously used password',
                style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(20),
              CustomTextFormField(
                controller: controller.password,
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
                validator: (value) {
                  return FormValidators.validateStrongPassword(value!);
                },
              ),
              WidgetDesigns.hBox(20),
              CustomTextFormField(
                controller: controller.confirmPassword,
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
                validator:(value) {
                  if(value == null || value.isEmpty|| value == ''){
                    return "Please Re-type password";
                  }
                  if(value != controller.password.text){
                    return "Password mismatch";
                  }
                  return null;
                },
              ),
              WidgetDesigns.hBox(20),
              CustomAnimatedButton(
                  onTap: () {
                    showPasswordChangedDialog(Get.context!);
                  },
                  text: 'Save Password'
              )
            ],
          ),
        ),
      ),
    );
  }
  void showPasswordChangedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(ImageConstants.passwordChangedIcon,height: 80),
              WidgetDesigns.hBox(20),
              Text(
                "Password Changed",
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                "Password changed successfully, you can login again with a new password",
                style: AppFontStyle.text_12_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
                textAlign: TextAlign.center,
              ),
              WidgetDesigns.hBox(24),
              Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: CustomAnimatedButton(
                          onTap: () {
                            Get.back();
                          },
                          text: 'Close'
                      )
                  ),
                  const SizedBox(height: 10)
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}