// lib/utils/helpers/working_hour_helper.dart
import 'package:flutter/material.dart';

const TimeOfDay defaultStartWorkingTime = TimeOfDay(hour: 0, minute: 0);
const TimeOfDay defaultEndWorkingTime = TimeOfDay(hour: 12, minute: 0);

TimeOfDay? parseWorkingHour(String? value) {
  final trimmed = value?.trim() ?? '';
  if (trimmed.isEmpty) return null;

  final parts = trimmed.split(':');
  if (parts.length < 2) return null;

  final hour = int.tryParse(parts[0]);
  final minute = int.tryParse(parts[1]);
  if (hour == null || minute == null) return null;
  if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return null;

  return TimeOfDay(hour: hour, minute: minute);
}

String formatWorkingHour24(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute:00';
}

String displayWorkingHour(TimeOfDay time) {
  final hour24 = time.hour;
  final period = hour24 >= 12 ? 'PM' : 'AM';
  final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour12:$minute $period';
}

TimeOfDay resolveWorkingTime(String? value, TimeOfDay fallback) {
  return parseWorkingHour(value) ?? fallback;
}
