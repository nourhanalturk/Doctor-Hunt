import '../../../../config/constants/supabase_fields_constants.dart';

class AvailableTimesResponse {
  final List<dynamic> availableTimes;

  AvailableTimesResponse({required this.availableTimes});

  factory AvailableTimesResponse.fromJson(Map<String, dynamic> json) {
    return AvailableTimesResponse(
      availableTimes: (json[SupabaseFieldsConstants.availableTime] as List?) ??
          const <dynamic>[],
    );
  }
}
