

import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/controller/walllet/choose_withdraw_method_controller.dart';

import '../../../../utils/custom_widgets/custom_gradient_toggle.dart';

class ChooseWithdrawMethodScreen extends StatelessWidget {
  ChooseWithdrawMethodScreen({super.key});

  final ChooseWithdrawMethodController chooseWithdrawMethodController = Get.put(ChooseWithdrawMethodController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
     switch(chooseWithdrawMethodController.withdrawMethodsData.value.status){

       case ApiStatus.loading:
         return Scaffold(
           appBar: CustomBackButtonAppBar(title: "Choose Withdraw Method",),
           body: SingleChildScrollView(
             child: Padding(
               padding: REdgeInsets.symmetric(horizontal: 8.0),
               child: Column(
                 spacing: 12.0,
                 children: List.generate(
                   8, (index) => ShimmerBox(width: double.infinity, height: 100.h),
                 )
               ),
             ),
           ),
         );
       case ApiStatus.completed:
         return RefreshIndicator(
           color: AppTheme.primaryColor,
           onRefresh: () async {
             await chooseWithdrawMethodController.getWithdrawMethods();
           },
           child: Scaffold(
             appBar: CustomBackButtonAppBar(title: "Choose Withdraw Method",),
             body: SingleChildScrollView(
               child: Column(
                 children: [
                   Padding(
                     padding: REdgeInsets.only(left: 8.0,right: 8.0, top: 30.0),
                     child: Form(
                       key: chooseWithdrawMethodController.formKey,
                       child: Column(
                         spacing: 12.0,
                         children: List.generate(
                           chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?.length ?? 0,
                             (index) => InkWell(
                               focusColor: AppTheme.transparent,
                               highlightColor: AppTheme.transparent,
                               splashColor: AppTheme.transparent,
                               hoverColor: AppTheme.transparent,
                               onTap: (){
                                 chooseWithdrawMethodController.selectedMethod.value = chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?[index].paymentMethodId ?? "";
                               },
                               child: Container(
                                 height: chooseWithdrawMethodController.selectedMethod.value == chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?[index].paymentMethodId ? null : 100.h,
                                 width: double.infinity,
                                 decoration: BoxDecoration(
                                 color: AppTheme.white,
                                 borderRadius: BorderRadius.circular(10),
                                 border: Border.all(color: AppTheme.primaryColor20),
                               ),
                                 child: Padding(
                                   padding: REdgeInsets.symmetric(horizontal: 12.0,vertical: 12.0),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Row(
                                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                         children: [
                                           SvgPicture.asset(ImageConstants.walletIcon, width: 45.w, height: 45.h,),
                                           WidgetDesigns.wBox(8),
                                           Expanded(child: Text(chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?[index].name ?? "", style: AppFontStyle.text_18_500(AppTheme.black,fontFamily: AppFontFamily.generalSansMedium),)),
                                           Obx(() => CustomGradientToggle(
                                             isSelected: chooseWithdrawMethodController.selectedMethod.value == chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?[index].paymentMethodId,
                                           )),
                                         ],
                                       ),
                                       WidgetDesigns.hBox(8),
                                       Padding(
                                         padding: REdgeInsets.only(left: 53.w),
                                         child: Row(
                                           children: [
                                             Text("Charge: ", style: AppFontStyle.text_14_400(AppTheme.primaryColor,fontFamily: AppFontFamily.generalSansRegular),),
                                             WidgetDesigns.wBox(8),
                                             Text(chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?[index].charge ?? "", style: AppFontStyle.text_14_400(AppTheme.lightText,fontFamily: AppFontFamily.generalSansRegular),),
                                           ],
                                         ),
                                       ),
                                       if(chooseWithdrawMethodController.selectedMethod.value == chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?[index].paymentMethodId) ...[
                                         WidgetDesigns.hBox(16),
                                         if(chooseWithdrawMethodController.withdrawMethodsData.value.data?.data?[index].paymentMethodId == '2')
                                           Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               _buildBankDetailRow("Bank Name", chooseWithdrawMethodController.withdrawMethodsData.value.data?.bankAccountDetail?.bankName  ?? ""),
                                               WidgetDesigns.hBox(8),
                                               _buildBankDetailRow("Account Number", chooseWithdrawMethodController.withdrawMethodsData.value.data?.bankAccountDetail?.accountNumber ?? ""),
                                               WidgetDesigns.hBox(8),
                                               _buildBankDetailRow("Account Type", chooseWithdrawMethodController.withdrawMethodsData.value.data?.bankAccountDetail?.accountType ?? ""),
                                               WidgetDesigns.hBox(8),
                                               _buildBankDetailRow("IFSC Code", chooseWithdrawMethodController.withdrawMethodsData.value.data?.bankAccountDetail?.ifscCode ?? ""),
                                             ],
                                           )else
                                         CustomTextFormField(
                                           controller: chooseWithdrawMethodController.idController,
                                           readOnly: false,
                                           validator: (value) {
                                             if(value == null || value.isEmpty || value == ""){
                                               return "Please enter Payment Number";
                                             }
                                             return null;
                                           },
                                         ),
                                       ]
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                         )
                       ),
                     ),
                   ),
                   Padding(
                     padding: REdgeInsets.only(left: 8.0,right: 8.0, top: 30.0),
                     child: CustomAnimatedButton(
                       onTap: () {
                         if(chooseWithdrawMethodController.formKey.currentState!.validate()){
                           if(chooseWithdrawMethodController.selectedMethod.value != ""){
                             chooseWithdrawMethodController.sendWithdrawRequest();
                           }
                           else {
                             CustomSnackBar.show(message: "Please Select at least one payment method",color: AppTheme.red);
                           }
                         }
                      },
                      text: "Send Request",
                     ),
                   )
                 ],
               ),
             ),
           ),
         );
       default:
         return ErrorScreen(
          message: chooseWithdrawMethodController.withdrawMethodsData.value.message.toString(),
          buttonText: "Retry",
          onPressed: (){
            chooseWithdrawMethodController.getWithdrawMethods();
          }
       );
     }
    }
    );
  }

  Widget _buildBankDetailRow(String label, String value) {
    return Padding(
      padding: REdgeInsets.only(left: 53.w),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: AppFontStyle.text_14_500(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansRegular),
          ),
          WidgetDesigns.wBox(8),
          Text(
            value,
            style: AppFontStyle.text_14_400(AppTheme.lightText, fontFamily: AppFontFamily.generalSansRegular),
          ),
        ],
      ),
    );
  }
}
