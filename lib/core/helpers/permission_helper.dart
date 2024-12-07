import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHelper {
  static Future<bool> isPermissionGranted(Permission permission) async => await permission.isGranted;

  static Future<bool> requestPermission(Permission permission) async => (await permission.request()).isGranted;

  static Future<bool> checkAndRequestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    }
    
    final status = await permission.request();
    return status.isGranted;
  }

  static Future<bool> checkAndRequestGeoLocation() async {
     LocationPermission locationPermission =
        await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      return locationPermission != LocationPermission.denied;
    }

    return true;
  }
}