import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/controller/total_delivery_controller.dart';

class DeliveriesScreen extends StatelessWidget{

  final TotalDeliveryController controller = Get.put(TotalDeliveryController());

  DeliveriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'Deliveries'),
     body: SafeArea(
       child: Padding(
         padding: REdgeInsets.all(10.0),
         child: Obx(() {
           if (controller.totalDeliveriesResponse.value.status == ApiStatus.loading && controller.totalDeliveries.isEmpty) {
             return Center(child: Lottie.asset(
               ImageConstants.loaderJson,
               width: 180,
               height: 180,
               fit: BoxFit.contain,
             ),);
           }

           if (controller.totalDeliveriesResponse.value.status == ApiStatus.error) {
             return Center(
               child: Text(
                 controller.totalDeliveriesResponse.value.message ?? 'Error loading data',
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
                 Row(
                   children: [
                     SizedBox(
                        width: 150.w,
                       child: SimpleCustomDropdown(
                         selectedValue: controller.selectedFilter.value,
                         contentPadding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
                         items: ["All", "This Month", "This Year"],
                         onChanged: (p0) {
                           if(p0 != null){
                             controller.selectedFilter.value = p0;
                             controller.refreshTopProducts();
                           }

                       },),
                     ),

                   ],
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
                               ? Lottie.asset(
                                 ImageConstants.loaderJson,
                                 width: 200,
                                 height: 200,
                                 fit: BoxFit.contain,
                               )
                               : Container(),
                             ),
                           );
                         }

                         final totalDeliveries = controller.totalDeliveries[index];
                         return InkWell(
                           onTap: () {
                             Get.toNamed(Routes.specificDateDeliveriesScreen, arguments: {"date": totalDeliveries.date ?? WidgetDesigns.getCurrentDate()});
                           },
                           child: deliveriesWidget(
                             day: totalDeliveries.date ?? "",
                             price: "P${totalDeliveries.totalCharge ?? ""}",
                             totalDeliveries: "${totalDeliveries.deliveries} Deliveries",
                           ),
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


  deliveriesWidget({String day = "", String totalDeliveries = "", String price  =  ""}) {
    return Container(
      height: 90.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(width: 0.7, color: AppTheme.grey50),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 18.0, vertical: 6),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                  ),
                  WidgetDesigns.hBox(5),
                  Text(
                    totalDeliveries,
                    style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    price,
                    textAlign: TextAlign.start,
                    style: AppFontStyle.text_20_500(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium,height: 1.6),
                  ),
                  WidgetDesigns.hBox(10),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: AppTheme.grey50,
                    size: 20,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

}