import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DeliveryMethodScreen extends StatelessWidget {
  final DeliveryMethodController controller = Get.put(DeliveryMethodController());

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
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Select Delivery Method",
              style: AppFontStyle.text_16_400(
                  AppTheme.black, fontFamily: AppFontFamily.generalSansRegular)
          ),
          WidgetDesigns.hBox(20),
          deliveryOptionWidget(
              title: "Delivery by Car",
              index: 0
          ),
          WidgetDesigns.hBox(20),
          deliveryOptionWidget(
              title: "Delivery by Scooter",
              index: 1
          ),
          WidgetDesigns.hBox(20),
          deliveryOptionWidget(
              title: "Delivery by Bicycle or on Foot",
              index: 2
          ),
          WidgetDesigns.hBox(20),
          CustomAnimatedButton(
              onTap: () {
                Get.toNamed(Routes.documentVerificationScreen);
              },
              text: "Continue"
          )
        ],
      );
    });
  }

  Widget deliveryOptionWidget({
    required String title,
    required int index
  }) {
    bool isSelected = controller.selectedOptionIndex.value == index;
    return InkWell(
      borderRadius: BorderRadius.circular(30),
      onTap: () => controller.selectOption(index),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppTheme.lightGrey,
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
              style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}