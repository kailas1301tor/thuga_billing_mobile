// lib/utils/helpers/device_info_helper.dart
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfoSnapshot {
  const DeviceInfoSnapshot({
    required this.platform,
    required this.osVersion,
    required this.deviceModel,
    required this.appVersion,
  });

  final String platform;
  final String osVersion;
  final String deviceModel;
  final String appVersion;

  Map<String, String> toCrashlyticsKeys() => {
    'platform': platform,
    'os_version': osVersion,
    'device_model': deviceModel,
    'app_version': appVersion,
  };
}

class DeviceInfoHelper {
  DeviceInfoHelper._();

  static DeviceInfoSnapshot? _cached;

  static Future<DeviceInfoSnapshot> getSnapshot() async {
    if (_cached != null) {
      return _cached!;
    }

    final packageInfo = await PackageInfo.fromPlatform();
    final deviceInfo = DeviceInfoPlugin();

    var platform = 'unknown';
    var osVersion = 'unknown';
    var deviceModel = 'unknown';

    if (Platform.isAndroid) {
      final android = await deviceInfo.androidInfo;
      platform = 'android';
      osVersion = android.version.release;
      deviceModel = '${android.manufacturer} ${android.model}'.trim();
    } else if (Platform.isIOS) {
      final ios = await deviceInfo.iosInfo;
      platform = 'ios';
      osVersion = ios.systemVersion;
      deviceModel = ios.utsname.machine;
    }

    _cached = DeviceInfoSnapshot(
      platform: platform,
      osVersion: osVersion,
      deviceModel: deviceModel,
      appVersion: packageInfo.version,
    );
    return _cached!;
  }
}
