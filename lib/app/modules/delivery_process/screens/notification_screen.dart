import 'package:cloud_bites_driver/app/core/app_exports.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  final NotificationController controller = Get.put(NotificationController());
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 100) {
        if (controller.hasMorePages.value && !controller.isLoadingMore) {
          controller.getNotificationAPi(isPagination: true);
        }
      }
    });

    return Scaffold(
      appBar: const CustomBackButtonAppBar(title: "Notifications",),
      body: Column(
        children: [
          Expanded(child: Obx(() => notificationCard())),
        ],
      ),
    );
  }

  Widget notificationCard() {
    final dataMap = controller.notificationResponse.value.data?.data;

    if (controller.notificationResponse.value.status == ApiStatus.loading) {
      return Center(
        child: Lottie.asset(
          ImageConstants.loaderJson,
          width: 200,
          height: 200,
          fit: BoxFit.contain,
        ),
      );
    }

    if (dataMap?.isEmpty ?? true) {
      return Center(child: Lottie.asset(
        ImageConstants.noDataFoundJson,
        width: 200,
        height: 200,
        fit: BoxFit.contain,
      ));
    }

    final keys = dataMap!.keys.toList();

    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemCount: keys.length, // +1 for loader
      itemBuilder: (context, index) {
        final dateKey = keys[index];
        final items = dataMap[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // WidgetDesigns.hBox(100),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Text(
                WidgetDesigns.formatDate(dateKey),
                style: AppFontStyle.text_16_500(
                  AppTheme.primaryColor,
                  fontFamily: AppFontFamily.generalSansMedium,
                ),
              ),
            ),
            ...items.map((item) => notificationItemCard(item)),
          ],
        );
      },
    );
  }

  Widget notificationItemCard(NotificationItem item) {
    return Container(
      margin: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(8.r),
          bottomRight: Radius.circular(8.r),
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 1,
            spreadRadius: 0.8,
            offset: Offset(0, 0),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 50.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Icon(
              Icons.notifications,
              color: AppTheme.white,
              size: 24.sp,
            ),
          ),
          WidgetDesigns.wBox(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title ?? '',
                    style: AppFontStyle.text_16_500(
                      AppTheme.darkText,
                      fontFamily: AppFontFamily.generalSansMedium,
                    )),
                WidgetDesigns.hBox(2),
                Text(item.body ?? '',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppTheme.grey,
                    fontFamily: AppFontFamily.generalSansRegular,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                WidgetDesigns.hBox(4),
              ],
            ),
          ),
          Text(
            WidgetDesigns.formatTimeFromIso(item.createdAt ?? ""),
            style: AppFontStyle.text_13_400(
              AppTheme.grey,
            ),
          ),
        ],
      ),
    );
  }
}
