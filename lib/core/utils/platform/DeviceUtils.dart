import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

class DeviceUtils {
  bool _isTablet = false;
  bool _isSamsungDevice = false;
  bool _isButtonNavigation = true;

  bool get isSamsungTabletWithButtonNavigation =>
      _isTablet && _isSamsungDevice && _isButtonNavigation;

  Future<void> initializeDevice(BuildContext context) async {
    final deviceInfo = DeviceInfoPlugin();
    final androidInfo = await deviceInfo.androidInfo;
    _isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    _isSamsungDevice = androidInfo.manufacturer.toLowerCase() == "samsung";
    _isButtonNavigation = androidInfo.systemFeatures.contains(
      "android.software.home_screen",
    );
  }
}
