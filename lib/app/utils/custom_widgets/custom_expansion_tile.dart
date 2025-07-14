import 'package:cloud_bites_driver/app/core/app_exports.dart';

class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({
    super.key,
    required this.question,
    required this.answer,
  });

  final String question;
  final String answer;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(

      expandedCrossAxisAlignment: CrossAxisAlignment.start,
      backgroundColor: AppTheme.white,
      collapsedBackgroundColor: AppTheme.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(
          color: AppTheme.boxBgColor,
          width: 1,
        ),
      ),
      collapsedShape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.r),
        borderSide: const BorderSide(
          color: AppTheme.boxBgColor,
          width: 1,
        ),
      ),
      tilePadding: REdgeInsets.only(left: 16, right: 12),
      collapsedIconColor: AppTheme.darkText,
      iconColor: AppTheme.darkText,
      childrenPadding: REdgeInsets.only(
        left: 18,
        right: 10,
        bottom: 18,
      ),
      title: Text(question, style: AppFontStyle.customText(AppTheme.darkText, 16, FontWeight.w400,fontFamily: AppFontFamily.generalSansMedium), maxLines: 10, textAlign: TextAlign.start,),
      children: [
        const Divider(
          color: AppTheme.boxBgColor,
        ),
        WidgetDesigns.hBox(8),
        Text(answer, style: AppFontStyle.text_15_400(AppTheme.lightText, fontFamily: AppFontFamily.generalSansRegular, overflow: TextOverflow.clip), maxLines: 150, textAlign: TextAlign.start,),
      ],
    );
  }
}
