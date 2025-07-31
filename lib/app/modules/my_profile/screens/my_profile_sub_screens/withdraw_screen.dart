// import 'package:cloud_bites_driver/app/core/app_exports.dart';
//
// class WithdrawScreen extends StatelessWidget{
//   const WithdrawScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomBackButtonAppBar(title: 'Withdraw'),
//       body: SafeArea(
//         child: Padding(
//             padding: EdgeInsets.all(14.0),
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 Container(
//                   width: 380,
//                   height: 164,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(30.0),
//                       color: AppTheme.lightGrey
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Enter Amount',
//                           style: AppFontStyle.text_16_400(AppTheme.lightText,fontFamily: AppFontFamily.generalSansRegular),
//                         ),
//                         const SizedBox(height: 10),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'P',
//                               style: AppFontStyle.text_18_400(AppTheme.black, fontFamily: AppFontFamily.generalSansSemiBold),
//                             ),
//                             Text(
//                               '100.00',
//                               style: AppFontStyle.text_32_500(AppTheme.black, fontFamily: AppFontFamily.generalSansSemiBold),
//                             )
//                           ],
//                         ),
//                         const SizedBox(height: 20),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'Total Balance: ',
//                               style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
//                             ),
//                             Text(
//                               'P400',
//                               style: AppFontStyle.text_16_400(AppTheme.pink, fontFamily: AppFontFamily.generalSansRegular),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: 100,
//                       height: 50,
//                       padding: const EdgeInsets.all(1),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color.fromRGBO(182, 86, 142, 1),
//                             Color.fromRGBO(95, 182, 227, 1),
//                           ],
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.white,
//                         ),
//                         child:  Center(
//                           child: Text(
//                             'P50',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: Color.fromRGBO(182, 86, 142, 1),
//                               fontFamily: AppFontFamily.generalSansMedium,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     Container(
//                       width: 100,
//                       height: 50,
//                       padding: const EdgeInsets.all(1),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color.fromRGBO(182, 86, 142, 1),
//                             Color.fromRGBO(95, 182, 227, 1),
//                           ],
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.white,
//                         ),
//                         child:  Center(
//                           child: Text(
//                             'P100',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: Color.fromRGBO(182, 86, 142, 1),
//                               fontFamily: AppFontFamily.generalSansMedium,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     Container(
//                       width: 100,
//                       height: 50,
//                       padding: const EdgeInsets.all(1),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color.fromRGBO(182, 86, 142, 1),
//                             Color.fromRGBO(95, 182, 227, 1),
//                           ],
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.white,
//                         ),
//                         child:  Center(
//                           child: Text(
//                             'P50',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: Color.fromRGBO(182, 86, 142, 1),
//                               fontFamily: AppFontFamily.generalSansMedium,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       height: 50,
//                       width: 100,
//                       padding: const EdgeInsets.all(1),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color.fromRGBO(182, 86, 142, 1),
//                             Color.fromRGBO(95, 182, 227, 1),
//                           ],
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.white,
//                         ),
//                         child:  Center(
//                           child: Text(
//                             'P50',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: Color.fromRGBO(182, 86, 142, 1),
//                               fontFamily: AppFontFamily.generalSansMedium,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     Container(
//                       width: 100,
//                       height: 50,
//                       padding: const EdgeInsets.all(1),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color.fromRGBO(182, 86, 142, 1),
//                             Color.fromRGBO(95, 182, 227, 1),
//                           ],
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.white,
//                         ),
//                         child:  Center(
//                           child: Text(
//                             'P100',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: Color.fromRGBO(182, 86, 142, 1),
//                               fontFamily: AppFontFamily.generalSansMedium,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 5),
//                     Container(
//                       width: 100,
//                       height: 50,
//                       padding: const EdgeInsets.all(1),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(100),
//                         gradient: const LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                           colors: [
//                             Color.fromRGBO(182, 86, 142, 1),
//                             Color.fromRGBO(95, 182, 227, 1),
//                           ],
//                         ),
//                       ),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(100),
//                           color: Colors.white,
//                         ),
//                         child:  Center(
//                           child: Text(
//                             'P50',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14,
//                               color: Color.fromRGBO(182, 86, 142, 1),
//                               fontFamily: AppFontFamily.generalSansMedium,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 CustomAnimatedButton(
//                     onTap: () => '',
//                     text: 'Continue'
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:cloud_bites_driver/app/core/app_exports.dart';
import '../../controller/my_profile_sub_screen_controller/withdraw_controller.dart';

class WithdrawScreen extends StatelessWidget {
  WithdrawScreen({super.key});

  final String walletBalance = Get.arguments['walletBalance'];
  final WithdrawController withdrawController = Get.put(WithdrawController());

  final List<List<String>> amountGroups = [
    ['50', '100', '150'],
    ['500', '1000', '1500'],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(title: 'Withdraw'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                amountDisplayCard(walletBalance),
                const SizedBox(height: 20),
                ...amountGroups.map(
                      (group) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: group
                          .map((amount) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.5),
                        child: amountButton(amount),
                      ))
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                CustomAnimatedButton(
                  onTap: () {},
                  text: 'Continue',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Function widget for amount display section
  Widget amountDisplayCard(String walletBalance) {
    return Container(
      width: 380,
      height: 164,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: AppTheme.lightGrey,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Enter Amount',
              style: AppFontStyle.text_16_400(AppTheme.lightText,
                  fontFamily: AppFontFamily.generalSansRegular),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'P',
                  style: AppFontStyle.text_18_400(AppTheme.black,
                      fontFamily: AppFontFamily.generalSansSemiBold),
                ),
                Center(
                  child: Obx(() =>
                    CustomTextFormField(
                      controller: TextEditingController(text: withdrawController.walletController.value),
                      width: 120.w,
                      borderDecoration: InputBorder.none,
                      errorBorder: InputBorder.none,
                      textInputType: TextInputType.phone,
                      contentPadding: const EdgeInsets.only(bottom: 12, left: 10),
                      onChanged: (value) {
                        withdrawController.balanceString.value = value;
                      },
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(4),
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      textStyle: AppFontStyle.text_32_500(AppTheme.black, fontFamily: AppFontFamily.generalSansSemiBold),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Total Balance: ',
                  style: AppFontStyle.text_16_400(AppTheme.black,
                      fontFamily: AppFontFamily.generalSansRegular),
                ),
                Text(
                  'P$walletBalance',
                  style: AppFontStyle.text_16_400(AppTheme.pink,
                      fontFamily: AppFontFamily.generalSansRegular),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Function widget for each amount button
  Widget amountButton(String amount) {
    return Obx(() =>
      InkWell(
            focusColor: AppTheme.transparent,
            highlightColor: AppTheme.transparent,
            splashColor: AppTheme.transparent,
            hoverColor: AppTheme.transparent,
            onTap: () {
              withdrawController.walletController.value = amount;
              withdrawController.balanceString.value = amount;
            },
            child: Container(
              width: 100,
              height: 50,
              padding: const EdgeInsets.all(1),
              decoration: withdrawController.balanceString.value == amount
              ? BoxDecoration(
                borderRadius: BorderRadius.circular(100),
              )
              : BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromRGBO(182, 86, 142, 1),
                    Color.fromRGBO(95, 182, 227, 1),
                  ],
                ),
              ),
              child: Container(
                decoration: withdrawController.balanceString.value == amount
                ? BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(182, 86, 142, 1),
                      Color.fromRGBO(95, 182, 227, 1),
                    ],
                  ),
                )
                : BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "P$amount",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: withdrawController.balanceString.value == amount ? AppTheme.white : AppTheme.primaryColor,
                      fontFamily: AppFontFamily.generalSansMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
    );

  }
}

