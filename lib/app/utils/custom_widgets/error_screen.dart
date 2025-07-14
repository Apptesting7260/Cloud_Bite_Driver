import 'package:cloud_bites_driver/app/core/app_exports.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const ErrorScreen({
    super.key,
    required this.message,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error_outline, size: 64, color: AppTheme.redText,),
              const SizedBox(height: 16),
              const Text(
                'Oops!',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                message,
                textAlign: TextAlign.center,
                maxLines: 6,
                style: AppFontStyle.text_14_400(AppTheme.grey),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onPressed,
                child: Text("Retry", style: AppFontStyle.text_14_500(AppTheme.redText),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}