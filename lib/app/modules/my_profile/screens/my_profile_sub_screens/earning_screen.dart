import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/bar_chart.dart';

class EarningsScreen extends StatelessWidget{

  final EarningsController controller = Get.put(EarningsController());
  final List<double> earningsData = [1200, 400, 800, 200, 500, 1000, 100];

   EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'Earnings'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WidgetDesigns.hBox(20),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: AppTheme.newLightGradient
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          'Total Earnings',
                          style: AppFontStyle.text_16_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium)
                      ),
                      Spacer(),
                      Text(
                        '\$500',
                        style: AppFontStyle.text_24_500(AppTheme.red, fontFamily: AppFontFamily.generalSansMedium),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                height: 280,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: AppTheme.newLightGradient
                ),
                child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text("Feb 12 - 18", style: AppFontStyle.text_16_500(AppTheme.black)),
                        ),
                        WidgetDesigns.hBox(20),
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: EarningsBarChart(values: earningsData),
                        ),
                      ],
                    )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'February 12, 2025',
                    style: AppFontStyle.text_20_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                  ),
                  WidgetDesigns.hBox(10),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Deliveries',
                            style: AppFontStyle.text_18_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                          ),
                          WidgetDesigns.hBox(5),
                          Text(
                            '50 deliveries',
                            style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                          )
                        ],
                      ),
                      Spacer(),
                      Text(
                        'P500',
                        style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                      ),
                      WidgetDesigns.wBox(10),
                      Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.grey)
                    ],
                  ),
                  WidgetDesigns.hBox(10),
                  Row(
                    children: [
                      Text(
                        'Charges & Taxes',
                        style: AppFontStyle.text_18_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                      ),
                      Spacer(),
                      Text(
                        '-P50',
                        style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                      )
                    ],
                  ),
                  WidgetDesigns.hBox(10),
                  Row(
                    children: [
                      Text(
                        'Total KM',
                        style: AppFontStyle.text_18_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular),
                      ),
                      Spacer(),
                      Text(
                        '49.4 km',
                        style: AppFontStyle.text_16_400(AppTheme.grey, fontFamily: AppFontFamily.generalSansRegular),
                      )
                    ],
                  ),
                  WidgetDesigns.hBox(10),
                  Row(
                    children: [
                      Text(
                        'Balance',
                        style: AppFontStyle.text_20_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium),
                      ),
                      Spacer(),
                      Text(
                        'P450',
                        style: AppFontStyle.text_21_500(AppTheme.primaryColor, fontFamily: AppFontFamily.generalSansMedium),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
