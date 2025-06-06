import 'package:cloud_bites_driver/app/core/app_exports.dart';

class MyWalletScreen extends StatelessWidget{

  final MyWalletController controller = Get.put(MyWalletController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: AppTheme.white ,title: 'My Wallet'),
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(14.0),
          child: Column(
            children: [
              Container(
                width: 380,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(182, 86, 142, 1),
                      Color.fromRGBO(95, 182, 227, 1),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Availble Balance',
                        style: AppFontStyle.text_18_400(AppTheme.white,fontFamily: AppFontFamily.generalSansRegular),
                      ),
                      WidgetDesigns.hBox(5),
                      Text(
                        'P400',
                        style: AppFontStyle.text_40_500(AppTheme.white, fontFamily: AppFontFamily.generalSansRegular),
                      ),
                      WidgetDesigns.hBox(15),
                      Container(
                          width: 145,
                          height: 50,
                          padding: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25)
                          ),
                          child: GestureDetector(
                            onTap: () => Get.toNamed(Routes.withdrawScreen),
                            child: Center(
                              child: Text(
                                'Withdraw',
                                style: AppFontStyle.text_16_500(AppTheme.pink,fontFamily: AppFontFamily.generalSansMedium),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
              WidgetDesigns.hBox(20),
              Row(
                children: [
                  Text(
                    'Transaction History',
                    style: AppFontStyle.text_22_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Text(
                        'See All',
                        style: AppFontStyle.text_16_500(AppTheme.pink, fontFamily: AppFontFamily.generalSansMedium),
                      ),
                      Icon(Icons.arrow_forward, color: AppTheme.pink, size: 16)
                    ],
                  )
                ],
              ),
              Obx(() => Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.items.length,
                  itemBuilder: (context, index){
                    var item = controller.items[index];
                    return _transactionHistory(
                        context,
                        images: item['images'] as String,
                        name: item['name'] as String,
                        dateTime: item['dateTime'] as String,
                        count: item['count'] as String,
                        status: item['status'] as String,
                        countColor: item['countColor'] as Color
                    );
                  },
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _transactionHistory(
      BuildContext context, {
        required String images,
        required String name,
        required String dateTime,
        required String count,
        required String status,
        required Color countColor
      }) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Container(
          padding: const EdgeInsets.all(1.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color.fromRGBO(232, 232, 233, 1)
          ),
          child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
            ),
            child: Row(
              children: [
                Container(
                  height:44,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13.0),
                      gradient: LinearGradient(
                        colors: [
                          Color.fromRGBO(248, 238, 244, 1),
                          Color.fromRGBO(239, 247, 252, 1)
                        ],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      )
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SvgPicture.asset(images),
                  ),
                ),
                WidgetDesigns.wBox(8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style: AppFontStyle.text_12_400(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                          ),
                          const Spacer(),
                          Text(
                            count,
                            style: AppFontStyle.text_14_500(countColor, fontFamily: AppFontFamily.generalSansRegular),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            dateTime,
                            style: AppFontStyle.text_14_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                          ),
                          const Spacer(),
                          Text(
                            status,
                            style: AppFontStyle.text_14_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}