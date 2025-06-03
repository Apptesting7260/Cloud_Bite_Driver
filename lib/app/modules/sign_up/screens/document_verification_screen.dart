import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DocumentVerificationScreen extends StatelessWidget{

  final DocumentVerificationController controller = Get.put(DocumentVerificationController());

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: AppTheme.primaryGradientHorizontal
      ),
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          appBar: CustomBackButtonAppBar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    WidgetDesigns.hBox(10),
                    Text(
                      'Documents Verification',
                      style: AppFontStyle.text_30_600(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                    WidgetDesigns.hBox(20),
                    Text(
                      'Just a few steps to complete and then you\ncan start earning with Us',
                      style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              WidgetDesigns.hBox(30),
              Flexible(
                flex: 2,
                child: SizedBox(
                  width: double.infinity,
                  child: Material(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)
                    ),
                    child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: pendingDocuments()
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget pendingDocuments()  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Pending Documents",
            style: AppFontStyle.text_16_400(
                AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular)
        ),
        WidgetDesigns.hBox(20),
        pendingDocumentsNames(
                "Personal Documents",
                ImageConstants.personalDocImage,
                () => Get.toNamed(Routes.personalDocumentsScreen)
        ),
        WidgetDesigns.hBox(20),
        pendingDocumentsNames(
            "Vehicle Details",
            ImageConstants.vehicleDetailImage,
            () => Get.toNamed(Routes.vehicleDetailsScreen)
        ),
        WidgetDesigns.hBox(20),
        pendingDocumentsNames(
            "Bank Account Details",
            ImageConstants.vehicleDetailImage,
            () => Get.toNamed(Routes.bankDetailsScreen)),

        WidgetDesigns.hBox(20),
        Text("Completed Documents",
            style: AppFontStyle.text_16_400(
                AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular)
        ),
        WidgetDesigns.hBox(20),
        CustomAnimatedButton(
            onTap: () {
              Get.toNamed('');
            },
            text: "Continue"
        )
      ],
    );
  }

  Widget pendingDocumentsNames(String title, String image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: AppTheme.lightGradient
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SvgPicture.asset(image),
              WidgetDesigns.wBox(10),
              Text(
                title,
                style: AppFontStyle.text_16_500(AppTheme.black),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey)
            ],
          ),
        )
      ),
    );
  }
}