import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
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
    final response = await supabase.from('patients').insert(request.toJson()).select();
    return PatientsResponse.fromJson(response.first);
  }
}
