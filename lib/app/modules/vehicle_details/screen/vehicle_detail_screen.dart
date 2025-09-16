import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class VehicleDetailsScreen extends StatelessWidget{

  final VehicleDetailController controller = Get.put(VehicleDetailController());

  VehicleDetailsScreen({super.key});

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
                "Vehicle Details",
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(20),
              Text(
                'Please add your vehicle details to complete\nthe registration process.',
                style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(20),
              Expanded(child: vehicleForm())
            ],
          ),
        ),
      ),
    );
  }

  Widget vehicleForm(){
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetDesigns.hBox(20),
            GetBuilder<VehicleDetailController>(
              builder: (context) {
                return CustomTextFormField(
                  readOnly: false,
                  controller: controller.vehicleNameController,
                  hintText: "Vehicle Name",
                  onChanged: (value) {
                    controller.updateVehicleNameError('');
                  },
                  validator: (value) {
                    if(controller.vehicleNameController.text.isEmpty){
                      return 'Vehicle name is required';
                    }

                    if(controller.vehicleNameError.value.isNotEmpty || controller.vehicleNameError.value != ''){
                      return controller.vehicleNameError.value;

                    }
                    return null;
                  },
                );
              }
            ),

            WidgetDesigns.hBox(16),
            GetBuilder<VehicleDetailController>(
              builder: (context) {
                return CustomTextFormField(
                  controller: controller.brandNameController,
                  readOnly: false,
                  hintText: "Brand",
                  onChanged: (value) {
                    controller.updateBrandNameError('');
                  },
                  validator: (value) {
                    if(controller.brandNameController.text.isEmpty){
                      return 'Brand name is required';
                    }

                    if(controller.brandNameError.value.isNotEmpty || controller.brandNameError.value != ''){
                      return controller.brandNameError.value;

                    }
                    return null;
                  },
                );
              }
            ),


            WidgetDesigns.hBox(16),
            GetBuilder<VehicleDetailController>(
              builder: (context) {
                return CustomTextFormField(
                  readOnly: false,
                  controller: controller.manufacturerYearController,
                  hintText: "Year Of Manufacture",
                  textInputType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4)
                  ],
                  onChanged: (value) {
                    controller.updateManufactureYearError('');
                  },
                  validator: (value) {
                    if(controller.manufacturerYearController.text.isEmpty){
                      return 'Manufacturer year is required';
                    }

                    if(controller.yearOfManufactureError.value.isNotEmpty || controller.yearOfManufactureError.value != ''){
                      return controller.yearOfManufactureError.value;

                    }
                    return null;
                  },
                );
              }
            ),

            WidgetDesigns.hBox(16),
            GetBuilder<VehicleDetailController>(
              builder: (context) {
                return CustomTextFormField(
                  readOnly: false,
                  controller: controller.registrationNumberController,
                  hintText: "Registration Number",
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
                    LengthLimitingTextInputFormatter(12)
                  ],
                  onChanged: (value) {
                    controller.updateRegistrationNameError('');
                  },
                  validator: (value) {
                    if(controller.registrationNumberController.text.isEmpty){
                      return 'Registration number is required';
                    }

                    if(controller.registrationNumError.value.isNotEmpty || controller.registrationNumError.value != ''){
                      return controller.yearOfManufactureError.value;

                    }
                    return null;
                  },
                );
              }
            ),

            WidgetDesigns.hBox(16),

            SimpleCustomDropdown(
              items: controller.fuelType,
              selectedValue: controller.selectedFuelType.value,
              hintText: 'Fuel Type',
              onChanged: (p0) {
                controller.selectedFuelType.value = p0 ?? '';
              },
              validator: (value) => value == null ? 'Select Fuel type' : null,
            ),

            WidgetDesigns.hBox(16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: photoContainer('1', 'Front side photo of your\nRegistration Certificate'),
            ),
            WidgetDesigns.hBox(16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: photoContainer('2', 'Back side photo of your\nRegistration Certificate'),
            ),
            WidgetDesigns.hBox(20),
            CustomAnimatedButton(
                onTap: (){
                  if(controller.formKey.currentState!.validate()){
                    controller.vehicleDetailsUploadAPI();
                  }
                },
                text: 'Submit'
            )
          ],
        ),
      ),
    );
  }

  Widget photoContainer(String type, String text){
    return Obx(() {
      File? image = type == "1" ? controller.frontImage.value : controller.backImage.value;
      return GradientDottedBorder(
        strokeWidth: 2,
        radius: Radius.circular(15.0),
        gradientColors: [Color(0xFFB6568E), Color(0xFF5FB6E3)],
        child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppTheme.white,
                borderRadius: BorderRadius.circular(15.0),
                image: image != null ? DecorationImage(image: FileImage(image), fit: BoxFit.fill) : null
            ),
            child: image == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: AppFontStyle.text_14_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
                  textAlign: TextAlign.center,
                ),
                WidgetDesigns.hBox(20),
                GestureDetector(
                  onTap: (){
                    if(type == "1"){
                      controller.pickImage(controller.frontImage,fillImageArray: true);
                    }else{
                      controller.pickImage(controller.backImage, fillImageArray: true);
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: AppTheme.primaryGradientHorizontal
                    ),
                    child: Container(
                      margin: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(23),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(Icons.camera_alt, size: 14, color: AppTheme.primaryColor),
                            WidgetDesigns.wBox(10),
                            Text(
                              'Upload Photo',
                              style: AppFontStyle.text_14_400(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansRegular),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ) :
            Stack(
              children: [
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: (){
                      if(type == '1'){
                        controller.frontImage.value = null;
                      }else{
                        controller.backImage.value = null;
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: AppTheme.black,
                                blurRadius: 4
                            )
                          ]
                      ),
                      child: Icon(
                        Icons.delete_forever,
                        size: 16,
                        color: AppTheme.white,
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      );
    });
  }
}