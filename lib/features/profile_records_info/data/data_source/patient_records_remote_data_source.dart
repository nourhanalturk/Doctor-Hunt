import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/features/profile_records_info/data/response/patient_record_response.dart';
import 'package:tender/features/profile_records_info/data/response/patient_response.dart';

abstract class PatientRecordsRemoteDataSource {
  Future<PatientResponse> getPatientInfo(String userId);

  Future<List<PatientRecordResponse>> getPatientRecords(String userId);
}

class PatientRecordsRemoteDataSourceImpl
    implements PatientRecordsRemoteDataSource {
  final SupabaseClient client;

  PatientRecordsRemoteDataSourceImpl(this.client);

  @override
  Future<PatientResponse> getPatientInfo(String userId) async {
    final response = await client
        .from(SupabaseTableConstants.patients)
        .select()
        .eq(SupabaseFieldsConstants.patientId, userId)
        .single();

    return PatientResponse.fromJson(Map<String, dynamic>.from(response as Map));
  }

  @override
  Future<List<PatientRecordResponse>> getPatientRecords(String userId) async {
    final response = await client
        .from(SupabaseTableConstants.medicalRecords)
        .select()
        .eq(SupabaseFieldsConstants.patientId, userId);

    return (response as List)
        .map(
          (e) => PatientRecordResponse.fromJson(
            Map<String, dynamic>.from(e as Map),
          ),
        )
        .toList();
  }
}
