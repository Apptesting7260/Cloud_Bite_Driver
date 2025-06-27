import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SettingsScreen extends StatelessWidget{
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white,title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            children: [
              WidgetDesigns.hBox(20),
              settingsOption(Routes.notificationSet,ImageConstants.notificationIcon, 'Notification'),
              WidgetDesigns.hBox(20),
              settingsOption(Routes.changePasswordProcessScreen,ImageConstants.passwordIcon, 'Change Password'),
            ],
          ),
        ),
      ),
    );
  }

  Widget settingsOption(String onTap, String image, String title){
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