import 'package:cloud_bites_driver/app/core/app_exports.dart';

class EditPerosnalDetails extends StatelessWidget{

  final EditPersonalDetailsController controller = Get.put(EditPersonalDetailsController());
  final PersonalDetailsController detailController = Get.put(PersonalDetailsController());
  final String imageBaseUrl = "https://cloudbites.s3.af-south-1.amazonaws.com/";

  final StorageServices _storageService = Get.find<StorageServices>();

   EditPerosnalDetails({super.key});
  StorageServices get storageServices => _storageService;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white,title: 'Edit Details'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                WidgetDesigns.hBox(20),
                SizedBox(
                  width: 70,
                  height: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(35.0),
                    child: Obx(() {
                      if (controller.profileImage.value != null) {
                        return Image.file(
                          controller.profileImage.value!,
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        );
                      } else {
                        return CachedNetworkImage(
                          imageUrl: "$imageBaseUrl${storageServices.getProfile()}",
                          placeholder: (context, url) {
                            return ShimmerBox(width: 70, height: 70);
                          },
                          errorWidget: (context, url, error) {
                            return Image.asset(ImageConstants.default_image);
                          },
                          fit: BoxFit.cover,
                          width: 70,
                          height: 70,
                        );
                      }
                    }),
                  ),
                ),
                WidgetDesigns.hBox(10),
                GestureDetector(
                  onTap: () {
                    controller.pickImage(controller.profileImage);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, size: 16, color: AppTheme.primaryColor),
                      WidgetDesigns.wBox(5.0),
                      Text(
                        'Edit',
                        style: AppFontStyle.text_16_400(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansRegular),
                      ),
                    ],
                  ),
                ),
                WidgetDesigns.hBox(30),
                editPersonalDetailsFields()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget editPersonalDetailsFields(){
    return Form(
      key: controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              GetBuilder<EditPersonalDetailsController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.firstNameController,
                      hintText: "First Name",
                      onChanged: (value) {
                        controller.updateFirstNameError('');
                        controller.formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if(controller.firstNameController.text.isEmpty){
                          return 'First name is required';
                        }
      
                        if(controller.firstNameError.value.isNotEmpty || controller.firstNameError.value != ''){
                          return controller.firstNameError.value;
      
                        }
                        return null;
                      },
                    );
                  }
              ),
              WidgetDesigns.hBox(16),
      
              GetBuilder<EditPersonalDetailsController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.lastNameController,
                      hintText: "Last Name",
                      onChanged: (value) {
                        controller.updateLastNameError('');
                        controller.formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if(controller.lastNameController.text.isEmpty){
                          return 'Last name is required';
                        }
      
                        if(controller.lastNameError.value.isNotEmpty || controller.lastNameError.value != ''){
                          return controller.lastNameError.value;
      
                        }
                        return null;
                      },
                    );
                  }
              ),
              WidgetDesigns.hBox(16),
      
              GetBuilder<EditPersonalDetailsController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.dobController,
                      hintText: "Date Of Birth",
                      onChanged: (value) {
                        controller.updateDOBError('');
                        controller.formKey.currentState?.validate();
                      },
                      validator: (value) {
                        if(controller.dobController.text.isEmpty){
                          return 'Date of birth is required';
                        }

                        try {
                          final parts = controller.dobController.text.split('-');
                          if (parts.length != 3) return 'Invalid date format';

                          final selectedDate = DateTime(
                            int.parse(parts[0]),
                            int.parse(parts[1]),
                            int.parse(parts[2]),
                          );

                          final today = DateTime.now();
                          final minDate = DateTime(today.year - 18, today.month, today.day);
                          final maxDate = DateTime(today.year - 100, today.month, today.day);

                          if (selectedDate.isAfter(minDate)) {
                            return 'You must be at least 18 years old';
                          }

                          if (selectedDate.isBefore(maxDate)) {
                            return 'Please enter a valid date (max 100 years)';
                          }
                        } catch (e) {
                          return 'Invalid date format';
                        }
      
                        if(controller.dobError.value.isNotEmpty || controller.dobError.value != ''){
                          return controller.dobError.value;
                        }
                        return null;
                      },
                      suffix: GestureDetector(
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: Get.context!,
                                initialDate: DateTime.now().subtract(const Duration(days: 365 * 25)), // Default to 25 years old
                                firstDate: DateTime.now().subtract(const Duration(days: 365 * 100)), // Max 100 years old
                                lastDate: DateTime.now().subtract(const Duration(days: 365 * 18)), // Min 18 years old
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: AppTheme.primaryColor,
                                        onPrimary: AppTheme.white,
                                        onSurface: Colors.black,
                                      ),
                                      dialogBackgroundColor: Colors.white,
                                    ),
                                    child: child!,
                                  );
                                }
                            );
                            if (pickedDate != null) {
                              String formattedDate = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                              controller.dobController.text = formattedDate;
                              controller.dobError.value = '';
                              print("New DOB: ${controller.dobController.text}");
                            }
                          },
                          child: Icon(Icons.calendar_month, color: AppTheme.primaryColor, size: 20)
                    ),);
                  }
              ),
              WidgetDesigns.hBox(16),
      
              GetBuilder<EditPersonalDetailsController>(
                  builder: (context) {
                    return CustomTextFormField(
                      controller: controller.locationController,
                      hintText: "Address",
                      onChanged: (value) {
                        controller.updateAddressError('');
                        controller.formKey.currentState?.validate();
                      },
                      validator: (value){
                        if(controller.locationController.text.isEmpty){
                          return "Please select address";
                        }
      
                        if(controller.addressError.value.isNotEmpty || controller.addressError.value != ''){
                          return controller.addressError.value;
                        }
                        return null;
                      },
                      //enabled: false,
                    );
                  }
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: () async{
                        final result = await Get.toNamed(Routes.addNewAddress);
                        if (result is Map<String, dynamic>) {
                          controller.locationAddress = result;
                          controller.locationController.text = result['address'] as String;
                        }
                      },
                      child: Text("Choose precise location", style: AppFontStyle.text_14_400(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium),)),
                ],
              ),
              WidgetDesigns.hBox(20),
            ],
          ),
          CustomAnimatedButton(
              onTap: () {
                if (controller.formKey.currentState!.validate()) {
                  controller.updateDriverProfileAPI();
                }
              },
              text: "Save"
          )
        ],
      ),
    );
  }
}