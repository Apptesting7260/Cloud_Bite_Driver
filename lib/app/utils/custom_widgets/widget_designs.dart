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

  static String getCurrentDate() {
    final now = DateTime.now();
    return '${now.year.toString().padLeft(4, '0')}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }


  static String convertDateFormat(String input) {
    final outputFormat = DateFormat('yyyy-MM-dd');
    final normalizedInput = input.trim().toLowerCase();

    if (normalizedInput == "yesterday") {
      final yesterday = DateTime.now().subtract(const Duration(days: 1));
      return outputFormat.format(yesterday);
    }

    if (normalizedInput == "today") {
      final today = DateTime.now();
      return outputFormat.format(today);
    }

    final inputFormat = DateFormat('dd MMM, yyyy');
    final date = inputFormat.parse(input);
    return outputFormat.format(date);
  }


  static String getDayOnly(String isoString) {
    DateTime dateTime = DateTime.parse(isoString).toLocal();
    return dateTime.day.toString();
  }


  static String formatDateString(String inputDate) {
    DateTime parsedDate = DateTime.parse(inputDate).toLocal();
    String formattedDate = DateFormat('EEE, dd MMM - hh:mm a').format(parsedDate);
    return formattedDate;
  }

  static String dayMonth(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateFormat formatter = DateFormat('d MMM');
    return formatter.format(date);
  }

  static Map<String, String> getWeekRange(int weekOffset) {
    final now = DateTime.now();

    // Calculate the Monday of the current week
    final int currentWeekday = now.weekday; // Monday = 1
    final DateTime startOfWeek = now.subtract(Duration(days: currentWeekday - 1));

    // Apply the week offset
    final DateTime start = startOfWeek.add(Duration(days: weekOffset * 7));
    final DateTime end = start.add(const Duration(days: 6));

    final formatter = DateFormat('yyyy-MM-dd');

    consoleLog(formatter.format(start), "Start Date");
    consoleLog(formatter.format(end), "End Date");

    return {
      'start': formatter.format(start),
      'end': formatter.format(end),
    };
  }



  static String getMonthNumber(DateTime date) => date.month.toString();

  static Map<String, String> getMonthInfo(int monthOffset) {
    final now = DateTime.now();

    // Calculate the new date by shifting months
    final shiftedDate = DateTime(now.year, now.month + monthOffset);

    return {
      'month': getMonthNumber(shiftedDate),
      'year': shiftedDate.year.toString(),
    };
  }


  static String getMonthName(String monthNumber) {
    final int month = int.parse(monthNumber);
    final DateTime date = DateTime(0, month);
    return DateFormat.MMMM().format(date);
  }

}