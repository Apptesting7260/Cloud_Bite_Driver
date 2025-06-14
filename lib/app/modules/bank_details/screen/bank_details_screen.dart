import 'package:cloud_bites_driver/app/core/app_exports.dart';

class BankDetailsScreen extends StatelessWidget{

  final BankDetailController controller = Get.put(BankDetailController());

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
                "Bank Account Details",
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(20),
              Text(
                'Please add your bank account details to\nproceed with transactions securely.',
                style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(20),
              Expanded(child: bankDetailsForm())
            ],
          ),
        ),
      ),
    );
  }

  Widget bankDetailsForm(){
    return Obx((){
      return Form(
        key: controller.formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              WidgetDesigns.hBox(20),
              CustomTextFormField(
                controller: controller.bankNameController,
                hintText: "Bank Name",
                onChanged: (value) {
                  controller.updateBankNameError('');
                },
                validator: (value) {
                  if(controller.bankNameController.text.isEmpty){
                    return 'Bank name is required';
                  }
                },
              ),
              WidgetDesigns.hBox(16),
              CustomTextFormField(
                controller: controller.acHolderNameController,
                hintText: "Account Holder Name",
                onChanged: (value) {
                  controller.updateAcHolderNameError('');
                },
                validator: (value) {
                  if(controller.acHolderNameController.text.isEmpty){
                    return 'Account holder name is required';
                  }
                },
              ),
              WidgetDesigns.hBox(16),
              CustomTextFormField(
                controller: controller.acNumberController,
                hintText: "Account No.",
                onChanged: (value) {
                  controller.updateACNumberError('');
                },
                validator: (value) {
                  if(controller.acNumberController.text.isEmpty){
                    return 'Account number is required';
                  }
                },
              ),
              WidgetDesigns.hBox(16),
              CustomTextFormField(
                controller: controller.reTypeController,
                hintText: "Retype Account No.",
                onChanged: (value) {
                  controller.updateReTypeError('');
                },
                validator: (value) {
                  if(controller.reTypeController.text.isEmpty){
                    return 'Re_Type account number is required';
                  }
                },
              ),
              WidgetDesigns.hBox(16),
          
              SimpleCustomDropdown(
                items: controller.accountTypes,
                selectedValue: controller.selectedAccountType.value,
                hintText: 'Account Type',
                onChanged: (p0) {
                  controller.selectedAccountType.value = p0 ?? '';
                },
                validator: (value) => value == null ? 'Select vehicle type' : null,
              ),
          
              WidgetDesigns.hBox(16),
              CustomTextFormField(
                controller: controller.ifscNameController,
                hintText: "IFSC",
                onChanged: (value) {
                  controller.updateIfscError('');
                },
                validator: (value) {
                  if(controller.ifscNameController.text.isEmpty){
                    return 'Ifsc number is required';
                  }
                },
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
          ),
        ),
      );
    });
  }
}