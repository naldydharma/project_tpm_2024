import 'package:flutter/material.dart';
import 'package:project_tpm1/model/waktu_model.dart';

class TimeConversionController {
  final List<String> timeZones = ['WIB', 'WITA', 'WIT', 'London'];
  TimeConversionModel? convertedTime;

  void convertTime(TimeOfDay selectedTime, String startZone, String endZone) {
    final startOffset = _getTimeOffset(startZone);
    final endOffset = _getTimeOffset(endZone);

    final selectedDuration = Duration(hours: selectedTime.hour, minutes: selectedTime.minute);
    final initialTimeInUTC = selectedDuration - startOffset;
    final finalTime = initialTimeInUTC + endOffset;

    convertedTime = TimeConversionModel(
      startZone: startZone,
      endZone: endZone,
      convertedDuration: finalTime,
    );
  }

  Duration _getTimeOffset(String zone) {
    switch (zone) {
      case 'WIB':
        return Duration(hours: 7);
      case 'WITA':
        return Duration(hours: 8);
      case 'WIT':
        return Duration(hours: 9);
      case 'London':
        return Duration(hours: 0); // Assume UTC+0 for London
      default:
        return Duration(hours: 7);
    }
  }

  String formatTimeOfDay(Duration offset) {
    final hours = (offset.inHours + 24) % 24;
    final minutes = offset.inMinutes % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }
}