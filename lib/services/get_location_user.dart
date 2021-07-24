import 'dart:async';

import 'package:location/location.dart';

class GetLocationUser {
  Location location = new Location();

  bool? serviceEnabled;
  PermissionStatus? permissionGranted;
  LocationData? _locationData;

  GetLocationUser() {
    setUpService();
    Timer(Duration(milliseconds: 100), () {
      requestPermission();
    });
  }

  void setUpService() async {
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled!) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled!) {
        return;
      }
    }
  }

  void requestPermission() async {
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    location.enableBackgroundMode(enable: true);
  }
}
