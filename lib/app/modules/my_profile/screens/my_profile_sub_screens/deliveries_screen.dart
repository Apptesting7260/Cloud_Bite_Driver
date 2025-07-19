import 'package:cloud_bites_driver/app/core/app_exports.dart';

class DeliveriesScreen extends StatelessWidget{

  final DeliveriesController controller = Get.put(DeliveriesController());

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: CustomBackButtonAppBar(backgroundColor: Colors.white, title: 'Deliveries'),
   );
  }
}