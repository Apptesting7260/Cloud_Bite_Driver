import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/earning_chart_model.dart';

class EarningsController extends GetxController{

  RxString selectedChartType = "weekly".obs;

  RxInt weekOffSet = 0.obs;
  RxInt monthOffSet = 0.obs;

  RxString weekStartDate = RxString(WidgetDesigns.getWeekRange(0)['start']!);
  RxString weekEndDate = RxString(WidgetDesigns.getWeekRange(0)['end']!);

  RxString monthNo = RxString(WidgetDesigns.getMonthInfo(0)['month']!);
  RxString year = RxString(WidgetDesigns.getMonthInfo(0)['year']!);


  @override
  void onInit() {
    getEarningApi();
    super.onInit();
  }

  final Repository _repository = Repository();

  Rx<ApiResponse<EarningChartModel>> earningAPIData = Rx<ApiResponse<EarningChartModel>>(ApiResponse.loading());
  updateEarningData(ApiResponse<EarningChartModel> data){
    earningAPIData.value = data;
  }
  
  getEarningApi() async {
    
    try {

      earningAPIData.value.data?.data?.earning = [];
      final apiData = await _repository.earningAPI(
          selectedChartType.value.toLowerCase() == "weekly"
          ?
        {
          "type": "weekly",

          "start_date": weekStartDate.value,

          "end_date": weekEndDate.value,
        }
        : {
            "type": "monthly",

            "month": monthNo.value,

            "year": year.value,
          }
      );
      if(apiData.status == true){
        updateEarningData(ApiResponse.completed(apiData));
      }else{
        WidgetDesigns.consoleLog(apiData.message.toString(), "else error while get earning");
        updateEarningData(ApiResponse.error(apiData.message.toString()));
      }
    } catch(e){
      updateEarningData(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "catch error while get earning");
    }
    
  }

}
