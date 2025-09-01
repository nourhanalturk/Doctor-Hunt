import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../config/constants/supabase_tables_constants.dart';
import '../../../../config/constants/supabase_fields_constants.dart';

abstract class FavoritesRemoteDataSource {
  Future<List<int>> getFavorites(String userId);

  Future<void> toggleFavorite(String userId, int doctorId);
}

class FavoritesRemoteDataSourceImpl implements FavoritesRemoteDataSource {
  final SupabaseClient client;

  FavoritesRemoteDataSourceImpl(this.client);

  @override
  Future<List<int>> getFavorites(String userId) async {
    final response = await client
        .from(SupabaseTableConstants.favorites)
        .select(SupabaseFieldsConstants.doctorId)
        .eq(SupabaseFieldsConstants.userId, userId);

    return (response as List)
        .map((e) => e[SupabaseFieldsConstants.doctorId] as int)
        .toList();
  }

  @override
  Future<void> toggleFavorite(String userId, int doctorId) async {
    try {
      final existing = await client
          .from(SupabaseTableConstants.favorites)
          .select()
          .eq(SupabaseFieldsConstants.userId, userId)
          .eq(SupabaseFieldsConstants.doctorId, doctorId)
          .maybeSingle();

      if (existing != null) {
        await client
            .from(SupabaseTableConstants.favorites)
            .delete()
            .eq(SupabaseFieldsConstants.userId, userId)
            .eq(SupabaseFieldsConstants.doctorId, doctorId);
      } else {
        // Add to favorites
        await client.from(SupabaseTableConstants.favorites).insert({
          SupabaseFieldsConstants.userId: userId,
          SupabaseFieldsConstants.doctorId: doctorId,
        });
      }
    } catch (e) {
      print('Toggle favorite error: $e');
      rethrow;
    }
  }
}
