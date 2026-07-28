// lib/utils/helpers/platform_local_image_stub.dart
import 'package:flutter/material.dart';

Widget buildPlatformLocalImageImpl(
  String path, {
  BoxFit fit = BoxFit.cover,
}) {
  return const SizedBox.shrink();
}
