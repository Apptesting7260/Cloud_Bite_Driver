import 'package:cloud_bites_driver/app/core/app_exports.dart';

class SimpleCustomDropdown extends StatelessWidget {
  const SimpleCustomDropdown({
    super.key,
    this.selectedValue,
    this.hintText,
    required this.items,
    required this.onChanged,
    this.btnWidth,
    this.btnHeight,
    this.borderRadius,
    this.borderColor,
    this.isExpanded,
    this.padding,
    this.textStyle,
    this.hintStyle,
    this.validator,
    this.selectedValues,
    this.contentPadding,
    this.labelText,
    this.onMenuStateChange, this.isValidationError, this.errorTextStyle, this.errorTextClr, this.isCategoryName,
  });

  final String? selectedValue;
  final String? hintText;
  final String? labelText;
  final List<dynamic> items;
  final Function(String?) onChanged;
  final double? btnWidth;
  final double? btnHeight;
  final double? borderRadius;
  final Color? borderColor;
  final bool? isExpanded;
  final bool? isValidationError;
  final bool? isCategoryName;
  final double? padding;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final FormFieldValidator<String>? validator;
  final List<RxString>? selectedValues;
  final EdgeInsets? contentPadding;
  final TextStyle? errorTextStyle;
  final Color? errorTextClr;
  final Function(bool)? onMenuStateChange;


  @override
  Widget build(BuildContext context) {

    return DropdownButtonFormField2<String>(
      isDense: true,
      onMenuStateChange: onMenuStateChange,
      decoration:  InputDecoration(
        errorMaxLines: 8,
        fillColor: AppTheme.boxBgColor,
        filled: true,
        errorStyle: errorTextStyle ?? WidgetDesigns.errorTextStyle(),
        labelText: hintText ?? '',
        labelStyle: AppFontStyle.text_15_500(AppTheme.hintText, fontFamily: AppFontFamily.generalSansRegular,),
        contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        focusedErrorBorder: WidgetDesigns.errorBorder(),
        border: WidgetDesigns.defaultBorder(),
        enabledBorder: WidgetDesigns.defaultBorder(),
        focusedBorder: WidgetDesigns.defaultBorder(),
        errorBorder: WidgetDesigns.errorBorder(),
      ),
      isExpanded: isExpanded ?? true,
      value: selectedValue == '' ? null : selectedValue,
      validator: validator,
      // hint: Text(hintText ?? 'Select an option', style: hintStyle ?? AppFontStyle.text_16_400(AppTheme.black, fontFamily: AppFontFamily.generalSansRegular,),),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      items: items.map((item) => DropdownMenuItem<String>(
        enabled: selectedValues == null ? true : !selectedValues!.contains(item),
        value: item,
        child: Text(item,
          style: textStyle ?? AppFontStyle.text_16_400(AppTheme.darkText, fontFamily: AppFontFamily.generalSansRegular),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
      ).toList(),
      onChanged: onChanged,
      iconStyleData: IconStyleData(icon: Icon(Icons.keyboard_arrow_down, size: 22, color: AppTheme.black,),),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 300,
        offset: const Offset(0, 15),
        scrollPadding: EdgeInsets.zero,
        padding: EdgeInsets.only(left:10, top: 12, bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white, width: 1),
          color: AppTheme.white,
        ),
        scrollbarTheme: ScrollbarThemeData(
          radius: const Radius.circular(40),
          thickness: WidgetStateProperty.all<double>(1),
          thumbVisibility: WidgetStateProperty.all<bool>(true),
        ),
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 35,
        padding: EdgeInsets.symmetric(horizontal: 0),
      ),
    );
  }
}
