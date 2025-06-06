import 'package:cloud_bites_driver/app/core/app_exports.dart';

class EditPerosnalDetails extends StatelessWidget{

  final EditPersonalDetailsController controller = Get.put(EditPersonalDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white,title: 'Edit Details'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              WidgetDesigns.hBox(20),
              editPersonalDetailsFields()
            ],
          ),
        ),
      ),
    );
  }

  Widget editPersonalDetailsFields(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            CustomTextFormField(
              controller: controller.firstNameController,
              hintText: "First Name",
              //validator: FormValidators.validateName(value),
            ),
            WidgetDesigns.hBox(16),

            CustomTextFormField(
              controller: controller.lastNameController,
              hintText: "Last Name",
              //validator: FormValidators.validatePassword,
            ),
            WidgetDesigns.hBox(16),

            CustomTextFormField(
              controller: controller.dobController,
              hintText: "Date Of Birth",
              suffix: GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: Get.context!,
                        initialDate: DateTime.now().subtract(Duration(days: 365 * 18)),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: AppTheme.primaryColor, // Header background color
                                onPrimary: Colors.white, // Header text color
                                onSurface: Colors.black, // Body text color
                              ),
                              dialogBackgroundColor: Colors.white,
                            ),
                            child: child!,
                          );
                        }
                    );
                  },
                  child: Icon(Icons.calendar_month, color: AppTheme.primaryColor, size: 20)),
              //validator: FormValidators.validatePassword,
            ),
            WidgetDesigns.hBox(16),

            CustomTextFormField(
              controller: controller.phoneController,
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(controller.checkCountryLength.value),
              ],
              prefix: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      CountryCodePicker(
                        padding: EdgeInsets.zero,
                        flagWidth: 40,
                        margin: EdgeInsets.zero,
                        flagDecoration: const BoxDecoration(
                            shape: BoxShape.circle
                        ),
                        boxDecoration: const BoxDecoration(color: AppTheme.boxBgColor,),
                        onChanged: (CountryCode countryCode) {
                          WidgetDesigns.consoleLog("${countryCode.code}","country code --->>");
                          WidgetDesigns.consoleLog("${countryCode.dialCode}","country dialCode --->>");

                          controller.updateCountryString(countryCode.dialCode.toString());

                          if(controller.countryPhoneDigits[int.parse(countryCode.dialCode.toString().replaceAll("+", ''))] != null){
                            controller.checkCountryLength.value = controller.countryPhoneDigits[int.parse(countryCode.dialCode.toString().replaceAll("+", ''))]!;
                          } else {
                            controller.checkCountryLength.value = 10;
                          }
                        },
                        initialSelection: controller.countryString.value,
                      ),
                      Positioned(
                        right: -6,
                        top: 2,
                        bottom: 2,
                        child: SvgPicture.asset(ImageConstants.downArrow),
                      ),
                    ],
                  ),
                  WidgetDesigns.wBox(15),
                  Container(width: 1,height: 30,color: AppTheme.darkText14,),
                  WidgetDesigns.wBox(10),
                ],
              ),
              hintText: "Phone Number",
            ),

            WidgetDesigns.hBox(16),

            CustomTextFormField(
              controller: controller.emailController,
              hintText: "Email Address",
            ),
            WidgetDesigns.hBox(16),

            CustomTextFormField(
              controller: controller.passwordController,
              hintText: "Password",
            ),
            WidgetDesigns.hBox(16),

            CustomTextFormField(
              controller: controller.locationController,
              hintText: "Location",
            ),
            WidgetDesigns.hBox(20),
          ],
        ),
        CustomAnimatedButton(
            onTap: () {
              Get.back();
            },
            text: "Save"
        )
      ],
    );
  }
}