import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/features/medical_records/data/request/add_medical_record_request.dart';
import 'package:tender/features/medical_records/data/response/uploaded_record_image_response.dart';

abstract class MedicalRecordsRemoteDataSource {
  Future<UploadedRecordImageResponse> uploadRecordImage(File image);

  Future<void> addMedicalRecord(AddMedicalRecordRequest request);
}

class MedicalRecordsRemoteDataSourceImpl
    implements MedicalRecordsRemoteDataSource {
  final SupabaseClient client;

  MedicalRecordsRemoteDataSourceImpl(this.client);

  @override
  Future<UploadedRecordImageResponse> uploadRecordImage(File image) async {
    final userId = client.auth.currentUser!.id;
    final fileName = DateTime.now().microsecondsSinceEpoch.toString();
    final path = '$userId/$fileName';

    await client.storage
        .from(SupabaseTableConstants.records)
        .upload(path, image);
    final url = client.storage
        .from(SupabaseTableConstants.records)
        .getPublicUrl(path);

    return UploadedRecordImageResponse(url: url);
  }

  @override
  Future<void> addMedicalRecord(AddMedicalRecordRequest request) async {
    await client.from(SupabaseTableConstants.medicalRecords).insert({
      ...request.toJson(),
      SupabaseFieldsConstants.patientId: client.auth.currentUser!.id,
    });
  }
}
