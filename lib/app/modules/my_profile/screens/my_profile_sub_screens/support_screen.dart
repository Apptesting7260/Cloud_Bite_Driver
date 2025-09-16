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
      length: 2,
      child: RefreshIndicator(
        onRefresh: () async {
          await contactSupportController.getFaqData();
        },
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
              faqTab(),
              form(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchFromField() {
    return GetBuilder<SupportController>(
        builder: (context) {
          return CustomTextFormField(
            readOnly: false,
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

  faqTab() {
    return RefreshIndicator(
      color: AppTheme.primaryColor,
      onRefresh: () async {
        await contactSupportController.getFaqData();
      },
      child: Column(
        children: [
          WidgetDesigns.hBox(20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Obx(() => Row(
              children: List.generate(
                4, (index) => Padding(
                padding: REdgeInsets.symmetric(horizontal: 8.0),
                child: GradientButton(
                  horizontalPadding: 22,
                  buttonText: contactSupportController.buttonText[index],
                  isIcon: false,
                  isWhiteBackGround: !(contactSupportController.selectedButton.value == contactSupportController.buttonText[index]),
                  onTap: () {
                    contactSupportController.selectedButton.value = contactSupportController.buttonText[index];
                  },
                ),
              ),
              ),
            )),
          ),
          WidgetDesigns.hBox(20),
          Expanded(  // Add Expanded here
            child: Obx(() => _faqList(
                contactSupportController.selectedButton.value == "General"
                    ? contactSupportController.faqData.value.data?.data?.general
                    : contactSupportController.selectedButton.value == "Account"
                    ? contactSupportController.faqData.value.data?.data?.account
                    : contactSupportController.selectedButton.value == "Service"
                    ? contactSupportController.faqData.value.data?.data?.service
                    : contactSupportController.faqData.value.data?.data?.payment
            )),
          ),
        ],
      ),
    );
  }


  _faqList(RxList<CommonFaqData>? faqList) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: GetBuilder<SupportController>(
        builder: (context) {
          switch(contactSupportController.faqData.value.status) {
            case ApiStatus.loading:
              return ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: 5,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ShimmerBox(width: Get.width, height: 60, radius: 15);
                },
                separatorBuilder: (context, index) => WidgetDesigns.hBox(20.h),
              );
            case ApiStatus.completed:
              return ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: faqList?.length ?? 0,
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return CustomExpansionTile(
                    question: faqList?[index].question ?? '',
                    answer: faqList?[index].answer ?? '',
                  );
                },
                separatorBuilder: (context, index) => WidgetDesigns.hBox(20.h),
              );
            default:
              return ErrorScreen(
                message: contactSupportController.faqData.value.message.toString(),
                buttonText: "Retry",
                onPressed: () async {
                  await contactSupportController.getFaqData();
                },
              );
          }
        },
      ),
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
                      readOnly: false,
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
              Row(
                children: [
                  Flexible(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                      height: 20,
                    ),
                  ),
                  MyText(title: "  or  "),
                  Flexible(
                    child: Divider(
                      color: Colors.grey.shade300,
                      thickness: 1,
                    ),
                  )
                ],
              ).paddingOnly(bottom: 25),

              WidgetDesigns.hBox(10),
              InkWell(
                onTap: () {
                  contactSupportController.launchWhatsApp("2677539323");
                },
                child: Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.2),
                        AppTheme.blueColor.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImageConstants.whatsappImage,height: 25),
                      SizedBox(width: 10,),
                      MyText(title: "WhatsApp us on +267 75 393 23",tColor: Colors.black,),
                    ],
                  ),
                ),
              ).paddingOnly(bottom: 25),
              InkWell(
                onTap: () {
                  contactSupportController.openEmail();
                },
                child: Container(
                  height: 50,
                  width: Get.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [
                        AppTheme.primaryColor.withOpacity(0.2),
                        AppTheme.blueColor.withOpacity(0.2),
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(ImageConstants.emailImage,height: 25),
                      SizedBox(width: 10,),
                      MyText(title: "Email us on support@cloudbitesbw",tColor: Colors.black,),
                    ],
                  ),
                ),
              ).paddingOnly(bottom: 25),
            ],
          ),
        ),
      ),
    );
  }
}