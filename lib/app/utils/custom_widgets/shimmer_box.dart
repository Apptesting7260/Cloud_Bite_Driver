
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({super.key, required this.width, required this.height, this.radius, this.isCircle});

  final double width;
  final double height;
  final double? radius;
  final bool? isCircle;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: isCircle == true ? const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        )
            : BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius ?? 15),
        ),
      ),
    );
  }
}
