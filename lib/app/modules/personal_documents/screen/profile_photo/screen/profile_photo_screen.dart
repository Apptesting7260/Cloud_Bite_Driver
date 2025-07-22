import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ProfilePhotoScreen extends StatelessWidget{

  final ProfilePhotoController controller = Get.put(ProfilePhotoController());

  ProfilePhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              WidgetDesigns.hBox(20),
              Text(
                'Profile Photo',
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
              ),
              WidgetDesigns.hBox(20),
              Obx(() {
                return GradientDottedBorder(
                  strokeWidth: 2,
                  radius: Radius.circular(15),
                  gradientColors: [Color(0xFFB6568E), Color(0xFF5FB6E3)],
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppTheme.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (controller.profileImage.value != null)
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: FileImage(controller.profileImage.value!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          )else
                          SvgPicture.asset(
                            ImageConstants.profileImage,
                            fit: BoxFit.cover,
                          ),
                        WidgetDesigns.hBox(20),
                        Text(
                          'Upload your profile photo',
                          style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
                        ),
                        WidgetDesigns.hBox(20),
                        GestureDetector(
                          onTap: () {
                            controller.pickImage(controller.profileImage,fillImageArray: true);
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
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.camera_alt, size: 14, color: AppTheme.primaryColor),
                                    WidgetDesigns.wBox(10),
                                    if (controller.profileImage.value == null)
                                      Text(
                                        'Upload Photo',
                                        style: AppFontStyle.text_14_400(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansRegular),
                                      )else
                                      Text(
                                        'Change Photo',
                                        style: AppFontStyle.text_14_400(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansRegular),
                                      )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
              WidgetDesigns.hBox(30),
              CustomAnimatedButton(
                  onTap: () {
                    if(controller.profileImage.value != null){
                      controller.uploadProfilePhotoAPI();
                    }else{
                      CustomSnackBar.show(message: "Please Upload Profile Image", color: AppTheme.redText, tColor: AppTheme.white);
                    }
                  },
                  text: "Save"
              )
            ],
          ),
        ),
      ),
    );
  }
}