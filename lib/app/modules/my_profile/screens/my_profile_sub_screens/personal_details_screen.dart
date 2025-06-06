import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PersonalDetailsScreen extends StatelessWidget{

  final PersonalDetailsController controller = Get.put(PersonalDetailsController());

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
             Column(
               children: [
                 WidgetDesigns.hBox(20),
                 personalInfo(ImageConstants.profileNameIcon, 'First and Last Name' ,'Thato Setlhare'),
                 WidgetDesigns.hBox(30),
                 personalInfo(ImageConstants.profileDobIcon, 'Date Of Birth' ,'15/09/2000'),
                 WidgetDesigns.hBox(30),
                 personalInfo(ImageConstants.profilePhoneIcon, 'Phone Number' ,'+267 70000000'),
                 WidgetDesigns.hBox(30),
                 personalInfo(ImageConstants.profileEmailIcon, 'Email Address' ,'yourname@gmail.com'),
                 WidgetDesigns.hBox(30),
                 personalInfo(ImageConstants.profileAddressIcon, 'Address' ,'D 888 Abc Road, Greenfield, Abc....'),
               ],
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

  Widget personalInfo(String iconPath, String headingText, String dataText) {
    return Row(
      children: [
        SvgPicture.asset(iconPath),
        WidgetDesigns.wBox(10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headingText,
              style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
            ),
            WidgetDesigns.hBox(10),
            Text(
              dataText,
              style: AppFontStyle.text_16_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
            )
          ],
        )
      ],
    );
  }
}