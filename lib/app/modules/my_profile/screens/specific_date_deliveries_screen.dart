import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SpecificDateDeliveriesScreen extends StatelessWidget{

  final SpecificDateDeliveryController controller = Get.put(SpecificDateDeliveryController());

  SpecificDateDeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'Deliveries'),
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.all(10.0),
          child: Obx(() {
            if (controller.totalDeliveriesResponse.value.status == ApiStatus.loading && controller.totalDeliveries.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.totalDeliveriesResponse.value.status == ApiStatus.error) {
              return Center(
                child: Text(
                  controller.totalDeliveriesResponse.value.message ?? 'Error loading reviews',
                  style: AppFontStyle.text_14_400(AppTheme.redText),
                ),
              );
            }

            return RefreshIndicator(
              color: AppTheme.primaryColor,
              onRefresh: controller.refreshTopProducts,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WidgetDesigns.hBox(10),
                  Obx(() =>
                    CustomTextFormField(
                      hintText: "Search",
                      controller: controller.searchController,
                      onChanged: (value) {
                        controller.searchQuery.value = value;
                        if(value == "" || value.isEmpty) {
                          controller.fetchSpecificDateDeliveries();
                        }
                      },
                      suffix: controller.searchQuery.isEmpty ? SizedBox.shrink(): InkWell(
                        hoverColor: AppTheme.transparent,
                        focusColor: AppTheme.transparent,
                        highlightColor: AppTheme.transparent,
                        splashColor: AppTheme.transparent,
                        onTap: () {
                          controller.fetchSpecificDateDeliveries();
                        },
                          child: Icon(Icons.search, size: 25,)),
                    ),
                  ),
                  WidgetDesigns.hBox(10),
                  Expanded(
                    child: NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification.metrics.pixels == scrollNotification.metrics.maxScrollExtent && !controller.isLoading.value) {
                          controller.loadMoreTopProducts();
                        }
                        return false;
                      },
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return WidgetDesigns.hBox(15);
                        },
                        itemCount: controller.totalDeliveries.length + (controller.hasMore.value ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index >= controller.totalDeliveries.length) {
                            return Padding(
                              padding: REdgeInsets.all(16.0),
                              child: Center(
                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator()
                                    : Container(),
                              ),
                            );
                          }

                          final totalDeliveries = controller.totalDeliveries[index];
                          return deliveriesWidget(
                            dropTime: totalDeliveries.deliveryTime ?? "",
                            orderId: totalDeliveries.orderId ?? "",
                            pickTime: totalDeliveries.pickupTime ?? "",
                            pickUpFrom: totalDeliveries.pickupFrom ?? "",
                            pickUpTo: totalDeliveries.deliveryTo ?? "",
                            price: totalDeliveries.deliveryCharge ?? "",
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }


  deliveriesWidget({String orderId = "", String pickUpFrom = "", String price  =  "", String pickUpTo = "", String pickTime = "", String dropTime = ""}) {
    return Container(
      // height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 0.7, color: AppTheme.grey50),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
        child: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    orderId,
                    style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                  ),
                  Text(
                    "P$price",
                    style: AppFontStyle.text_18_500(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium),
                  ),
                ],
              ),
              WidgetDesigns.hBox(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(ImageConstants.location, height: 20.h, width: 20.w),
                  WidgetDesigns.wBox(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Pickup from",
                          style: AppFontStyle.text_18_500(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium),
                        ),
                        Text(
                          pickUpFrom,
                          maxLines: 3,
                          style: AppFontStyle.text_15_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular, overflow: TextOverflow.clip),
                        ),
                    
                      Text(
                        pickTime,
                        style: AppFontStyle.text_15_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(ImageConstants.location, height: 20.h, width: 20.w),
                  WidgetDesigns.wBox(8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Delivery to",
                          style: AppFontStyle.text_18_500(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium),
                        ),
                        Text(
                          pickUpTo,
                          maxLines: 3,
                          style: AppFontStyle.text_15_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),

                      Text(
                        dropTime,
                        style: AppFontStyle.text_15_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}