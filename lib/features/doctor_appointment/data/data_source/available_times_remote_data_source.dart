import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../request/get_available_times_request.dart';
import '../request/update_available_time_request.dart';
import '../response/available_times_response.dart';

abstract class AvailableTimesRemoteDataSource {
  Future<List<AvailableTimesResponse>> getAvailableTimes(
    GetAvailableTimesRequest request,
  );

  Future<void> updateDoctorAvailableTime(
    UpdateAvailableTimeRequest request,
  );
}

class AvailableTimesRemoteDataSourceImpl
    implements AvailableTimesRemoteDataSource {
  final SupabaseClient client;

  AvailableTimesRemoteDataSourceImpl(this.client);

  @override
  Future<List<AvailableTimesResponse>> getAvailableTimes(
    GetAvailableTimesRequest request,
  ) async {
    final response = await client
        .from(SupabaseTableConstants.availableTimes)
        .select(SupabaseFieldsConstants.availableTime)
        .eq(SupabaseFieldsConstants.doctorId, request.doctorId)
        .eq(SupabaseFieldsConstants.availableDate, request.date);

    return (response as List)
        .map(
          (row) => AvailableTimesResponse.fromJson(row as Map<String, dynamic>),
        )
        .toList();
  }

  @override
  Future<void> updateDoctorAvailableTime(
    UpdateAvailableTimeRequest request,
  ) async {
    final currentTimes = await client
        .from(SupabaseTableConstants.availableTimes)
        .select(SupabaseFieldsConstants.availableTime)
        .eq(SupabaseFieldsConstants.doctorId, request.doctorId)
        .eq(SupabaseFieldsConstants.availableDate, request.date)
        .single();

    final updatedTimes =
        ((currentTimes[SupabaseFieldsConstants.availableTime] as List?) ??
                const <dynamic>[])
            .where((time) => time != request.timeToRemove)
            .toList();

    await client
        .from(SupabaseTableConstants.availableTimes)
        .update({SupabaseFieldsConstants.availableTime: updatedTimes})
        .eq(SupabaseFieldsConstants.doctorId, request.doctorId)
        .eq(SupabaseFieldsConstants.availableDate, request.date);
  }
}
