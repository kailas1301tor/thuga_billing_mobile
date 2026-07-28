// lib/utils/helpers/platform_local_image.dart
import 'package:flutter/material.dart';

import 'platform_local_image_stub.dart'
    if (dart.library.io) 'platform_local_image_io.dart'
    if (dart.library.html) 'platform_local_image_web.dart';

Widget buildPlatformLocalImage(
  String path, {
  BoxFit fit = BoxFit.cover,
}) =>
    buildPlatformLocalImageImpl(path, fit: fit);
