import 'dart:io';

import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DrivingLicenseScreen extends StatelessWidget{

  final DrivingLicenseController controller = Get.put(DrivingLicenseController());

   DrivingLicenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Driving License',
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(20),
              photoContainer('1', 'Front side photo of your\nDriving License'),
              WidgetDesigns.hBox(20),
              photoContainer('2', 'Back side photo of your\nDriving License'),
              WidgetDesigns.hBox(20),
              CustomAnimatedButton(
                  onTap: (){
                    if(controller.frontImage.value != null && controller.backImage.value != null){
                      controller.licenseUploadAPI();
                    }else{
                      CustomSnackBar.show(message: 'Please Upload Front and Back Side of Driving License', color: AppTheme.redText, tColor: AppTheme.white);
                    }
                  },
                  text: 'Submit'
              )
            ],
          ),
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
                    controller.pickImage(controller.backImage,fillImageArray: true);
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