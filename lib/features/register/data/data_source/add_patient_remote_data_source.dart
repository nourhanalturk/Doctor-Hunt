import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/features/register/data/response/add_patient_response.dart';

import '../request/add_patient_request.dart';

abstract class AddPatientRemoteDataSource {
  Future<PatientsResponse> addPatient(AddPatientRequest request);
}

class AddPatientRemoteDataSourceImpl implements AddPatientRemoteDataSource {
  final SupabaseClient _client;

  AddPatientRemoteDataSourceImpl(this._client);

  @override
  Future<PatientsResponse> addPatient(AddPatientRequest request) async {
    final payload = request.toJson();
    payload['profile_image_url'] =
        request.profileImageUrl ?? Constants.defaultImageUrl;

    final response = await _client
        .from(SupabaseTableConstants.patients)
        .insert(payload)
        .select();

    return PatientsResponse.fromJson(response.first);
  }
}
