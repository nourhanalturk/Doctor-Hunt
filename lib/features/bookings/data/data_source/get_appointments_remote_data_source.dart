import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../request/get_appointment_request.dart';
import '../response/get_appointments_response.dart';

abstract class GetAppointmentsRemoteDataSource {
  Future<List<GetAppointmentsResponse>> getAppointments(GetAppointmentsRequest request);
}

class GetAppointmentsRemoteDataSourceImpl implements GetAppointmentsRemoteDataSource {
  final SupabaseClient client;

  GetAppointmentsRemoteDataSourceImpl(this.client);

  @override
  Future<List<GetAppointmentsResponse>> getAppointments(GetAppointmentsRequest request) async {
    final response = await client
        .from(SupabaseTableConstants.appointments)
        .select()
        .eq('patient_id', request.userId);

    if (response.isEmpty) {
      return [];
    }

    return (response as List)
        .map((json) => GetAppointmentsResponse.fromJson(json))
        .toList();
  }
}
