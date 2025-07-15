import 'dart:developer';
import 'package:cloud_bites_driver/app/core/app_exports.dart';
import 'package:intl/intl.dart';

class WidgetDesigns{

  static OutlineInputBorder defaultBorder(){
    return OutlineInputBorder(
      borderSide:  BorderSide(width: 0, color: AppTheme.boxBgColor),
      borderRadius: BorderRadius.circular(100),
    );
  }

  static OutlineInputBorder errorBorder(){
    return OutlineInputBorder(
      borderSide:  const BorderSide(width: 0.7, color: AppTheme.red),
      borderRadius: BorderRadius.circular(100.r),
    );
  }

  static OutlineInputBorder focusedBorder(){
    return OutlineInputBorder(
      borderSide:  const BorderSide(width: 0.7, color: AppTheme.primaryColor),
      borderRadius: BorderRadius.circular(100.r),
    );
  }

  static TextStyle errorTextStyle(){
    return AppFontStyle.text_12_400(
      AppTheme.red,
      overflow: TextOverflow.clip,
      fontFamily: AppFontFamily.generalSansMedium,
    );
  }

  static String formatDate(String dateString) {
    try {
      // Parse the ISO date (assuming format like "2025-07-14")
      final date = DateTime.parse(dateString);
      // Format as "14 July 2025" (or your preferred format)
      return DateFormat('d MMMM y').format(date);
    } catch (e) {
      return dateString;
    }
  }

  static String formatTimeFromIso(String isoString) {
    try {
      final date = DateTime.parse(isoString);
      return DateFormat('h:mm a').format(date);
    } catch (e) {
      return isoString;
    }
  }

  static hBox(double height){
    return SizedBox(
      height: height.h,
    );
  }

  static wBox(double width){
    return SizedBox(
      width: width.w,
    );
  }

  static consoleLog(String message, String name){
    log(message, name: name,);
  }

}