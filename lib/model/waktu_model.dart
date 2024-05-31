class TimeConversionModel {
  final String startZone;
  final String endZone;
  final Duration convertedDuration;

  TimeConversionModel({
    required this.startZone,
    required this.endZone,
    required this.convertedDuration,
  });
}