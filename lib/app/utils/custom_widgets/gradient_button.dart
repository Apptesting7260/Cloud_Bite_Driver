import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:flutter/cupertino.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, this.buttonText, this.onTap, this.isWhiteBackGround, this.icon, this.isIcon = true, this.horizontalPadding, this.mainAxisAlignment = MainAxisAlignment.start});

  final String? buttonText;
  final Function()? onTap;
  final bool? isWhiteBackGround;
  final bool isIcon;
  final IconData? icon;
  final double? horizontalPadding;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40,
        decoration: isWhiteBackGround == true
            ? BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: AppTheme.primaryGradient

        )
            : BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.white,
        ),
        child: Padding(
          padding: isWhiteBackGround == true ? const EdgeInsets.all(1.0) : EdgeInsets.zero,
          child: Container(
            decoration: isWhiteBackGround == true
                ? BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
            )
                : BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: AppTheme.primaryGradient
            ),
            child:  Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 16.0),
                child: Row(
                  mainAxisAlignment: mainAxisAlignment,
                  children: [
                    if(isIcon) ...[
                      Icon(icon ?? CupertinoIcons.minus,color: isWhiteBackGround == true ? AppTheme.primaryColor : AppTheme.white,),
                      WidgetDesigns.wBox(2),
                    ],
                    Text(
                      buttonText ?? 'Save',
                      style: AppFontStyle.text_14_500(isWhiteBackGround == true ? AppTheme.primaryColor : AppTheme.white, fontFamily: AppFontFamily.generalSansMedium),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
