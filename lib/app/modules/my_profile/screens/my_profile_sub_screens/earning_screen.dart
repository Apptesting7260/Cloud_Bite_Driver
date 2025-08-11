import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/utils/custom_widgets/bar_chart.dart';

class EarningsScreen extends StatelessWidget {
  final EarningsController controller = Get.put(EarningsController());
  final List<double> earningsData = [1200, 400, 800, 200, 500, 1000, 100];

  EarningsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx((){
      switch(controller.earningAPIData.value.status){

        case ApiStatus.loading:
          return Scaffold(
            appBar: CustomBackButtonAppBar(
              backgroundColor: Colors.white,
              title: 'Earnings',
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    WidgetDesigns.hBox(20),
                    ShimmerBox(width: double.infinity, height: 60.h),
                    WidgetDesigns.hBox(20),
                    ShimmerBox(width: double.infinity, height: 280.h),
                    WidgetDesigns.hBox(30),
                    ShimmerBox(width: 200.w, height: 25.h),
                    WidgetDesigns.hBox(8),
                    ShimmerBox(width: 150.w, height: 25.h),
                    WidgetDesigns.hBox(8),
                    ShimmerBox(width: 120.w, height: 25.h),
                    WidgetDesigns.hBox(8),
                    ShimmerBox(width: 100.w, height: 25.h),
                    WidgetDesigns.hBox(8),
                    ShimmerBox(width: 80.w, height: 25.h),                ],
                ),
              ),
            ),
          );
        case ApiStatus.completed:
          return Scaffold(
            appBar: CustomBackButtonAppBar(
              backgroundColor: Colors.white,
              title: 'Earnings',
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  WidgetDesigns.hBox(20),
                  _buildEarningsHeader(),
                  _buildEarningsGraphCard(),
                  _buildDayEarningsDetail(),
                ],
              ),
            ),
          );
        default:
          return ErrorScreen(
            message: controller.earningAPIData.value.message.toString(),
            buttonText: "Retry",
            onPressed: () async {
              await controller.getEarningApi();
          },);
      }
    });
  }

  Widget _buildEarningsHeader() {
    return _cardContainer(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Total Earnings',
            style: AppFontStyle.text_16_500(
              AppTheme.black,
              fontFamily: AppFontFamily.generalSansMedium,
            ),
          ),
          const Spacer(),
          Text(
            'P${controller.earningAPIData.value.data?.data?.totalEarning ?? ""}',
            style: AppFontStyle.text_24_500(
              AppTheme.red,
              fontFamily: AppFontFamily.generalSansMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsGraphCard() {
    return _cardContainer(
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if(controller.selectedChartType.value.toLowerCase() == "weekly") ...[
                  Obx(()=>Expanded(child: Text("${WidgetDesigns.dayMonth(controller.weekStartDate.value)} - ${WidgetDesigns.dayMonth(controller.weekEndDate.value)}", style: TextStyle(fontSize: 16)))),
                ] else ...[
                  Obx(()=>Expanded(child: Text("${WidgetDesigns.getMonthName(controller.monthNo.value)} - ${controller.year.value}", style: TextStyle(fontSize: 16)))),

                ],
                chartSwitch(),
              ],
            ),
          ),
          WidgetDesigns.hBox(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap:
                controller.selectedChartType.value.toLowerCase() == "weekly"
                ? () {
                  controller.weekOffSet.value--;
                  controller.weekStartDate.value = WidgetDesigns.getWeekRange(controller.weekOffSet.value)["start"]!;
                  controller.weekEndDate.value = WidgetDesigns.getWeekRange(controller.weekOffSet.value)["end"]!;
                  controller.getEarningApi();
                }
                : (){
                  controller.monthOffSet.value--;
                  controller.monthNo.value = WidgetDesigns.getMonthInfo(controller.monthOffSet.value)["month"]!;
                  controller.year.value = WidgetDesigns.getMonthInfo(controller.monthOffSet.value)["year"]!;
                  controller.getEarningApi();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_back_ios, size: 20, color: AppTheme.grey),
                ),
              ),
              Spacer(),
              Obx(()=>Text(controller.earningAPIData.value.data?.data?.earningAmount == "" ?  "" : "P${controller.earningAPIData.value.data?.data?.earningAmount}", style: TextStyle(fontSize: 16))),
              Spacer(),
              if((controller.selectedChartType.value.toLowerCase() == "weekly" && controller.weekOffSet.value < 0) ||
                  (controller.selectedChartType.value.toLowerCase() == "monthly" && controller.monthOffSet.value < 0))  ...[
                InkWell(
                onTap: controller.selectedChartType.value.toLowerCase() == "weekly"
                ? () {
                  controller.weekOffSet.value++;
                  controller.weekStartDate.value = WidgetDesigns.getWeekRange(controller.weekOffSet.value)["start"]!;
                  controller.weekEndDate.value = WidgetDesigns.getWeekRange(controller.weekOffSet.value)["end"]!;
                  controller.getEarningApi();
                }
                : (){
                  controller.monthOffSet.value++;
                  controller.monthNo.value = WidgetDesigns.getMonthInfo(controller.monthOffSet.value)["month"]!;
                  controller.year.value = WidgetDesigns.getMonthInfo(controller.monthOffSet.value)["year"]!;
                  controller.getEarningApi();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_forward_ios, size: 20, color: AppTheme.grey),
                ),
              ),] else ...[
                SizedBox(width: 32,)
              ]
            ],
          ),
          WidgetDesigns.hBox(20),
          Obx(() =>
            Padding(
              padding: REdgeInsets.all(8),
              child: controller.isLoading.value
                ? SizedBox(
                height: 220,
                  child: Center(
                    child: CircularProgressIndicator(color: AppTheme.primaryColor,),
                  ),
               )
                : EarningsBarChart(
                values: controller.earningAPIData.value.data?.data?.earning?.map((e) => double.tryParse(e.totalDeliveryCharge ?? "0.0") ?? 0.0,).toList() ?? [],
                bottomValues: controller.earningAPIData.value.data?.data?.earning?.map((e) => WidgetDesigns.getDayOnly(e.day.toString()),).toList() ?? [],
                selectedChartType: controller.selectedChartType.value,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayEarningsDetail() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(controller.selectedChartType.value.toLowerCase() == "weekly") ...[
            Obx(()=>Text("${WidgetDesigns.dayMonth(controller.weekStartDate.value)} - ${WidgetDesigns.dayMonth(controller.weekEndDate.value)}", style: AppFontStyle.text_20_500(
              AppTheme.black,
              fontFamily: AppFontFamily.generalSansMedium,
            ),)),
          ] else ...[
            Obx(()=>Text("${WidgetDesigns.getMonthName(controller.monthNo.value)} - ${controller.year.value}", style: AppFontStyle.text_20_500(
              AppTheme.black,
              fontFamily: AppFontFamily.generalSansMedium,
            ),)),

          ],
          WidgetDesigns.hBox(10),
          Obx(() => _infoRow(
              title: 'Deliveries',
              subtitle: controller.earningAPIData.value.data?.data?.order == "" ?  "" : "${controller.earningAPIData.value.data?.data?.order} deliveries",
              trailing: controller.earningAPIData.value.data?.data?.earningAmount == "" ?  "" : "P${controller.earningAPIData.value.data?.data?.earningAmount}",
              showArrow: true,
            ),
          ),
          // _infoRow(title: 'Charges & Taxes', trailing: '-P50'),
          // _infoRow(title: 'Total KM', trailing: '49.4 km'),
          Obx(() =>
            _infoRow(
              title: 'Balance',
              trailing: controller.earningAPIData.value.data?.data?.earningAmount == "" ?  "" : "P${controller.earningAPIData.value.data?.data?.earningAmount}",
              trailingStyle: AppFontStyle.text_21_500(
                AppTheme.primaryColor,
                fontFamily: AppFontFamily.generalSansMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _cardContainer({required double height, required Widget child}) {
    return Padding(
      padding: REdgeInsets.all(12.0),
      child: Container(
        // height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: AppTheme.newLightGradient,
        ),
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }

  Widget _infoRow({
    required String title,
    String? subtitle,
    required String trailing,
    bool showArrow = false,
    TextStyle? trailingStyle,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppFontStyle.text_18_400(
                    AppTheme.black,
                    fontFamily: AppFontFamily.generalSansRegular,
                  ),
                ),
                if (subtitle != null) ...[
                  WidgetDesigns.hBox(5),
                  Text(
                    subtitle,
                    style: AppFontStyle.text_16_400(
                      AppTheme.grey,
                      fontFamily: AppFontFamily.generalSansRegular,
                    ),
                  ),
                ],
              ],
            ),
          ),
          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.deliveriesScreen, arguments: {
                "date": controller.selectedChartType.value.toLowerCase() == "weekly"
                    ? "${WidgetDesigns.dayMonth(controller.weekStartDate.value)} - ${WidgetDesigns.dayMonth(controller.weekEndDate.value)}"
                    : "${WidgetDesigns.getMonthName(controller.monthNo.value)} - ${controller.year.value}",
              });
            },
            child: Row(
              children: [
                Text(
                  trailing,
                  style: trailingStyle ??
                      AppFontStyle.text_16_400(
                        AppTheme.grey,
                        fontFamily: AppFontFamily.generalSansRegular,
                      ),
                ),
                WidgetDesigns.wBox(4),
                if (showArrow) ...[
                  WidgetDesigns.wBox(10),
                  Icon(Icons.arrow_forward_ios_rounded, size: 12, color: AppTheme.grey),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }

  chartSwitch(){
    return Obx(() =>
      Container(
        height: 40.h,
        width: 150,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor20,
          border: Border.all(color: AppTheme.grey50,width: 1),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedChartType.value = "weekly";
                  controller.getEarningApi();
                },
                child: Container(

                  decoration:
                  controller.selectedChartType.value.toLowerCase() != "weekly"
                  ? BoxDecoration(
                    color: AppTheme.transparent,
                    borderRadius: BorderRadius.circular(30),
                  )
                  : BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(child: Text("Weekly",style: AppFontStyle.text_12_400(controller.selectedChartType.value.toLowerCase() == "weekly" ? AppTheme.white : AppTheme.black, fontFamily: AppFontFamily.generalSansRegular))),
                  ),
                ),
              ),
            ),
          WidgetDesigns.wBox(2),
            Expanded(
              child: InkWell(
                onTap: () {
                  controller.selectedChartType.value = "monthly";
                  controller.getEarningApi();
                },
                child: Container(

                  decoration: controller.selectedChartType.value.toLowerCase() != "monthly"
                  ? BoxDecoration(
                    color: AppTheme.transparent,
                    borderRadius: BorderRadius.circular(30),
                  )
                  : BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.all(2),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(child: Text("Monthly",style: AppFontStyle.text_12_400(controller.selectedChartType.value.toLowerCase() == "monthly" ? AppTheme.white : AppTheme.black, fontFamily: AppFontFamily.generalSansRegular))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
