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
              Expanded(
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
    bool isLoading = controller.documentListData.value.data == null;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Pending Documents",
              style: AppFontStyle.text_16_400(
                  AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular)
          ),
          WidgetDesigns.hBox(20),

        Obx(() =>
           ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.documentListData.value.data?.data?.length ?? 0,
            shrinkWrap: true,
            separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
            itemBuilder: (context, index) {
              final doc = controller.pendingDocsList[index];
              return pendingDocumentsNames(
                controller.documentListData.value.data?.data?[index].name.toString() ?? '', doc["image"], () => Get.toNamed(doc["route"]),
              );
            },
          ),
        ),

          WidgetDesigns.hBox(20),
      
          CustomAnimatedButton(
              onTap: () {
                Get.toNamed(Routes.registrationCompleteScreen);
              },
              text: "Continue"
          )
        ],
      ),
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

  Widget buildShimmerOption() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
      ),
    );
  }
}