import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/constants/supabase_fields_constants.dart';
import 'package:tender/config/constants/supabase_tables_constants.dart';

import '../response/home_data_response.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeResponse>> getHomeSections();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient client;

  HomeRemoteDataSourceImpl(this.client);

  @override
  Future<List<HomeResponse>> getHomeSections() async {
    final response = await client.from(SupabaseTableConstants.homeData).select('''
        id,
        created_at,
        section,
        name,
        image,
        is_live,
        specialty,
        rating,
        coast_per_hour
    ''').order(SupabaseFieldsConstants.createdAt, ascending: false);

    return response.map((json) => HomeResponse.fromJson(json)).toList();
  }
}
