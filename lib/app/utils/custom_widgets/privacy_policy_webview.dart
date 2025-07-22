import 'package:cloud_bites_driver/app/core/app_exports.dart';

class PrivacyPolicyWebView extends StatefulWidget {
  final String url;

  const PrivacyPolicyWebView({super.key, required this.url});

  @override
  State<PrivacyPolicyWebView> createState() => _PrivacyPolicyWebViewState();
}

class _PrivacyPolicyWebViewState extends State<PrivacyPolicyWebView> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            LoadingOverlay().showLoading();
          },
          onPageFinished: (url) {
            LoadingOverlay().hideLoading();
          },
          onWebResourceError: (error) {
            // Handle error if needed
            Text('No Privacy Policy Availble');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
