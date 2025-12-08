import 'package:cloud_bites_driver/app/constants/image_constants.dart';
import 'package:flutter/material.dart';


class CustomRadio extends StatelessWidget {
  final String value;
  final String? groupValue;
  final ValueChanged onChanged;

  const CustomRadio({
    super.key,
    required this.value,
    this.groupValue,
    required this.onChanged,
  });

  bool get isSelected => value == groupValue;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSelected) {
          onChanged(null); // deselect
        } else {
          onChanged(value); // select
        }
      },
      child: Container(
        width: 23,
        height: 23,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(ImageConstants.circleImage),
            isSelected
                ? Image.asset(ImageConstants.fillCircleImage)
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
