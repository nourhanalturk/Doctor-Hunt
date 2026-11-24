import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../response/get_appointments_response.dart';

abstract class GetAppointmentsRemoteDataSource {
  Future<List<GetAppointmentsResponse>> getAppointments();
}

class GetAppointmentsRemoteDataSourceImpl implements GetAppointmentsRemoteDataSource {
  final SupabaseClient client;

  GetAppointmentsRemoteDataSourceImpl(this.client);

  @override
  Future<List<GetAppointmentsResponse>> getAppointments() async {
    final patientId = client.auth.currentUser!.id;
    final response = await client
        .from(SupabaseTableConstants.appointments)
        .select()
        .eq(SupabaseFieldsConstants.patientId, patientId);

    if (response.isEmpty) {
      return [];
    }

    return (response as List)
        .map((json) => GetAppointmentsResponse.fromJson(json))
        .toList();
  }
}
