import 'package:cloud_bites_driver/app/core/app_exports.dart';

class OnboardingScreen extends StatelessWidget {
  final OnboardingController onboardingController = Get.put(OnboardingController());

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: onboardingController.pageController,
            itemCount: 3,
            onPageChanged: (value){
              onboardingController.updateCurrentPage(value, false);
            },
            itemBuilder: (context, index) {
              return Column(
                children: [
                  WidgetDesigns.hBox(Get.height * 0.15),
                  SvgPicture.asset(
                    onboardingController.onboardingImages[index],
                    width: (Get.width * 0.70).w,
                    height: (Get.width * 0.70).w,
                  ),
                  WidgetDesigns.hBox(Get.height * 0.135),
                  SizedBox(
                      width: (Get.width * 0.90).w,
                      child: Text(onboardingController.onboardingTexts[index],textAlign: TextAlign.center,style: AppFontStyle.text_26_500(AppTheme.darkText,fontFamily: AppFontFamily.generalSansMedium,overflow: TextOverflow.clip),)),
                  WidgetDesigns.hBox(Get.height * 0.025),
                  SizedBox(
                      width: (Get.width * 0.95).w,
                      child: Text(onboardingController.descriptionTexts[index], textAlign: TextAlign.center, style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular, overflow: TextOverflow.clip),)),
                  const Spacer(flex: 3,),
                ],
              );
            },
          ),
          WidgetDesigns.hBox(16),
          Positioned(
            top:  ((Get.height * 0.15) + (Get.width * 0.70) + (Get.height * 0.10)).h,
            left: 1,
            right: 1,
            child: Obx(() =>
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,(index) => Padding(
                    padding: REdgeInsets.all(4.0),
                    child: Container(
                      height: 8.h,
                      width: onboardingController.currentPage.value == index ? 32 : 8,
                      decoration: onboardingController.currentPage.value == index
                          ? BoxDecoration(
                        color: AppTheme.skyColor,
                        borderRadius: BorderRadius.circular(10.r),
                      )
                          : const BoxDecoration(
                        color: AppTheme.skyColor30,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  ),
                ),
            ),
          ),
          WidgetDesigns.hBox(16),
          Positioned(
              bottom: 18.h,
              left: 1,
              right: 1,
              child: Obx(() =>
                  Column(
                    children: [
                      Padding(
                        padding: REdgeInsets.symmetric(horizontal: 18.0),
                        child: CustomAnimatedButton(
                          onTap: () {
                            if (onboardingController.currentPage.value < 2) {
                              onboardingController.updateCurrentPage(onboardingController.currentPage.value+1, true);
                            } else {
                              Get.offAllNamed(Routes.welcome);
                            }
                          },
                          text: onboardingController.currentPage.value != 2 ? "Next" : "Get Started",
                        ),
                      ),
                      WidgetDesigns.wBox(8),
                      TextButton(
                        onPressed: onboardingController.currentPage.value  != 2 ?
                            () async {
                          Get.offAllNamed(Routes.welcome);
                        }
                            : null,
                        child: Text('Skip', style: TextStyle(color: onboardingController.currentPage.value  != 2 ? AppTheme.primaryColor : AppTheme.transparent, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: AppFontFamily.generalSansMedium),),
                      ),
                      WidgetDesigns.wBox(8),
                    ],
                  ),
              )
          )
        ],
      ),
    );
  }
}