import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/controller/my_profile_sub_screen_controller/payment_method_controller.dart';

import '../../../../utils/custom_widgets/custom_radio.dart';

class PaymentMethodScreen extends GetView<PaymentMethodController> {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(
        backgroundColor: Colors.white,
        title: 'Payment Methods',
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Column(
          children: [
            Flexible(
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.fetchAllPaymentMethodApi();
                },
                child: Obx(() {
                  if (controller.isFetchPayments.value) {
                    // Show shimmer while loading
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Container(
                          // elevation: 1,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Color(0xffE8E8E9)),
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: [
                                ShimmerBox(
                                  width: 60,
                                  height: 60,
                                  isCircle: true,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          ShimmerBox(width: 90, height: 20),
                                          const SizedBox(width: 6),
                                          ShimmerBox(width: 70, height: 20),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      ShimmerBox(width: 190, height: 20),
                                    ],
                                  ),
                                ),
                                ShimmerBox(width: 23, height: 23),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      itemCount: 3,
                    );
                  } else {
                    final paymentData =
                        controller.fetchPaymentMethodData.value.data;

                    if (paymentData == null || paymentData.isEmpty) {
                      // Show no data message
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: MyText(
                            title: "No Payment Methods found",
                            tColor: Colors.grey,
                            fSize: 16,
                          ),
                        ),
                      );
                    }

                    // Show address list
                    return ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final data = paymentData[index];

                        return paymentCard(
                          "${data.methodId ?? ""}",
                          data.methodName ?? "",
                          data.number ?? "",
                          context,
                          index,
                        );
                      },
                      separatorBuilder:
                          (context, index) => SizedBox(height: 10),
                      itemCount: paymentData.length,
                    );
                  }
                }),
              ),
            ),

            SizedBox(height: 20),
Obx((){
  return
            (controller.fetchPaymentMethodData.value.data?.length ??0 ) >= 3 || controller.isFetchPayments.value ==true?SizedBox(): CustomAnimatedButton(
              // isEnabled: true,
              height: 60,
              onTap: () {
                print("paymentids----------${(controller.fetchPaymentMethodData.value.data ?? []).map((e) => e.methodId).toList()}");
                Get.toNamed(Routes.bankDetailsScreen,arguments: {"ids":(controller.fetchPaymentMethodData.value.data ?? []).map((e) => e.methodId).toList() });
                // Get.to(()=>MapScreen());
              },
              text: "+ Add New Payment",
            );
}),
            SizedBox(height: 20),

            // CustomAnimatedButton(height: 60, onTap: () {}, text: "Apply"),
          ],
        ),
      ),
    );
  }

  Widget paymentCard(
    String id,
    String title,
    String subtitle,
    BuildContext context,
    index,
  ) {
    return InkWell(
      onTap: () {
        controller.selectedMethodType.value = id;
        print(id);
      },
      child: Container(
        // elevation: 1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Color(0xffE8E8E9)),
        ),

        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          fSize: 15,
                          title: capitalizeFirstLetter(title),
                          tColor: Colors.black,
                        ),

                        /* InkWell(
                              onTap: () {

                              },
                              child: Image.asset(
                                ImageConstants.editIcon,
                                height: 25,
                              ),
                            ),*/
                      ],
                    ),
                    const SizedBox(height: 8),

                    MyText(title: "${capitalizeFirstLetter(title)} number:${subtitle}", fWeight: FontWeight.w400),
                  ],
                ),
              ),
              const SizedBox(width: 20),

              /*Obx(() {
                return CustomRadio(
                  value: id,
                  groupValue: controller.selectedMethodType.value,
                  onChanged: (value) {
                    controller.selectedMethodType.value = value;
                  },
                );
              }),*/
            ],
          ),
        ),
      ).paddingOnly(top: 20),
    );
  }

  static String capitalizeFirstLetter(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }
}
