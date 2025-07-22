import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DeliveryMethodScreen extends StatelessWidget {
  final DeliveryMethodController controller = Get.put(DeliveryMethodController());

   DeliveryMethodScreen({super.key});

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
                      'Delivery Method',
                      style: AppFontStyle.text_30_600(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                    WidgetDesigns.hBox(20),
                    Text(
                      'Lorem Ipsum is simply dummy text of the\nprinting and typesetting industry.',
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
                        child: deliveryOption()
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

  Widget deliveryOption(){
    return Obx( () {
      bool isLoading = controller.deliveryMethodListData.value.data == null;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Delivery Method",
              style: AppFontStyle.text_16_400(
                  AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular)
          ),
          WidgetDesigns.hBox(20),
          isLoading ? buildShimmerOption() :
          deliveryOptionWidget(
              title: controller.deliveryMethodListData.value.data?.data?[0].name.toString() ?? '',
              index: controller.deliveryMethodListData.value.data?.data?[0].id ?? ''
          ),
          WidgetDesigns.hBox(20),
          isLoading ? buildShimmerOption() :
          deliveryOptionWidget(
              title: controller.deliveryMethodListData.value.data?.data?[1].name.toString() ?? '',
              index: controller.deliveryMethodListData.value.data?.data?[1].id ?? ''
          ),
          WidgetDesigns.hBox(20),
          isLoading ? buildShimmerOption() :
          deliveryOptionWidget(
              title: controller.deliveryMethodListData.value.data?.data?[2].name.toString() ?? '',
              index: controller.deliveryMethodListData.value.data?.data?[2].id ?? ''
          ),
          WidgetDesigns.hBox(20),
          CustomAnimatedButton(
              onTap: () {
                if (controller.selectedOptionIndex.value != "0") {
                  controller.selectDeliveryMethodAPI();
                } else {
                  CustomSnackBar.show(
                      message: "Please select a delivery method",
                      color: AppTheme.redText,
                      tColor: AppTheme.white
                  );
                }
              },
              text: "Continue"
          )
        ],
      );
    });
  }

  Widget deliveryOptionWidget({
    required String title,
    required String index
  }) {
    bool isSelected = controller.selectedOptionIndex.value == index;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => controller.selectOption(index),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppTheme.white,
          border: Border.all(
            color: isSelected ? AppTheme.primaryColor : AppTheme.primaryColor.withOpacity(0.2)
          )
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              title,
              style: AppFontStyle.text_16_400(isSelected ? AppTheme.primaryColor : AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
              textAlign: TextAlign.center,
            ),
          ),
        ),
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