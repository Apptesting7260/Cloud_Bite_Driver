import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PersonalDocumentScreen extends StatelessWidget{

  final PersonalDocumentController controller = Get.put(PersonalDocumentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Personal Documents",
              style: AppFontStyle.text_24_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
            ),
            WidgetDesigns.hBox(20),
            Text(
              "Upload focused photos of below documents\nfor faster verification",
              style: AppFontStyle.text_16_400(AppTheme.black.withOpacity(0.5), fontFamily: AppFontFamily.generalSansRegular),
            ),
            WidgetDesigns.hBox(20),
            pendingDocuments()
          ],
        ),
      ),
    );
  }

  Widget pendingDocuments()  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        ListView.separated(
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.documentList.length,
          shrinkWrap: true,
          separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
          itemBuilder: (context, index) {
            final doc = controller.documentList[index];
            return documentTypeName(
              doc["title"],
                  () => Get.toNamed(doc["route"]),
            );
          },
        ),

      ],
    );
  }

  Widget documentTypeName(String title, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                Text(
                  title,
                  style: AppFontStyle.text_16_500(AppTheme.black),
                ),
                Spacer(),
                Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey)
              ],
            ),
          )
      ),
    );
  }
}