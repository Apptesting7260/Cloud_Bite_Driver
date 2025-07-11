import 'package:cloud_bites_driver/app/core/app_exports.dart';

class TermsConditionWebView extends StatefulWidget {
  final String url;

  const TermsConditionWebView({Key? key, required this.url}) : super(key: key);

  @override
  State<TermsConditionWebView> createState() => _TermsConditionWebView();
}

class _TermsConditionWebView extends State<TermsConditionWebView> {
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
            Text('No Terms & Conditions Availble');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms & Conditions'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
