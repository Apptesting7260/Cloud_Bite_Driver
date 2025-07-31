import 'package:cloud_bites_driver/app/core/app_exports.dart';

class MyProfileScreen extends StatelessWidget{

  final MyProfileController controller = Get.put(MyProfileController());
  final PersonalDetailsController detailController = Get.put(PersonalDetailsController());
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;
  // final String imageBaseUrl = "https://cloudbites.s3.af-south-1.amazonaws.com/";

   MyProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'My Profile'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              WidgetDesigns.hBox(20),
              Container(
                width: double.infinity,
                height: 120,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                    padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //Image.asset(ImageConstants.profile),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35.0),
                          child: CachedNetworkImage(
                            imageUrl: "${AppUrls.imageUrl}${detailController.driverData.value.data?.data?.profilePhoto}",
                            placeholder: (context, url) => ShimmerBox(width: 70, height: 70),
                            errorWidget: (context, url, error) => Image.asset(ImageConstants.default_image),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      WidgetDesigns.wBox(10),
                      Obx((){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${detailController.driverData.value.data?.data?.firstName ?? ''} ${detailController.driverData.value.data?.data?.lastName ?? ''}",
                              style: AppFontStyle.text_24_500(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
                            ),
                            Text(
                              detailController.driverData.value.data?.data?.email ?? '',
                              style: AppFontStyle.text_16_400(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
                            )
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
              WidgetDesigns.hBox(10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.deliveriesScreen);
                              },
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: AppTheme.newLightGradient
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx((){
                                      return Text(
                                        (controller.deliveryAndRatingData.value.data?.totalDeliveries == null ? "0" : controller.deliveryAndRatingData.value.data?.totalDeliveries ?? '0'),
                                        style: AppFontStyle.text_24_500(AppTheme.red, fontFamily: AppFontFamily.generalSansRegular),
                                      );
                                    }),
                                    WidgetDesigns.hBox(5),
                                    Text(
                                      'Deliveries',
                                      style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          WidgetDesigns.wBox(10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(Routes.ratings);
                              },
                              child: Container(
                                height: 110,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: AppTheme.newLightGradient
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Obx((){
                                      return  Text(
                                       (controller.deliveryAndRatingData.value.data?.totalRatings == 'null' ? "0" : controller.deliveryAndRatingData.value.data?.totalRatings ?? '0'),
                                        style: AppFontStyle.text_24_500(AppTheme.red, fontFamily: AppFontFamily.generalSansRegular),
                                      );
                                    }),
                                    WidgetDesigns.hBox(5),
                                    Text(
                                      'Ratings',
                                      style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      WidgetDesigns.hBox(30),
                      myProfileLists('Personal Details', ImageConstants.personalDetailsIcon, () => Get.toNamed(Routes.personalDetailsScreen)),
                      WidgetDesigns.hBox(20),
                      myProfileLists('Documents', ImageConstants.documentsIcon, () => Get.toNamed(Routes.documentsScreen)),
                      WidgetDesigns.hBox(20),
                      Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            color: AppTheme.lightGrey
                        ),
                      ),
                      WidgetDesigns.hBox(20),
                      myProfileLists('Earnings', ImageConstants.earningsIcon, () => Get.toNamed(Routes.earnings)),
                      WidgetDesigns.hBox(20),
                      myProfileLists('My Wallet', ImageConstants.walletIcon, () => Get.toNamed(Routes.myWalletScreen, arguments: {"walletBalance": controller.walletBalance.value})),
                      WidgetDesigns.hBox(20),
                      Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            color: AppTheme.lightGrey
                        ),
                      ),
                      WidgetDesigns.hBox(20),
                      myProfileLists('Help Center', ImageConstants.helpCenter, () => Get.toNamed(Routes.helpCenterScreen)),
                      WidgetDesigns.hBox(20),
                      myProfileLists('Settings', ImageConstants.settingsIcon, () => Get.toNamed(Routes.settingsScreen)),
                      WidgetDesigns.hBox(20),
                      Container(
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                            color: AppTheme.lightGrey
                        ),
                      ),
                      WidgetDesigns.hBox(20),
                      myProfileLists('Logout', ImageConstants.logoutIcon, () => showLogoutDialog(Get.context!)),
                      WidgetDesigns.hBox(50),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget myProfileLists( String title, String iconPath, VoidCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height:44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13.0),
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(248, 238, 244, 1),
                    Color.fromRGBO(239, 247, 252, 1)
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
            ),
            child: SvgPicture.asset(iconPath),
          ),
          WidgetDesigns.wBox(10),
          Text(
            title,
            style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
          ),
          const Spacer(),
          Icon(Icons.arrow_forward_ios, size: 14)
        ],
      ),
    );
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Logout",
                style: TextStyle(
                    fontFamily: 'General-Sans',
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Colors.black
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Text(
                "Are you sure you want to log out?",
                style: TextStyle(
                  fontFamily: 'General-Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Column(
                children: [
                  SizedBox(
                      width: double.infinity,
                      child: CustomAnimatedButton(
                          onTap: () {
                            controller.getLogoutAPI();
                          },
                          text: 'Yes, Logout')
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: const Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.pinkAccent,
                          fontFamily: 'General-Sans',
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}