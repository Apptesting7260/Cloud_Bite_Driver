import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/registration_complete_screen/controller/registration_complete_controller.dart';

class RegistrationCompleteScreen extends StatelessWidget{

  final RegistrationCompleteController controller = Get.put(RegistrationCompleteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetDesigns.hBox(10),
              Text(
                'Registration Complete',
                style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(20),
              Text(
                'Your application is under Verification',
                style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(10),
              Text(
                'Account will get activated in 24hrs',
                style: AppFontStyle.text_14_400(AppTheme.red, fontFamily: AppFontFamily.generalSansRegular),
              ),
              WidgetDesigns.hBox(40),
              documentsOptions(),
              WidgetDesigns.hBox(20),
              CustomAnimatedButton(
                  onTap: (){
                    Get.toNamed(Routes.homeScreen);
                  },
                  text: 'Go To Home'
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget documentsOptions()  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        documentNames("Personal Documents", 'Verification Pending', AppTheme.yellow),

        WidgetDesigns.hBox(20),
        documentNames("Vehicle Details", 'Approved', AppTheme.green),

        WidgetDesigns.hBox(20),
        documentNames("Bank Account Details", 'Approved', AppTheme.green)
      ],
    );
  }

  Widget documentNames(String title, String statusText, Color color) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(
                color: AppTheme.lightGrey
            )
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFontStyle.text_16_500(AppTheme.black),
                  ),
                  WidgetDesigns.hBox(5),
                  Text(
                    statusText,
                    style: AppFontStyle.text_14_500(color),
                  ),
                ],
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey)
            ],
          ),
        )
    );
  }
}