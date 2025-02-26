import 'package:url_launcher/url_launcher.dart';

class Constanst {
  static String baseurl = "https://newsapi.org/v2/";
  static String everything = "everything";
  static String headLine = "top-headlines";
  static String headLineCategory = "top-headlines/sources";

  static String apiKey = "ccf41b9f88534729937a8186b0d7ce1e";
}

Future<void> launchWebsiteUrl(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $url');
  }
}
