import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/bar_chart.dart';

class EarningsScreen extends StatelessWidget{

  final EarningsController controller = Get.put(EarningsController());
  final List<double> earningsData = [1200, 400, 800, 200, 500, 1000, 100];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'Earnings'),
      body: Column(
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
          WidgetDesigns.hBox(20),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 300,
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
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text("Feb 12 - 18", style: AppFontStyle.text_16_500(AppTheme.black)),
                      ),
                      WidgetDesigns.hBox(20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: EarningsBarChart(values: earningsData),
                      ),
                    ],
                  )
              ),
            ),
          ),


        ],
      ),
    );
  }
}
