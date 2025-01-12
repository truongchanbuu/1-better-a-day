import 'dart:async';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/helpers/permission_helper.dart';

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  Position? lastPosition;
  double totalDistance = 0;

  // Load saved distance if exists
  SharedPreferences prefs = await SharedPreferences.getInstance();
  totalDistance = prefs.getDouble('total_distance') ?? 0;

  // Request location permission
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return;
  }

  final isAllowed = await PermissionHelper.checkAndRequestGeoLocation();

  if (!isAllowed) {
    return;
  }

  // Start location tracking
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 5), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        Position currentPosition = await Geolocator.getCurrentPosition(
          locationSettings: AndroidSettings(accuracy: LocationAccuracy.high),
        );

        if (lastPosition != null) {
          double distance = Geolocator.distanceBetween(
            lastPosition!.latitude,
            lastPosition!.longitude,
            currentPosition.latitude,
            currentPosition.longitude,
          );

          // Only add distance if movement is detected (more than 2 meters)
          if (distance > 2) {
            totalDistance += distance;
            await prefs.setDouble('total_distance', totalDistance);
          }
        }

        lastPosition = currentPosition;

        // Update notification
        service.setForegroundNotificationInfo(
          title: "Distance Tracking Active",
          content: "Distance: ${(totalDistance / 1000).toStringAsFixed(2)} km",
        );
      }
    }

    // Send data to UI
    service.invoke(
      'update',
      {
        'distance': totalDistance,
        'isRunning': true,
      },
    );
  });
}
