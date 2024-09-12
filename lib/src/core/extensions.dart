import 'package:url_launcher/url_launcher.dart';

extension FontSize on double {
  double lh(double fontSize) {
    return this / fontSize;
  }
}

Future<void> openUrl(
  String url, {
  LaunchMode mode = LaunchMode.platformDefault,
}) async {
  final Uri? uri = Uri.tryParse(url);
  if (uri == null) {
    throw Exception("Could not parse the given url $url");
  } else {
    if (!await launchUrl(uri, mode: mode)) {
      throw Exception('Could not launch $uri');
    }
  }
}
