import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ChangePasswordProcessScreen extends StatelessWidget{

  final ChangePasswordProcessController controller = Get.put(ChangePasswordProcessController());

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomBackButtonAppBar(backgroundColor: Colors.white,title: 'Change Password'),
     body: SafeArea(
       child: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.all(10.0),
           child: Column(
             children: [
               WidgetDesigns.hBox(20),
               Obx((){
                 return Form(
                   key: controller.formKey,
                   child: Column(
                     children: [
                       CustomTextFormField(
                         controller: controller.oldPassword,
                         hintText: "Old Password",
                         obscureText: controller.obscureOldPassword.value,
                         suffix: IconButton(
                           icon: Icon(
                             controller.obscureOldPassword.value ? Icons.visibility_off : Icons.visibility,
                             color: Colors.grey,
                           ),
                           onPressed: () {
                             controller.toggleOldPasswordVisibility();
                           },
                         ),
                       ),
                       WidgetDesigns.hBox(20),
                       GestureDetector(
                         onTap: () {
                           Get.toNamed(Routes.forgotPasswordScreen);
                         },
                         child: Text(
                           'Forgot Password?',
                           style: AppFontStyle.text_14_500(AppTheme.pink, fontFamily: AppFontFamily.generalSansMedium),
                         ),
                       ),
                       WidgetDesigns.hBox(20),
                       CustomTextFormField(
                         controller: controller.newPassword,
                         hintText: "New Password",
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
                         controller: controller.confirmNewPassword,
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
                         validator: (value) {
                           if(value == null || value == '' || value.isEmpty){
                             return 'Please Re-Type Password';
                           }
                           if(value != controller.newPassword.text){
                             return 'Password mismatch';
                           }
                           return null;
                         },
                       ),
                       WidgetDesigns.hBox(30),
                       CustomAnimatedButton(
                           onTap: () {
                             if(controller.formKey.currentState!.validate() || controller.newPassword.text == controller.confirmNewPassword.text){
                               //controller.changePasswordApi();
                             }
                           },
                           text: 'Save Password'
                       )
                     ],
                   ),
                 );
               })
             ],
           ),
         ),
       ),
     ),
   );
  }
}