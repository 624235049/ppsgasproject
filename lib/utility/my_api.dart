import 'dart:math';

import 'package:geolocator/geolocator.dart';

class MyAPI {
  Position userlocation;

  double calculateDistance(double lat1, double lng1, double lat2, double lng2) {
    double distance = 0;
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
    distance = 12742 * asin(sqrt(a));

    return distance;
  }

  double calculate2Distance(
      double lat1, double lng1, double lat2, double lng2) {
    try {
      double distance = 0;
      var p = 0.017453292519943295; // Math.PI / 180
      var c = cos;
      var a = 0.5 -
          c((lat2 - lat1) * p) / 2 +
          c(lat1 * p) * c(lat2 * p) * (1 - c((lng2 - lng1) * p)) / 2;
      distance = 12742 * asin(sqrt(a));

      return distance;
    } catch (e) {}
  }

  int calculateTransport(double distance) {
    int transport;
    if (distance < 1.0) {
      transport = 35;
      return transport;
    } else {
      transport = 35 + (distance - 1).round() * 10;
      return transport;
    }
  }

  Future<Position> getLocation() async {
    try {
      userlocation = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: true);
      return userlocation;
    } catch (e) {}
  }

  MyAPI();
}
