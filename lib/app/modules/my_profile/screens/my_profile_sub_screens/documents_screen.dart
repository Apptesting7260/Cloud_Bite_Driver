import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DocumentsScreen extends StatelessWidget{

  final DocumentsController controller = Get.put(DocumentsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: AppTheme.white, title: 'Documents'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetDesigns.hBox(20),
              pendingDocuments(),
            ],
          ),
        ),
      ),
    );
  }
  Widget pendingDocuments()  {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.pendingDocsList.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
            itemBuilder: (context, index) {
              final doc = controller.pendingDocsList[index];
              return pendingDocumentsNames(
                doc["title"], doc["image"]
              );
            },
          ),
        ],
      ),
    );
  }

  Widget pendingDocumentsNames(String title, String image) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: AppTheme.lightGradient
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              SvgPicture.asset(image),
              WidgetDesigns.wBox(10),
              Text(
                title,
                style: AppFontStyle.text_16_500(AppTheme.black),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey)
            ],
          ),
        )
    );
  }
}