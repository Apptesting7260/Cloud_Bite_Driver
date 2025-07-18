import 'package:cloud_bites_driver/app/core/app_exports.dart';

class HelpCenterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white,title: 'Help Center'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              WidgetDesigns.hBox(20),
              helpCenterOption(Routes.support,ImageConstants.supportIcon, 'Support'),
              WidgetDesigns.hBox(20),
              helpCenterOption(Routes.privacyPolicy,ImageConstants.supportIcon, 'Privacy Policy'),
              WidgetDesigns.hBox(20),
              helpCenterOption(Routes.termsCondition,ImageConstants.supportIcon, 'Terms & Conditions'),
            ],
          ),
        ),
      ),
    );
  }
  Widget helpCenterOption(String onTap, String image, String title){
    return GestureDetector(
      onTap: () => Get.toNamed(onTap),
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
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SvgPicture.asset(image),
            ),
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
}