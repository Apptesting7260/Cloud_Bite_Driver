import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppFontStyle {
  static TextStyle _textStyle(Color color, double size, FontWeight fontWeight,
      {fontFamily, height, overflow, textDecoration, decorationColor}) {
    return TextStyle(
      decoration: textDecoration,
      decorationColor: decorationColor,
      color: color,
      fontSize: size.sp,
      fontWeight: fontWeight,
      height: height ?? 1.4,
      overflow: overflow ?? TextOverflow.ellipsis,
      fontFamily: fontFamily ?? 'General Sans',
    );
  }

  ///`font-weight:300 ===========>`
  static text_16_300(Color color, {fontFamily, height}) {
    return _textStyle(color, 16, FontWeight.w300,
        height: height, fontFamily: fontFamily);
  }

  static text_14_300(Color color, {fontFamily, height, overFlow}) {
    return _textStyle(color, 14, FontWeight.w300,
        overflow: overFlow,
        height: height, fontFamily: fontFamily);
  }
  static text_12_300(Color color, {fontFamily, height, overFlow}) {
    return _textStyle(color, 14, FontWeight.w300,
        overflow: overFlow,
        height: height, fontFamily: fontFamily);
  }

  static text_18_300(Color color, {fontFamily, height}) {
    return _textStyle(color, 18, FontWeight.w300,
        height: height, fontFamily: fontFamily);
  }

  ///`font-weight:400 ===========>`

  static text_10_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 10, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  static text_12_400(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 12, FontWeight.w400, overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  static text_12_500(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 12, FontWeight.w500, overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  static text_12_200(Color color, {fontFamily, height}) {
    return _textStyle(color, 12, FontWeight.w200,
        height: height, fontFamily: fontFamily);
  }

  static text_13_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 13, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  static text_14_400(Color color, {fontFamily, height, overflow, decoration}) {
    return _textStyle(color, 14, FontWeight.w400,
        height: height, fontFamily: fontFamily, overflow: overflow, textDecoration: decoration);
  }

  static text_15_400(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 15, FontWeight.w400,
        height: height, fontFamily: fontFamily, overflow: overflow);
  }

  static text_16_400(Color color,
      {fontFamily, double? height, FontWeight? fontWeight, overflow}) {
    return _textStyle(color, 16, fontWeight ?? FontWeight.w400,
        height: height, fontFamily: fontFamily, overflow: overflow);
  }

  static text_16_4002(Color color,
      {fontFamily, double? height, FontWeight? fontWeight}) {
    return _textStyle(color, 16, fontWeight ?? FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  static text_6_400(Color color,
      {fontFamily, double? height, FontWeight? fontWeight, overflow}) {
    return _textStyle(color, 6, fontWeight ?? FontWeight.w400,
        height: height, fontFamily: fontFamily, overflow: overflow);
  }

  static text_18_400(Color color, {fontFamily, height, overFlow}) {
    return _textStyle(color, 18, FontWeight.w400,
        height: height, fontFamily: fontFamily, overflow: overFlow);
  }

  static text_20_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 20, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  static text_22_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 22, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  static text_24_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 24, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  static text_26_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 26, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }
  static text_26_500(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 26, FontWeight.w500,overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  static text_30_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 30, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }


  static text_34_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 34, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  ///`font-weight:500 ===========>`

  static text_14_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 14, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_16_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 16, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_10_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 10, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_30_500(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 30, FontWeight.w500,overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  static text_18_500(Color color, {fontFamily, height, textDecoration, decorationColor}) {
    return _textStyle(color, 18, FontWeight.w500, textDecoration: textDecoration, decorationColor: decorationColor,
        height: height, fontFamily: fontFamily);
  }
  static text_18_700(Color color, {fontFamily, height}) {
    return _textStyle(color, 18, FontWeight.w700,
        height: height, fontFamily: fontFamily);
  }

  static text_15_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 14, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_20_500(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 20, FontWeight.w500,overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  static text_21_500(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 21, FontWeight.w500,overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  ///`font-weight:600 ===========>`

  static text_12_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 12, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_14_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 14, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_15_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 15, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }
  static text_15_700(Color color, {fontFamily, height}) {
    return _textStyle(color, 15, FontWeight.w700,
        height: height, fontFamily: fontFamily);
  }

  static text_16_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 16, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_18_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 18, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_20_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 20, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_22_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 22, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }
  static text_22_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 22, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_24_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 24, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }
  static text_24_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 24, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_26_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 26, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_28_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 28, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }
  static text_28_500(Color color, {fontFamily, height,overflow}) {
    return _textStyle(color, 28, FontWeight.w500, overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  static text_30_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 30, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }
  static text_30_700(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 30, FontWeight.w600,
        height: height, fontFamily: fontFamily, overflow: overflow);
  }

  static text_32_700(Color color, {fontFamily, height, overFlow}) {
    return _textStyle(color, 30, FontWeight.w600, overflow: overFlow,
        height: height, fontFamily: fontFamily);
  }

  static text_32_500(Color color, {fontFamily, height, overFlow}) {
    return _textStyle(color, 30, FontWeight.w500, overflow: overFlow,
        height: height, fontFamily: fontFamily);
  }

  static text_34_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 34, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }
  static text_34_700(Color color, {fontFamily, height}) {
    return _textStyle(color, 34, FontWeight.w700,
        height: height, fontFamily: fontFamily);
  }

  static text_36_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 36, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_40_600(Color color, {fontFamily, height}) {
    return _textStyle(color, 40, FontWeight.w600,
        height: height, fontFamily: fontFamily);
  }

  static text_40_400(Color color, {fontFamily, height}) {
    return _textStyle(color, 40, FontWeight.w400,
        height: height, fontFamily: fontFamily);
  }

  static text_40_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 40, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_14_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 14, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_15_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 15, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_16_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 16, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_18_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 18, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_20_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 20, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_22_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 22, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_22_700(Color color, {fontFamily, height}) {
    return _textStyle(color, 22, FontWeight.w700,
        height: height, fontFamily: fontFamily);
  }

  static text_24_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 24, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_24_700(Color color, {fontFamily, height, overflow}) {
    return _textStyle(color, 24, FontWeight.w700, overflow: overflow,
        height: height, fontFamily: fontFamily);
  }

  static text_26_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 26, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_28_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 28, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  static text_30_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 30, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }
  static text_35_500(Color color, {fontFamily, height}) {
    return _textStyle(color, 35, FontWeight.w500,
        height: height, fontFamily: fontFamily);
  }

  static text_56_800(Color color, {fontFamily, height}) {
    return _textStyle(color, 56, FontWeight.w800,
        height: height, fontFamily: fontFamily);
  }

  ///`custom text ===========>`

  static customText(Color color, double size, FontWeight fontWeight,
      {fontFamily, height}) {
    return _textStyle(color, size, fontWeight,
        height: height, fontFamily: fontFamily);
  }
}
