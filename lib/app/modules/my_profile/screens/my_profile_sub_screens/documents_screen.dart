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
              //pendingDocuments(),
              Obx(() {
                if (controller.isLoading.value) {
                  return Expanded(
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.documentListData.value.data?.data?.length ?? 0,
                      shrinkWrap: true,
                      separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
                      itemBuilder: (context, index) => buildShimmerOption(),
                    ),
                  );
                }
                // Show actual data when loaded
                return pendingDocuments();
              }),
            ],
          ),
        ),
      ),
    );
  }
  Widget pendingDocuments()  {
    final pendingDocs = controller.getPendingDocsList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            itemCount: pendingDocs.length,
            shrinkWrap: true,
            separatorBuilder: (_, __) => WidgetDesigns.hBox(20),
            itemBuilder: (context, index) {
              final doc = pendingDocs[index];
              final docData = controller.documentListData.value.data?.data?[index];
              final allCompletedData = controller.documentListData.value.data;
              return pendingDocumentsNames(
                docData?.name.toString() ?? '',
                doc["image"],
                  allCompletedData?.allComplete ?? false);
            },
          ),
        ],
      ),
    );
  }

  Widget pendingDocumentsNames(String title, String image, bool isCompleted) {
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
              Row(
                children: [
                  Icon(
                      isCompleted ? Icons.check_circle : Icons.hourglass_bottom_rounded,
                      size: 14,
                      color: isCompleted ? AppTheme.green : AppTheme.grey
                  ),
                  WidgetDesigns.wBox(10),
                  if(!isCompleted)
                    Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.grey),
                ],
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