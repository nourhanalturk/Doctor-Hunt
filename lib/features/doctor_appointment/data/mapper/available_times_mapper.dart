import 'package:intl/intl.dart';

import '../../domain/model/available_time_model.dart';
import '../response/available_times_response.dart';

extension AvailableTimesMapper on List<AvailableTimesResponse> {
  List<AvailableTimeModel> toDomain(String date) {
    return expand((response) => response.availableTimes)
        .map((time) => AvailableTimeModel(dateTime: _parseTime(date, time)))
        .where((model) => model.dateTime.year != 1970)
        .toList();
  }
}

DateTime _parseTime(String date, dynamic time) {
  final String raw = '$date ${time.toString().trim()}';

  final DateTime? direct = DateTime.tryParse(raw);
  if (direct != null) return direct;

  const List<String> formats = [
    'yyyy-MM-dd HH:mm:ss',
    'yyyy-MM-dd HH:mm',
    'yyyy-MM-dd h:mm a',
    'yyyy-MM-dd h:mm:ss a',
    'yyyy-MM-ddTh:mm:ss',
  ];

  for (final String format in formats) {
    try {
      return DateFormat(format).parse(raw);
    } catch (_) {
      // Try the next supported backend format.
    }
  }

  // Keep the selected date even when the backend sends an unknown time shape.
  return DateTime.tryParse(date) ?? DateTime.now();
}
