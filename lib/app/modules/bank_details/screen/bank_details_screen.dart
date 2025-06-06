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
    return Column(
      children: [
        WidgetDesigns.hBox(20),
        CustomTextFormField(
          controller: controller.bankNameController,
          hintText: "Bank Name",
          //validator: FormValidators.validateName(value),
        ),
        WidgetDesigns.hBox(16),
        CustomTextFormField(
          controller: controller.bankNameController,
          hintText: "Account Holder Name",
          //validator: FormValidators.validateName(value),
        ),
        WidgetDesigns.hBox(16),
        CustomTextFormField(
          controller: controller.bankNameController,
          hintText: "Account No.",
          //validator: FormValidators.validateName(value),
        ),
        WidgetDesigns.hBox(16),
        CustomTextFormField(
          controller: controller.bankNameController,
          hintText: "Retype Account No.",
          //validator: FormValidators.validateName(value),
        ),
        WidgetDesigns.hBox(16),

        Obx((){
          return SimpleCustomDropdown(
            items: controller.accountTypes,
            selectedValue: controller.selectedAccountType.value,
            hintText: 'Account Type',
            onChanged: (p0) {
              controller.selectedAccountType.value = p0 ?? '';
            },
            validator: (value) => value == null ? 'Select vehicle type' : null,
          );
        }),
        WidgetDesigns.hBox(16),
        CustomTextFormField(
          controller: controller.bankNameController,
          hintText: "IFSC",
          //validator: FormValidators.validateName(value),
        ),
        WidgetDesigns.hBox(20),
        CustomAnimatedButton(
            onTap: (){},
            text: 'Save'
        )
      ],
    );
  }
}