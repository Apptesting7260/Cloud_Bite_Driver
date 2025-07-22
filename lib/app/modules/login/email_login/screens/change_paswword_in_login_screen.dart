import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordInLoginScreen extends StatelessWidget{

  final ChangePasswordInLoginController controller = Get.put(ChangePasswordInLoginController());

   ChangePasswordInLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
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
                  'Change Password',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppTheme.whiteColor,
                      fontSize: 27,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                Text(
                  'Your new password must be different from \nthe previously used password',
                  style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 60),
                Flexible(
                  flex: 2,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    child: Form(
                      key: controller.formKey,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GetBuilder<ChangePasswordInLoginController>(
                          builder: (context) {
                            return Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextFormField(
                                  controller: controller.newPassword,
                                  hintText: "Password",
                                  obscureText: controller.obscureNewPassword.value,
                                  onChanged: (value) {
                                    controller.updateNewPasswordError('');
                                  },
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
                                    if(controller.newPasswordError.value.isNotEmpty || controller.newPasswordError.value != ''){
                                      return controller.newPasswordError.value;
                                    }
                                    return FormValidators.validateStrongPassword(value!);
                                  },
                                ),
                                const SizedBox(height: 16),
                                CustomTextFormField(
                                  controller: controller.confirmPasswordP,
                                  hintText: "Confirm Password",
                                  obscureText: controller.obscureConfirmPassword.value,
                                  onChanged: (value) {
                                    controller.updateConfirmPasswordError('');
                                  },
                                  suffix: IconButton(
                                    icon: Icon(
                                      controller.obscureNewPassword.value ? Icons.visibility_off : Icons.visibility,
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
                                    if(value != controller.newPassword.text){
                                      return "Password mismatch";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 30),
                                CustomAnimatedButton(
                                  onTap: () {
                                    if(controller.formKey.currentState!.validate() || controller.newPassword.text.trim() == controller.confirmPasswordP.text.trim()){
                                      controller.setPasswordAPI();
                                    }
                                  },
                                  text: 'Confirm',
                                ),
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