import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordScreen extends StatelessWidget{

  final ChangePasswordInLoginController controller = Get.put(ChangePasswordInLoginController());

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
        const BoxDecoration(gradient: AppTheme.primaryGradientHorizontal),
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
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            controller: controller.newPasswordController,
                            hintText: "Password",
                            isPassword: true,
                            validator: FormValidators.validatePassword,
                            validateOnChange: true,
                          ),
                          const SizedBox(height: 16),
                          CustomTextField(
                            controller: controller.confirmPasswordController,
                            hintText: "Confirm Password",
                            isPassword: true,
                            validator: FormValidators.validatePassword,
                            validateOnChange: true,
                          ),
                          const SizedBox(height: 30),
                          CustomAnimatedButton(
                            onTap: () {
                              /*controller.changePassword();*/
                              _showPasswordChangedDialog(Get.context!);
                            },
                            text: 'Confirm',
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


  void _showPasswordChangedDialog(BuildContext context) {
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
              SvgPicture.asset(ImageConstants.passwordChangedIon,height: 80),
              WidgetDesigns.hBox(20),
              Text(
                "Password Changed",
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Password changed successfully, you can login again with a new password",
                style: TextStyle(
                  fontFamily: 'General-Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: CustomAnimatedButton(
                          onTap: () {
                            Get.offAllNamed(Routes.welcome);
                          },
                          text: 'Close')
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