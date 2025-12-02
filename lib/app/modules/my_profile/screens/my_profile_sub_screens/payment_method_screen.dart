import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PaymentMethodScreen extends GetView<PaymentMethodScreen>{
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButtonAppBar(
        backgroundColor: Colors.white,
        title: 'Payment Methods',
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}