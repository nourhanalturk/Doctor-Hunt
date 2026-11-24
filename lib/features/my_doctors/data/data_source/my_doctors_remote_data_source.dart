import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../config/constants/supabase_fields_constants.dart';
import '../../../../config/constants/supabase_tables_constants.dart';
import '../response/doctor_ids_response.dart';
import '../response/my_doctors_response.dart';

abstract class MyDoctorsRemoteDataSource {
  Future<List<DoctorIdsResponse>> getDoctorIds();

  Future<List<MyDoctorsResponse>> getDoctorDetails(List<int> doctorIds);
}

class MyDoctorsRemoteDataSourceImpl implements MyDoctorsRemoteDataSource {
  final SupabaseClient client;

  MyDoctorsRemoteDataSourceImpl(this.client);

  @override
  Future<List<DoctorIdsResponse>> getDoctorIds() async {
    final patientId = client.auth.currentUser!.id;
    final response = await client
        .from(SupabaseTableConstants.appointments)
        .select(SupabaseFieldsConstants.doctorId)
        .eq(SupabaseFieldsConstants.patientId, patientId);

    return response.map((e) => DoctorIdsResponse.fromJson(e)).toList();
  }

  @override
  Future<List<MyDoctorsResponse>> getDoctorDetails(List<int> doctorIds) async {
    final response = await client
        .from(SupabaseTableConstants.homeData)
        .select(
            '${SupabaseFieldsConstants.name}, ${SupabaseFieldsConstants.image}')
        .inFilter(SupabaseFieldsConstants.id, doctorIds);

    return response.map((e) => MyDoctorsResponse.fromJson(e)).toList();
  }
}
