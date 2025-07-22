import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/controller/my_profile_sub_screen_controller/rating_controller.dart';
import 'package:intl/intl.dart';

/*
class EarningsScreen extends StatelessWidget{

  final EarningsController controller = Get.put(EarningsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'Ratings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetDesigns.hBox(10),
              Container(
                  width: 90,
                  height: 36,
                  padding: const EdgeInsets.all(1.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Color.fromRGBO(212, 212, 212, 1),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: Colors.white
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Latest',
                          style: AppFontStyle.text_14_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Colors.black,
                          size: 14,
                        )
                      ],
                    ),
                  )
              ),
              WidgetDesigns.hBox(10),
              Obx( () => SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index){
                    var item = controller.items[index];
                    return _productListItem(
                      context,
                      profileImage: item['profileImage']!,
                      profileName: item['profileName']!,
                      time: item['time']!,
                      images: item['images']!,
                      dishName: item['dishName']!,
                      description: item['description']!,
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
  Widget _productListItem(
      BuildContext context, {
        required String profileImage,
        required String profileName,
        required String time,
        required String images,
        required String dishName,
        required String description,
      }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  child: Image.asset(profileImage)
                ),
                WidgetDesigns.wBox(10),
                Column(
                  children: [
                    Text(
                      profileName,
                      style: AppFontStyle.text_14_400(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                    WidgetDesigns.hBox(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) => Icon(Icons.star, color: Colors.yellow, size: 13)),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  time,
                  style: AppFontStyle.text_14_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                )
              ],
            ),
            WidgetDesigns.hBox(10),
            Container(
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(232, 232, 233, 1)
              ),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: SizedBox(
                        height: 60,
                        width: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15.0),
                            child: Image.asset(images)
                        ),
                      ),
                    ),
                    WidgetDesigns.wBox(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dishName,
                            style: AppFontStyle.text_14_400(AppTheme.blueColor, fontFamily: AppFontFamily.generalSansMedium),
                          ),
                          WidgetDesigns.hBox(5),
                          Text(
                            description,
                            style: AppFontStyle.text_18_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            WidgetDesigns.hBox(10),
            Text(
                'Dumplings were delicious and delivered right on time! Talk about meeting in the clouds!',
                style: TextStyle(
                    fontFamily: AppFontFamily.generalSansRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey
                )
            ),
            WidgetDesigns.hBox(10),
            Container(
              height: 1,
              decoration: BoxDecoration(
                  color: AppTheme.lightGrey
              ),
            ),
            WidgetDesigns.hBox(5)
          ],
        )
    );
  }
}*/
class RatingScreen extends StatelessWidget {
  final RatingController controller = Get.put(RatingController());

   RatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'Ratings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetDesigns.hBox(10),
              Obx(() {
                if (controller.isLoading.value && controller.currentPage == 1) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.ratingData.value.status == ApiStatus.error) {
                  return Center(
                    child: Text(
                      'Failed to load ratings',
                      style: TextStyle(color: Colors.red),
                    ),
                  );
                } else if (controller.ratingData.value.data?.data == null ||
                    controller.ratingData.value.data!.data!.isEmpty) {
                  return Center(child: Lottie.asset(ImageConstants.noDataFoundJson)); /*Center(
                    child: Text(
                      'No ratings found',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );*/
                }

                return Expanded(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                          scrollNotification.metrics.maxScrollExtent &&
                          !controller.isLoadingMore.value &&
                          controller.hasMore.value) {
                        controller.loadMoreRatings();
                      }
                      return false;
                    },
                    child: ListView.builder(
                      itemCount: controller.ratingData.value.data?.data?.length ?? 0 +
                          (controller.isLoadingMore.value ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == controller.ratingData.value.data!.data!.length &&
                            controller.isLoadingMore.value) {
                          return Center(child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(),
                          ));
                        }

                        var item = controller.ratingData.value.data!.data![index];
                        return _productListItem(
                          context,
                          profileImage: item.userImage ?? ImageConstants.profile,
                          profileName: '${item.userFirstName ?? ''} ${item.userLastName ?? ''}',
                          time: item.createdAt ?? '',
                          images: item.vendorImage ?? ImageConstants.profile,
                          dishName: 'Order #${item.orderId ?? ''}',
                          description: '${item.orderQuantity ?? ''} items',
                          rating: item.rating ?? '0',
                          review: item.driverReview ?? '',
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productListItem(
      BuildContext context, {
        required String profileImage,
        required String profileName,
        required String time,
        required String images,
        required String dishName,
        required String description,
        required String rating,
        required String review,
      }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: profileImage.isNotEmpty
                        ? CachedNetworkImage(
                      imageUrl: "${AppUrls.imageUrl}$profileImage",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.person),
                    ) : Image.asset(ImageConstants.profile, width: 50, height: 50),
                  ),
                ),
                WidgetDesigns.wBox(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      profileName,
                      style: AppFontStyle.text_18_400(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                    WidgetDesigns.hBox(4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(5, (index) {
                        double ratingValue = double.tryParse(rating) ?? 0.0;
                        return Icon(
                            Icons.star,
                            color: index < ratingValue ? Colors.yellow : Colors.grey,
                            size: 13
                        );
                      }),
                    )
                  ],
                ),
                const Spacer(),
                Text(
                  _formatTime(time),
                  style: AppFontStyle.text_14_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                )
              ],
            ),
            WidgetDesigns.hBox(10),
            Container(
              padding: const EdgeInsets.all(1.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromRGBO(232, 232, 233, 1)
              ),
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: images.isNotEmpty
                            ?  CachedNetworkImage(
                          imageUrl: "${AppUrls.imageUrl}$images",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey[200]),
                          errorWidget: (context, url, error) => Icon(Icons.fastfood),
                        ) : Image.asset(ImageConstants.profile, width: 60, height: 60),
                      ),
                    ),
                    WidgetDesigns.wBox(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dishName,
                            style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                          ),
                          WidgetDesigns.hBox(5),
                          Text(
                            description,
                            style: AppFontStyle.text_14_500(AppTheme.grey, fontFamily: AppFontFamily.generalSansMedium),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            WidgetDesigns.hBox(10),
            if (review.isNotEmpty)
              Text(
                review,
                style: TextStyle(
                    fontFamily: AppFontFamily.generalSansRegular,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.grey
                ),
              ),
            WidgetDesigns.hBox(10),
            Container(
              height: 1,
              decoration: BoxDecoration(
                  color: AppTheme.lightGrey
              ),
            ),
            WidgetDesigns.hBox(5)
          ],
        )
    );
  }

  String _formatTime(String time) {
    try {
      DateTime dateTime = DateTime.parse(time);
      return DateFormat('MMM d, HH:mm').format(dateTime);
    } catch (e) {
      return time;
    }
  }
}