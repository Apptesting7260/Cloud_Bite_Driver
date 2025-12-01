import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/custom_gradient_toggle.dart';

class BankDetailsScreen extends StatelessWidget{

  var controller = Get.put(BankDetailController());

   BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment Details",
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(20),
              Text(
                'Please select how you would like to be paid.',
                style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(20),
              Obx(
                 () {
                  return controller.isLoading.value ?ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            ShimmerBox(width: 50, height:50),
                            WidgetDesigns.wBox(15),
                            ShimmerBox(width: 200, height:50),

                            // Text(
                            //   controller.paymentData.value.data?[index].name ?? '',
                            //   style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                            // ),
                          ],
                        );

                      }, separatorBuilder: (context, index) {
                    return SizedBox(height: 12,);
                  }, itemCount:3) :
                   // controller.getPaymentMethodApi();
                   ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
var isSelected = index == controller.selectedPaymentMethod.value;
                    return InkWell(
                      onTap: () {

                          controller.selectedPaymentMethod.value = index;
                          controller.methodId.value = "${controller.paymentData.value.data?[index].id ?? 0}";


                        print(controller.selectedPaymentMethod.value);
                      },
                      child: Row(
                        children: [
                          Obx(
                             () {
                              return CustomGradientToggle(isSelected: index == controller.selectedPaymentMethod.value);
                            }
                          ),
                          WidgetDesigns.wBox(15),
                          MyText(title: controller.paymentData.value.data?[index].name ?? '',fSize: 20,tColor: AppTheme.black,fWeight: FontWeight.w400,),
                          // Text(
                          //   controller.paymentData.value.data?[index].name ?? '',
                          //   style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                          // ),
                        ],
                      ),
                    );
                  }, separatorBuilder: (context, index) {
                    return SizedBox(height: 12,);
                  }, itemCount:controller.paymentData.value.data?.length ?? 0);
                }
              ),
              Expanded(child: bankDetailsForm())
            ],
          ),
        ),
      ),
    );
  }

  Widget bankDetailsForm(){
    return Form(
      key: controller.formKey,
      child: SingleChildScrollView(
        child: Obx(
           () {
            return controller.methodId.value =="3"?Column(
              children: [
                WidgetDesigns.hBox(20),
                GetBuilder<BankDetailController>(
                    builder: (context) {
                      return CustomTextFormField(
                        controller: controller.pay2cellNumberController,
                        hintText: "Pay2Cell Number",
                        readOnly: false,

                        validator: (value) {
                          if(controller.pay2cellNumberController.text.isEmpty){
                            return 'Pay2Cell number is required';
                          }
                          return null;
                        },
                      );
                    }
                ),
                WidgetDesigns.hBox(20),
                CustomAnimatedButton(
                    onTap: (){
                      if(controller.formKey.currentState!.validate()){
                        controller.bankDetailsUploadAPI();
                      }
                    },
                    text: 'Save'
                )
              ],
            ): controller.methodId.value =="4" ?Column(
              children: [
                WidgetDesigns.hBox(20),
                GetBuilder<BankDetailController>(
                    builder: (context) {
                      return CustomTextFormField(
                        controller: controller.orangeMoneyController,
                        hintText: "Orange Money Number",
                        readOnly: false,

                        validator: (value) {
                          if(controller.orangeMoneyController.text.isEmpty){
                            return 'Orange Money number is required';
                          }
                          return null;
                        },
                      );
                    }
                ),
                WidgetDesigns.hBox(20),
                CustomAnimatedButton(
                    onTap: (){
                      if(controller.formKey.currentState!.validate()){
                        controller.bankDetailsUploadAPI();
                      }
                    },
                    text: 'Save'
                )
              ],
            ):controller.methodId.value =="5" ?Column(
              children: [
                WidgetDesigns.hBox(20),
                GetBuilder<BankDetailController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.bankNameController,
                      hintText: "Bank Name",
                      readOnly: false,
                      onChanged: (value) {
                        controller.updateBankNameError('');
                      },
                      validator: (value) {
                        if(controller.bankNameController.text.isEmpty){
                          return 'Bank name is required';
                        }
                        if(controller.bankNameError.value.isNotEmpty || controller.bankNameError.value != ''){
                          return controller.bankNameError.value;
                        }
                        return null;
                      },
                    );
                  }
                ),
                WidgetDesigns.hBox(16),
                GetBuilder<BankDetailController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.acHolderNameController,
                      hintText: "Account Holder Name",
                      readOnly: false,
                      onChanged: (value) {
                        controller.updateAcHolderNameError('');
                      },
                      validator: (value) {
                        if(controller.acHolderNameController.text.isEmpty){
                          return 'Account holder name is required';
                        }
                        if(controller.accountHolderNameError.value.isNotEmpty || controller.accountHolderNameError.value != ''){
                          return controller.accountHolderNameError.value;
                        }
                        return null;
                      },
                    );
                  }
                ),
                WidgetDesigns.hBox(16),
                GetBuilder<BankDetailController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.acNumberController,
                      hintText: "Account No.",
                      readOnly: false,
                      onChanged: (value) {
                        controller.updateACNumberError('');
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        // LengthLimitingTextInputFormatter(35)
                      ],
                      textInputType: TextInputType.number,
                      validator: (value) {
                        if(controller.acNumberController.text.isEmpty){
                          return 'Account number is required';
                        }
                        if(controller.acNumberError.value.isNotEmpty || controller.acNumberError.value != ''){
                          return controller.acNumberError.value;
                        }
                        return null;
                      },
                    );
                  }
                ),
                WidgetDesigns.hBox(16),
                GetBuilder<BankDetailController>(
                  builder: (context) {
                    return CustomTextFormField(
                      readOnly: false,
                      textInputType: TextInputType.number,

                      controller: controller.reTypeController,
                      hintText: "Retype Account No.",
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        // LengthLimitingTextInputFormatter(35)
                      ],
                      onChanged: (value) {
                        controller.updateReTypeError('');
                      },
                      validator: (value) {
                        if(controller.reTypeController.text.isEmpty){
                          return 'Retype account number is required';
                        }
                        if(controller.reTypeACError.value.isNotEmpty || controller.reTypeACError.value != ''){
                          return controller.reTypeACError.value;
                        }
                        return null;
                      },
                    );
                  }
                ),
                WidgetDesigns.hBox(16),
                SimpleCustomDropdown(
                  items: controller.accountTypes,
                  selectedValue: controller.selectedAccountType.value,
                  hintText: 'Account Type',
                  onChanged: (p0) {
                    controller.selectedAccountType.value = p0 ?? '';
                  },
                  validator: (value) => value == null ? 'Select Account type' : null,
                ),

                WidgetDesigns.hBox(16),
                GetBuilder<BankDetailController>(
                  builder: (context) {
                    return CustomTextFormField(
                      readOnly: false,
                      controller: controller.ifscNameController,
                      hintText: "Branch Code",
                      onChanged: (value) {
                        controller.updateIfscError('');
                      },
                      validator: (value) {
                        if(controller.ifscNameController.text.isEmpty){
                          return 'Branch code is required';
                        }
                        if(controller.ifscError.value.isNotEmpty || controller.ifscError.value != ''){
                          return controller.ifscError.value;
                        }
                        return null;
                      },
                    );
                  }
                ),
                WidgetDesigns.hBox(20),
                CustomAnimatedButton(
                    onTap: (){
                      if(controller.formKey.currentState!.validate()){
                        controller.bankDetailsUploadAPI();
                      }
                    },
                    text: 'Save'
                )
              ],
            ):SizedBox();
          }
        ),
      ),
    );
  }
}