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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    WidgetDesigns.hBox(30),
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
                        child: Obx(() {
                          // Show shimmer when loading
                          if (controller.isLoading.value) {
                            return Expanded(
                              child: ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: controller.documentListData.value.data?.data?.length ?? 0,
                                shrinkWrap: true,
                                separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
                                itemBuilder: (context, index) => buildShimmerOption(),
                              ),
                            );
                          }
                          // Show actual data when loaded
                          return pendingDocuments();
                        }),
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
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Documents",
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
              final docData = controller.documentListData.value.data?.data?[index];
              return pendingDocumentsNames(
                docData?.name.toString() ?? '',
                doc["image"],
                docData?.isComleted ?? false , () => Get.toNamed(doc["route"]),
              );
            },
          ),
        ),

          WidgetDesigns.hBox(20),
      
          CustomAnimatedButton(
              onTap: () {
                if(controller.documentListData.value.data?.allComplete == true){
                  Get.toNamed(Routes.registrationCompleteScreen);
                }else{
                  CustomSnackBar.show(message: "Please upload all pending documents" , color: AppTheme.redText, tColor: AppTheme.white);
                }
              },
              text: "Continue"
          )
        ],
      ),
    );
  }

  Widget pendingDocumentsNames(String title, String image, bool isCompleted ,VoidCallback onTap) {
    return GestureDetector(
      onTap: isCompleted ? null : onTap,
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
              Row(
                children: [
                  Icon(
                      isCompleted ? Icons.check_circle : Icons.hourglass_bottom_rounded,
                      size: 14,
                      color: isCompleted ? AppTheme.green : AppTheme.grey
                  ),
                  WidgetDesigns.wBox(10),
                  if(!isCompleted)
                    Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey),
                ],
              )
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
