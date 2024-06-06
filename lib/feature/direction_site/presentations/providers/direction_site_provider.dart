import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectionSiteProvider extends ChangeNotifier {
  Future<void> openOnGoogleMapApp(double latitude, double longitude) async {
    final Uri googleUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
    await launchUrl(googleUrl);
    notifyListeners();
  }
}
