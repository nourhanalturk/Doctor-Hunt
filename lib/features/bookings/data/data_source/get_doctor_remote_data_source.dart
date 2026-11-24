import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../request/get_doctor_request.dart';
import '../response/get_doctor_response.dart';

abstract class GetDoctorRemoteDataSource {
  Future<GetDoctorResponse> getDoctor(GetDoctorRequest request);
}

class GetDoctorRemoteDataSourceImpl implements GetDoctorRemoteDataSource {
  final SupabaseClient client;

  GetDoctorRemoteDataSourceImpl(this.client);

  @override
  Future<GetDoctorResponse> getDoctor(GetDoctorRequest request) async {
    final response = await client
        .from(SupabaseTableConstants.homeData)
        .select(SupabaseFieldsConstants.name)
        .eq(SupabaseFieldsConstants.id, request.doctorId)
        .single();

    return GetDoctorResponse.fromJson(response);
  }
}
