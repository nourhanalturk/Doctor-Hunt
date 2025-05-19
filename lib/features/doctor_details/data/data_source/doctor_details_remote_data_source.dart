import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';

import '../../../../core/error_handler/server_failure.dart';
import '../response/doctor_details_response.dart';

abstract class DoctorDetailsRemoteDataSource {
  Future<List<DoctorDetailsResponse>> getDoctorDetails(int doctorId);
}

class DoctorDetailsRemoteDataSourceImpl
    implements DoctorDetailsRemoteDataSource {

  DoctorDetailsRemoteDataSourceImpl();

  @override
  Future<List<DoctorDetailsResponse>> getDoctorDetails(int doctorId) async {
    try {
      final response = await supabase
          .from(SupabaseTableConstants.doctorDetails)
          .select('*, home_data:home_data_id (name, image, specialty, rating)')
          .eq(SupabaseFieldsConstants.doctorId, doctorId)
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
