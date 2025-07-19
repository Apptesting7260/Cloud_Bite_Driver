import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:cloud_bites_driver/app/modules/my_profile/model/rating_model.dart';

class RatingController extends GetxController{

  var isLoading = true.obs;
  var isLoadingMore = false.obs;
  var currentPage = 1;
  var totalPages = 1;
  var hasMore = true.obs;

  final Repository _repository = Repository();
  final StorageServices _storageService = Get.find<StorageServices>();
  StorageServices get storageServices => _storageService;

  @override
  void onInit() {
    super.onInit();
    getRatingsAndReviewsData();
  }

  /*var items = List.generate(2,
        (index) {
      final profileImage = [
        ImageConstants.profile,
        ImageConstants.profile
      ];
      final profileName = [
        'Dora Perry',
        'Dora Perry'
      ];
      final time = [
        'Today, 09:12',
        'Today, 09:12'
      ];
      final images = [
        ImageConstants.profile,
        ImageConstants.profile,
      ];
      final dishName = [
        'Dumplings',
        'Dumplings',
      ];
      final description = [
        'Pork Dumplings',
        'Pork Dumplings',
      ];

      return {
        "profileImage": profileImage[index],
        "profileName": profileName[index],
        "time": time[index],
        "images": images[index],
        "dishName": dishName[index],
        "description": description[index]
      };
    },
  ).obs;*/


  /*Rx<ApiResponse<RatingModel>> ratingData = Rx<ApiResponse<RatingModel>>(ApiResponse.loading());
  setRatingsAndReviews(ApiResponse<RatingModel> value){
    ratingData.value = value;
  }

  getRatingsAndReviewsData() async{
    setRatingsAndReviews(ApiResponse.loading());
    isLoading.value = true;
    try{
      final apiData = await _repository.ratingAPI();
      if(apiData.status == true){
        isLoading.value = false;
        WidgetDesigns.consoleLog("Rating and reviews Data get", "get reviews and ratings data");
        setRatingsAndReviews(ApiResponse.completed(apiData));
      } else{
        isLoading.value = false;
        WidgetDesigns.consoleLog(apiData.message?.toString() ?? "Error while get ratings and reviews data", "error while get reviews and rating data");
        CustomSnackBar.show(message:apiData.message?.toString() ?? "Error while get delivery and rating data", color: AppTheme.redText, tColor: AppTheme.white);
        setRatingsAndReviews(ApiResponse.error(apiData.message?.toString() ?? "Error while get delivery and rating data"));
      }

    } catch(e){
      isLoading.value = false;
      setRatingsAndReviews(ApiResponse.error(e.toString()));
      WidgetDesigns.consoleLog(e.toString(), "error while get review and ratings data");
      CustomSnackBar.show(message: e.toString(), color: AppTheme.redText, tColor: AppTheme.white);
    }
    finally{
      isLoading.value = false;
    }
  }*/
  Rx<ApiResponse<RatingModel>> ratingData = Rx<ApiResponse<RatingModel>>(ApiResponse.loading());

  setRatingsAndReviews(ApiResponse<RatingModel> value) {
    ratingData.value = value;
  }

  Future<void> getRatingsAndReviewsData() async {
    setRatingsAndReviews(ApiResponse.loading());
    isLoading.value = true;
    currentPage = 1;
    hasMore.value = true;

    try {
      final apiData = await _repository.ratingAPI(page: currentPage);
      if (apiData.status == true) {
        isLoading.value = false;
        totalPages = int.tryParse(apiData.totalPages ?? '1') ?? 1;
        setRatingsAndReviews(ApiResponse.completed(apiData));
      } else {
        isLoading.value = false;
        CustomSnackBar.show(
            message: apiData.message?.toString() ?? "Error while getting ratings data",
            color: AppTheme.redText,
            tColor: AppTheme.white
        );
        setRatingsAndReviews(ApiResponse.error(apiData.message?.toString() ?? "Error while getting ratings data"));
      }
    } catch (e) {
      isLoading.value = false;
      setRatingsAndReviews(ApiResponse.error(e.toString()));
      CustomSnackBar.show(
          message: e.toString(),
          color: AppTheme.redText,
          tColor: AppTheme.white
      );
    }
  }

  Future<void> loadMoreRatings() async {
    if (isLoadingMore.value || !hasMore.value) return;

    isLoadingMore.value = true;
    currentPage++;

    try {
      final apiData = await _repository.ratingAPI(page: currentPage);
      if (apiData.status == true && apiData.data != null) {
        final currentData = ratingData.value.data;
        if (currentData != null && apiData.data != null) {
          currentData.data!.addAll(apiData.data!);
          setRatingsAndReviews(ApiResponse.completed(currentData));
        }

        // Check if we've reached the last page
        if (currentPage >= totalPages) {
          hasMore.value = false;
        }
      }
    } catch (e) {
      currentPage--; // Revert page increment on error
      CustomSnackBar.show(
          message: "Failed to load more ratings",
          color: AppTheme.redText,
          tColor: AppTheme.white
      );
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshRatings() async {
    currentPage = 1;
    hasMore.value = true;
    await getRatingsAndReviewsData();
  }
}