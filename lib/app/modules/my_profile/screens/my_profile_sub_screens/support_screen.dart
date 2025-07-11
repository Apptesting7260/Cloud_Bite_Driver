import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SupportScreen extends StatefulWidget{
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreen();
}

class _SupportScreen extends State<SupportScreen> {
  final SupportController contactSupportController = Get.put(
      SupportController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Support"),
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromRGBO(239, 239, 239, 1)
                ),
                child: const Center(
                  child: Icon(
                    size: 20,
                    Icons.arrow_back_ios_new,
                  ),
                ),
              ),
            ),
          ),
          toolbarHeight: 80,
          bottom: TabBar(
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: AppTheme.black,
            indicatorColor: AppTheme.primaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 12),
            tabs: const [
              Tab(text: "FAQs"),
              Tab(text: "Contact Us"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(),
            form(),
          ],
        ),
      ),
    );
  }

  Widget searchFromField() {
    return GetBuilder<SupportController>(
        builder: (context) {
          return CustomTextFormField(
            suffix:  contactSupportController.searchQuery != ""
                ? IconButton(
              onPressed: (){
                contactSupportController.updateSearchQuery("");
              },
              icon: Icon(Icons.cancel_outlined, color: AppTheme.darkText14,size: 20.w),
            )
                : const SizedBox.shrink(),

            controller: contactSupportController.searchController,
            onTapOutside: (value){
              FocusManager.instance.primaryFocus!.unfocus();
            },
            prefix: Padding(
              padding: const EdgeInsets.only(left: 15, right: 10),
              child: SvgPicture.asset(
                ImageConstants.searchLogo,
                height: 24,
                width: 24,
              ),
            ),
            onChanged: (value){
              contactSupportController.updateSearchQuery(value);
            },
            hintText: "Search icon",
          );
        }
    );
  }

  form(){
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Form(
          key: contactSupportController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetDesigns.hBox(50),
              GetBuilder<SupportController>(
                  builder: (context,) {
                    return CustomTextFormField(
                      controller: contactSupportController.messageController,
                      hintText: "Message",
                      minLines: 4,
                      maxLines: 4,
                      alignLabelWithHint: true,
                      textInputAction: TextInputAction.newline,
                      textInputType: TextInputType.multiline,
                      borderDecoration: OutlineInputBorder(
                        borderSide:  const BorderSide(width: 0, color: AppTheme.boxBgColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:  const BorderSide(width: 0.7, color: AppTheme.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      validator: (value){
                        if(value == null || value.isEmpty || value == ''){
                          return contactSupportController.isValidation ? "Message is required!" : null;
                        }
                        return null;
                      },
                      onTapOutside: (value){
                        FocusManager.instance.primaryFocus!.unfocus();
                      },
                    );
                  }
              ),
              WidgetDesigns.hBox(35),
              GetBuilder<SupportController>(
                  builder: (context,) {
                    return CustomAnimatedButton(
                      onTap: (){
                        contactSupportController.updateValidation(true);
                        if(contactSupportController.formKey.currentState!.validate()){
                          contactSupportController.contactUsApi();
                        }
                      },
                      text: 'Submit',
                    );
                  }
              ),
              WidgetDesigns.hBox(35),
            ],
          ),
        ),
      ),
    );
  }

}