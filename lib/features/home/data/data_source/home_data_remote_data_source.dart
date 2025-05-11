import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';

import '../response/home_data_response.dart';

abstract class HomeRemoteDataSource {
  Future<List<HomeResponse>> getHomeSections();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final SupabaseClient _client;

  HomeRemoteDataSourceImpl(this._client);

  @override
  Future<List<HomeResponse>> getHomeSections() async {
    final response = await supabase.from('home_data').select('''
        id,
        created_at,
        section,
        name,
        image,
        is_live,
        specialty,
        rating,
        coast_per_hour
    ''').order('created_at', ascending: false);

    return response.map((json) => HomeResponse.fromJson(json)).toList();
  }
}
