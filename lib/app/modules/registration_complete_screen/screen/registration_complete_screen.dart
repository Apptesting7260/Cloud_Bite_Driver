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
                Obx(() {
                  if (controller.isLoading.value) {
                    return Expanded(
                      child: ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 3,
                        shrinkWrap: true,
                        separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
                        itemBuilder: (context, index) => buildShimmerOption(),
                      ),
                    );
                  }
                  return documentsOptions();
                }),
                WidgetDesigns.hBox(20),
                CustomAnimatedButton(
                    onTap: (){
                      if(controller.accountStatusData.value.data?.isComplete == true){
                        controller.getHomeStage();
                      }else if(controller.accountStatusData.value.data?.statusText == "Rejected"){
                        CustomSnackBar.show(message:'Your Application Is Rejected' , color: AppTheme.primaryColor, tColor: AppTheme.white);
                      }
                      else{
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx((){
          return ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.accountStatusData.value.data?.data?.length ?? 0,
            shrinkWrap: true,
            separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
            itemBuilder: (context, index) {
              final completeDocs = controller.accountStatusData.value.data?.data?[index];
              String? remarks;
              if (completeDocs?.name != null) {
                remarks = _getDocumentRemarks(completeDocs!.name!);
              }
              /*if (completeDocs?.status == "Rejected") {
                remarks = controller.accountStatusData.value.data?.allRemarks?.accountRejectRemark ??
                    controller.accountStatusData.value.data?.allRemarks?.personalRejectRemark;
              }*/
              return documentNames(
                controller.accountStatusData.value.data?.data?[index].name ?? "", "${completeDocs?.status}"  ,getStatusColor("${completeDocs?.status}"),remarks);
            },
          );
        }),

      ],
    );
  }

  String? _getDocumentRemarks(String documentName) {
    if (controller.accountStatusData.value.data?.allRemarks != null) {
      if (documentName.toLowerCase().contains('account')) {
        return controller.accountStatusData.value.data?.allRemarks?.accountRejectRemark;
      } else if (documentName.toLowerCase().contains('personal')) {
        return controller.accountStatusData.value.data?.allRemarks?.personalRejectRemark;
      }
    }
    return null;
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


  Widget documentNames(String title, String statusText, Color color, String? remarks) {
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
              if (statusText == "Rejected" && remarks != null && remarks.isNotEmpty)
                GestureDetector(
                  onTap: () {
                    controller.showRejectionDialog(remarks);
                  },
                  child: const Icon(
                    Icons.info_outline,
                    size: 20,
                    color: AppTheme.red,
                  ),
                ),
              WidgetDesigns.wBox(10),
              GestureDetector(
                onTap: () {
                  statusText == "Rejected" ? Get.toNamed(Routes.documentVerificationScreen) : '';
                },
                  child: Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppTheme.grey)
              )
            ],
          ),
        )
    );
  }
  Widget buildShimmerOption() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: Get.width,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white,
        ),
      ),
    );
  }
}