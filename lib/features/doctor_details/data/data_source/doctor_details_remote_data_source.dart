import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';

import '../../../../core/error_handler/server_faiure.dart';
import '../response/doctor_details_response.dart';

abstract class DoctorDetailsRemoteDataSource {
  Future<List<DoctorDetailsResponse>> getDoctorDetails(int doctorId);
}

class DoctorDetailsRemoteDataSourceImpl
    implements DoctorDetailsRemoteDataSource {
  final SupabaseClient _client;

  DoctorDetailsRemoteDataSourceImpl(this._client);

  @override
  Future<List<DoctorDetailsResponse>> getDoctorDetails(int doctorId) async {
    try {
      final response = await supabase
          .from('doctor_details')
          .select('*, home_data:home_data_id (name, image, specialty, rating)')
          .eq('doctor_id', doctorId)
          .single();

      return [
        DoctorDetailsResponse.fromJson(response)
      ];


    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
