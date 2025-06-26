import 'package:tender/config/constants/supabase_tables_constants.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/core/internet_checker/internet_checker.dart';
import 'package:tender/features/profile/data/request/profile_request.dart';

abstract class ProfileRemoteDataSource {
  Future<void> profile(ProfileRequest request);
}

class ProfileRemoteDataSourceImplementation implements ProfileRemoteDataSource {


  @override
  Future<void> profile(ProfileRequest request) async {
    final response = await supabase
        .from(SupabaseTableConstants.profile)
        .select('user_id')
        .eq('user_id', request.userId)
        .maybeSingle();

    if (response != null) {
      await supabase
          .from(SupabaseTableConstants.profile)
          .update(request.toJson())
          .eq('user_id', request.userId);
    } else {
      await supabase
          .from(SupabaseTableConstants.profile)
          .insert(request.toJson());
    }
  }
}
