import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../request/appointment_request.dart';
import '../response/appointment_response.dart';

abstract class AddAppointmentRemoteDataSource {
  Future<AddAppointmentResponse> addAppointment(AddAppointmentRequest request);
}

class AddAppointmentRemoteDataSourceImpl implements AddAppointmentRemoteDataSource {
  final SupabaseClient client;

  AddAppointmentRemoteDataSourceImpl(this.client);

  @override
  Future<AddAppointmentResponse> addAppointment(AddAppointmentRequest request) async {
    final response = await client
        .from(SupabaseTableConstants.appointments)
        .insert(request.toJson())
        .select()
        .single();

    return AddAppointmentResponse.fromJson(response);
  }
}
