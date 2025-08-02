

import '../../core/app_exports.dart';

class CustomGradientToggle extends StatelessWidget {
  const CustomGradientToggle({super.key, required this.isSelected, this.onTap});

  final bool isSelected;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: AppTheme.transparent,
      highlightColor: AppTheme.transparent,
      splashColor: AppTheme.transparent,
      hoverColor: AppTheme.transparent,
      onTap: onTap,
      child: Container(
        height: 22.h,
        width: 22.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: AppTheme.primaryGradient,
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Container(
            height: 21.h,
            width: 21.w,
            decoration: BoxDecoration(
              color: AppTheme.white,
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                height: 20.h,
                width: 20.w,
                decoration:
                isSelected
                ? BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppTheme.primaryGradient,
                  )
                : BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.white
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
