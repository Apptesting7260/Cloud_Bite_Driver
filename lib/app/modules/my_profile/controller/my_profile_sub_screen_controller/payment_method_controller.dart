import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PaymentMethodController extends GetxController {
  var fetchPaymentMethodData = FetchPaymentMethodModel().obs;
  var repo = Repository();
  var isFetchPayments = false.obs;
  var selectedMethodType = "".obs;
  @override
  void onInit() {
    fetchAllPaymentMethodApi();
    // TODO: implement onInit
    super.onInit();
  }

  void fetchAllPaymentMethodApi() async {
    isFetchPayments.value = true;
    try {
      var response = await repo.getPaymentDetailAPI({}).then((value) {
        if (value.status == true) {
          fetchPaymentMethodData.value = value;
        } else {
          fetchPaymentMethodData.value = FetchPaymentMethodModel();
        }
      });
    } finally {
      isFetchPayments.value = false;
    }
  }
}
