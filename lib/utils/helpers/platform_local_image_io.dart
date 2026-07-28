// lib/utils/helpers/platform_local_image_io.dart
import 'dart:io';

import 'package:flutter/material.dart';

Widget buildPlatformLocalImageImpl(
  String path, {
  BoxFit fit = BoxFit.cover,
}) {
  return Image.file(File(path), fit: fit);
}
