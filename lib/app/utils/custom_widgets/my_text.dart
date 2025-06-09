import 'package:cloud_bites_driver/app/core/app_exports.dart';

class MyText extends StatelessWidget {
  final String title;
  FontWeight ? fWeight ;
  double ? fSize ;
  Color ? tColor;
  bool ? isOverFlow;
  bool ? isUnderline;
  MyText({required this.title,this.isUnderline,this.isOverFlow,this.tColor=AppTheme.paragraphTextColor,this.fWeight=FontWeight.w500,this.fSize=15});
  @override
  Widget build(BuildContext context) {
    return Text(title,style: Theme.of(context).textTheme.bodyMedium!.copyWith(
        fontWeight:  fWeight ,
        fontSize:  fSize ,
        decoration: isUnderline ==true?TextDecoration.underline :null,
        decorationColor:tColor ,
        color: tColor
    ),overflow: isOverFlow==true?TextOverflow.ellipsis:null,);
  }
}