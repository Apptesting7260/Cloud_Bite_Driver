class PrivacyPolicyModel {
  final String? htmlContent;
  final String? url;

  PrivacyPolicyModel({this.htmlContent, this.url});

  factory PrivacyPolicyModel.fromRawHtml(String html) {
    return PrivacyPolicyModel(htmlContent: html);
  }

  factory PrivacyPolicyModel.fromUrl(String url) {
    return PrivacyPolicyModel(url: url);
  }
}