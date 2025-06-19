import 'package:cloud_bites_driver/app/core/app_exports.dart';

class RegistrationCompleteScreen extends StatelessWidget{

  final RegistrationCompleteController controller = Get.put(RegistrationCompleteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Obx((){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                WidgetDesigns.hBox(30),
                Text(
                  'Registration Complete',
                  style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                ),
                WidgetDesigns.hBox(20),
                Text(
                  controller.accountStatusData.value.data?.statusMessage ?? '',
                  style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
                ),
                WidgetDesigns.hBox(10),
                Text(
                  getStatusMessage('${controller.accountStatusData.value.data?.statusMessage}'),
                  style: AppFontStyle.text_14_400(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansRegular),
                ),
                WidgetDesigns.hBox(30),
                documentsOptions(),
                WidgetDesigns.hBox(20),
                CustomAnimatedButton(
                    onTap: (){
                      if(controller.accountStatusData.value.data?.data?.isComplete == true){
                        controller.getHomeStage();
                      }else{
                        CustomSnackBar.show(message:'Your application is Under Verification' , color: AppTheme.primaryColor, tColor: AppTheme.white);
                      }
                    },
                    text: 'Go To Home'
                )
              ],
            );
          })
        ),
      ),
    );
  }

  Widget documentsOptions()  {
    final personalStatus = controller.accountStatusData.value.data?.data?.personalDocsStatus ?? '';
    final vehicleStatus = controller.accountStatusData.value.data?.data?.vehicleDetails ?? '';
    final bankStatus = controller.accountStatusData.value.data?.data?.accountStatus ?? '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        documentNames("Personal Documents", personalStatus, getStatusColor(personalStatus)),

        WidgetDesigns.hBox(20),
        documentNames("Vehicle Details", vehicleStatus , getStatusColor(vehicleStatus)),

        WidgetDesigns.hBox(20),
        documentNames("Bank Account Details", bankStatus, getStatusColor(bankStatus))
      ],
    );
  }

  String getStatusMessage(String status) {
    switch (status) {
      case 'Your application is under Verification':
        return 'Account will get activated in 24hrs';
      case 'Your application is completed':
        return 'Your account has been activated';
      case 'Your application is rejected':
        return 'your application has rejected';
      default:
        return '';
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return AppTheme.yellow;
      case 'Approved':
        return AppTheme.green;
      case 'Rejected':
        return AppTheme.red;
      default:
        return Colors.grey;
    }
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