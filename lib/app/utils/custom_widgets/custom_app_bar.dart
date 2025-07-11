
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class CustomBackButtonAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final double? elevation;
  final String? title;

  const CustomBackButtonAppBar({
    Key? key,
    this.onBackPressed,
    this.backgroundColor,
    this.elevation,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0.0,
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation ?? 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(239,239,239,1)
            ),
            child: Center(
              child: Icon(
                size: 20,
                Icons.arrow_back_ios_new,
              ),
            ),
          ),
        ),
      ),
      title: title != null
          ? Text(
          title!,
          style: AppFontStyle.text_22_500(AppTheme.black, fontFamily: AppFontFamily.generalSansMedium)
      )
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomTitleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final TextStyle? titleStyle;
  final Color? backgroundColor;
  final double? elevation;

  const CustomTitleAppBar({
    Key? key,
    required this.title,
    this.onBackPressed,
    this.titleStyle,
    this.backgroundColor,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.transparent,
      elevation: elevation ?? 0,
      leading: GestureDetector(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: CustomImageView(
            imageUrl: 'assets/images/Back.png',
          ),
        ),
      ),
      title: Text(
        title,
        style: titleStyle ?? Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomLogoutAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  // final String title;
  // final VoidCallback? onBackPressed;
  final VoidCallback onLogoutPressed;
  // final TextStyle? titleStyle;
  // final Color? backgroundColor;
  // final double? elevation;

  const CustomLogoutAppBar({
    Key? key,
    required this.onLogoutPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      actions: [
        IconButton(
          onPressed: onLogoutPressed,
          icon: const Icon(
            Icons.logout,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
