
import 'dart:io';
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class CustomImageView extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final double? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const CustomImageView({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.color,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  }) : super(key: key);

  ImageType _getImageType() {
    if (imageUrl.startsWith('http://') || imageUrl.startsWith('https://')) {
      return ImageType.network;
    } else if (imageUrl.startsWith('assets/')) {
      return ImageType.asset;
    } else {
      return ImageType.file;
    }
  }

  Widget _buildShimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    switch (_getImageType()) {
      case ImageType.network:
        imageWidget = CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit ?? BoxFit.cover,
          width: width,
          height: height,
          color: color,
          placeholder: (context, url) => _buildShimmerPlaceholder(),
          errorWidget: (context, url, error) => errorWidget ?? const Icon(Icons.error),
        );
        break;

      case ImageType.file:
        imageWidget = Image.file(
          File(imageUrl),
          fit: fit ?? BoxFit.cover,
          width: width,
          height: height,
          color: color,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? const Icon(Icons.error);
          },
        );
        break;

      case ImageType.asset:
        imageWidget = Image.asset(
          imageUrl,
          fit: fit ?? BoxFit.cover,
          width: width,
          height: height,
          color: color,
          errorBuilder: (context, error, stackTrace) {
            return errorWidget ?? const Icon(Icons.error);
          },
        );
        break;
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: imageWidget,
      );
    }

    return imageWidget;
  }
}

enum ImageType {
  network,
  file,
  asset,
}