import '../../domain/model/available_time_model.dart';
import '../response/available_times_response.dart';

extension AvailableTimesMapper on List<AvailableTimesResponse> {
  List<AvailableTimeModel> toDomain(String date) {
    return expand((response) => response.availableTimes)
        .map(
          (time) => AvailableTimeModel(
            dateTime: DateTime.parse('$date ${time.toString()}'),
          ),
        )
        .toList();
  }
}
