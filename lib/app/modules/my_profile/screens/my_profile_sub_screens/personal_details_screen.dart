import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PersonalDetailsScreen extends StatelessWidget{

  final PersonalDetailsController controller = Get.put(PersonalDetailsController());
  final String imageBaseUrl = "https://cloudbites.s3.af-south-1.amazonaws.com/";

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomBackButtonAppBar(backgroundColor: Colors.white,title: 'Personal Details'),
     body: SafeArea(
       child: Padding(
         padding: EdgeInsets.all(10.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Expanded(
               child: SingleChildScrollView(
                 padding: EdgeInsets.all(10.0),
                 child: Obx((){
                   final driverData = controller.driverData.value.data?.data;
                   return Column(
                     children: [
                       WidgetDesigns.hBox(20),
                       if (driverData != null)
                         SizedBox(
                           width: 70,
                           height: 70,
                           child: ClipRRect(
                             borderRadius: BorderRadius.circular(35.0),
                             child: CachedNetworkImage(
                               imageUrl: "$imageBaseUrl${driverData.profilePhoto}",
                               placeholder: (context, url) => ShimmerBox(width: 70, height: 70),
                               errorWidget: (context, url, error) => Image.asset(ImageConstants.default_image),
                               fit: BoxFit.cover,
                             ),
                           ),
                         )
                       else
                         ShimmerBox(width: 70, height: 70),
                       WidgetDesigns.hBox(30),
                       personalInfo(ImageConstants.profileNameIcon, 'First and Last Name' , driverData == null ? buildShimmerOption() : "${driverData.firstName}"+" ""${driverData.lastName}"),
                       WidgetDesigns.hBox(30),
                       personalInfo(ImageConstants.profileDobIcon, 'Date Of Birth' , driverData == null ? buildShimmerOption() : _formatDate(driverData.dateOfBirth)),
                       WidgetDesigns.hBox(30),
                       personalInfo(ImageConstants.profilePhoneIcon, 'Phone Number' ,driverData == null ? buildShimmerOption() : "${driverData.phone}"),
                       WidgetDesigns.hBox(30),
                       personalInfo(ImageConstants.profileEmailIcon, 'Email Address' ,driverData == null ? buildShimmerOption() : "${driverData.email}"),
                       WidgetDesigns.hBox(30),
                       personalInfo(ImageConstants.profileEmailIcon, 'Address' ,driverData == null ? buildShimmerOption() : "${driverData.address}"),
                     ],
                   );
                 }),
               ),
             ),
             CustomAnimatedButton(
                 onTap: (){
                   Get.toNamed(Routes.editPersonalDetailsScreen);
                 },
                 text: 'Edit Details')
           ],
         ),
       ),
     ),
   );
  }

  Widget personalInfo(String iconPath, String headingText, dynamic dataText) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        WidgetDesigns.wBox(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                headingText,
                style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(10),
              if (dataText is String)
                Text(
                  dataText,
                  style: AppFontStyle.text_16_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                )
              else if (dataText is Widget)
                dataText
            ],
          ),
        )
      ],
    );
  }

  Widget buildShimmerOption() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: Get.width * 0.7,
        height: 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
      ),
    );
  }

  catShimmer(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ShimmerBox(width: Get.width, height: 90),
    );

  }

  String _formatDate(String? dateString) {
    if (dateString == null) return "N/A";
    try {
      final date = DateTime.parse(dateString);
      return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
    } catch (e) {
      return "Invalid date";
    }
  }
}