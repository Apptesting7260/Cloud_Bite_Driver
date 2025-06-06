import 'package:cloud_bites_driver/app/core/app_exports.dart';

class WithdrawScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(title: 'Withdraw'),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 380,
                  height: 164,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppTheme.lightGrey
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Enter Amount',
                          style: AppFontStyle.text_16_400(AppTheme.lightText,fontFamily: AppFontFamily.generalSansRegular),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'P',
                              style: AppFontStyle.text_18_400(AppTheme.black, fontFamily: AppFontFamily.generalSansSemiBold),
                            ),
                            Text(
                              '100.00',
                              style: AppFontStyle.text_32_500(AppTheme.black, fontFamily: AppFontFamily.generalSansSemiBold),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Total Balance: ',
                              style: AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                            ),
                            Text(
                              'P400',
                              style: AppFontStyle.text_16_400(AppTheme.pink, fontFamily: AppFontFamily.generalSansRegular),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child:  Center(
                          child: Text(
                            'P50',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromRGBO(182, 86, 142, 1),
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child:  Center(
                          child: Text(
                            'P100',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromRGBO(182, 86, 142, 1),
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child:  Center(
                          child: Text(
                            'P50',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromRGBO(182, 86, 142, 1),
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 50,
                      width: 100,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child:  Center(
                          child: Text(
                            'P50',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromRGBO(182, 86, 142, 1),
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child:  Center(
                          child: Text(
                            'P100',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromRGBO(182, 86, 142, 1),
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      width: 100,
                      height: 50,
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
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
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child:  Center(
                          child: Text(
                            'P50',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Color.fromRGBO(182, 86, 142, 1),
                              fontFamily: AppFontFamily.generalSansMedium,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomAnimatedButton(
                    onTap: () => '',
                    text: 'Continue'
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}