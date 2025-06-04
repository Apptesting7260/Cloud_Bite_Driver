import 'package:cloud_bites_driver/app/core/app_exports.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.alignment,
    this.height,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.maxLength,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.enabled,
    this.onChanged,
    this.onTapOutside,
    this.borderRadius,
    this.inputFormatters,
    this.minLines,
    this.onTap,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.labelText,
    this.autoValidateMode, this.buildCounter, this.errorBorder, this.isLabel, this.alignLabelWithHint,
    // this.errorTextStyle,
    // this.errorTextClr,
  });

  final Alignment? alignment;

  final double? width;
  final double? height;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final int? minLines;

  final int? maxLength;

  final String? hintText;

  final TextStyle? hintStyle;

  // final TextStyle? errorTextStyle;

  // final Color? errorTextClr;

  final Widget? prefix;
  final InputCounterWidgetBuilder? buildCounter;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final InputBorder? errorBorder;

  final Color? fillColor;

  final bool? filled;

  final BorderRadius? borderRadius;

  final VoidCallback? onTap;

  final FormFieldValidator<String>? validator;

  final bool? enabled;

  final bool? isLabel;

  final bool? alignLabelWithHint;

  final Function(String value)? onChanged;

  final TapRegionCallback? onTapOutside;

  final List<TextInputFormatter>? inputFormatters;

  final Function()? onEditingComplete;

  final Function(String)? onFieldSubmitted;

  final String? labelText;
  final AutovalidateMode? autoValidateMode;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
      alignment: alignment ?? Alignment.center,
      child: textFormFieldWidget,
    )
        : textFormFieldWidget;
  }

  Widget get textFormFieldWidget => SizedBox(
    width: width ?? double.maxFinite,
    height: height,
    child: TextFormField(

      buildCounter: buildCounter,
      // expands: true,
      onTap: onTap,
      maxLength: maxLength,
      onTapOutside:onTapOutside ?? (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: onChanged,
      autovalidateMode: autoValidateMode ?? AutovalidateMode.onUserInteraction,
      enabled: enabled ?? true,
      controller: controller,
      autofocus: autofocus ?? false,
      style: textStyle ?? AppFontStyle.text_16_400(AppTheme.darkText, fontFamily: AppFontFamily.generalSansRegular),
      obscureText: obscureText!,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLines ?? 1,
      minLines: minLines ?? 1,
      decoration: decoration,
      validator: validator,
      inputFormatters: inputFormatters,
      onEditingComplete: onEditingComplete,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: AppTheme.primaryColor,

    ),
  );

  InputDecoration get decoration => InputDecoration(
    errorStyle:  WidgetDesigns.errorTextStyle(),
    alignLabelWithHint: alignLabelWithHint,
    labelText: isLabel == true ? null : hintText ?? '',
    floatingLabelAlignment: FloatingLabelAlignment.start,
    errorMaxLines: 10,
    hintText: hintText ?? "",
    hintStyle: hintStyle ?? AppFontStyle.text_14_400(AppTheme.hintText, fontFamily: AppFontFamily.generalSansRegular),
    labelStyle: hintStyle ??
        AppFontStyle.text_15_500(
          AppTheme.hintText,
          fontFamily: AppFontFamily.generalSansRegular,
        ),
    prefixIcon: prefix,
    prefixIconConstraints: prefixConstraints ?? const BoxConstraints(minWidth: 30),
    suffixIcon: suffix,
    suffixIconConstraints: suffixConstraints,
    isDense: true,
    contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    fillColor: fillColor ?? AppTheme.boxBgColor,
    filled: filled,
    border: borderDecoration ?? WidgetDesigns.defaultBorder(),
    enabledBorder: borderDecoration ?? WidgetDesigns.defaultBorder(),
    focusedBorder: borderDecoration ?? WidgetDesigns.defaultBorder(),
    disabledBorder: borderDecoration ?? WidgetDesigns.defaultBorder(),
    errorBorder: errorBorder ?? WidgetDesigns.errorBorder(),
    focusedErrorBorder: errorBorder ?? WidgetDesigns.errorBorder(),
  );
}
