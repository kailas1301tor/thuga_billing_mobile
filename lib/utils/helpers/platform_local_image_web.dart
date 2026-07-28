// lib/utils/helpers/platform_local_image_web.dart
import 'package:flutter/material.dart';

Widget buildPlatformLocalImageImpl(
  String path, {
  BoxFit fit = BoxFit.cover,
}) {
  return Image.network(
    path,
    fit: fit,
    errorBuilder: (_, __, ___) => const Icon(Icons.broken_image_outlined),
  );
}
