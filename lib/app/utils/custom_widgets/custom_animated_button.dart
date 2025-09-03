
import 'package:cloud_bites_driver/app/core/app_exports.dart';

class CustomAnimatedButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double width;
  final double height;
  final bool isEnabled;
  final Widget ?child;

  const CustomAnimatedButton({
    super.key,
    this.child,
    required this.onTap,
    required this.text,
    this.width = double.infinity,
    this.height = 50,
    this.isEnabled = true,
  });

  @override
  State<CustomAnimatedButton> createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.isEnabled ? _handleTapDown : null,
      onTapUp: widget.isEnabled ? _handleTapUp : null,
      onTapCancel: widget.isEnabled ? _handleTapCancel : null,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            gradient: widget.isEnabled
                ? _isPressed
                ? LinearGradient(
              colors: [
                AppTheme.primaryColor.withOpacity(0.8),
                AppTheme.blueColor.withOpacity(0.8),
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            )
                : AppTheme.primaryGradientHorizontal
                : AppTheme.disabledButton,
            borderRadius: BorderRadius.circular(50),
            boxShadow: _isPressed
                ? []
                : [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child:widget.child?? Text(
              widget.text,
              style: AppFontStyle.text_16_500(AppTheme.white, fontFamily: AppFontFamily.generalSansMedium)
          ),
        ),
      ),
    );
  }
}
