import 'package:supabase_flutter/supabase_flutter.dart';

abstract class CurrentUserDataSource {
  String? getCurrentUserId();
}

class CurrentUserDataSourceImpl implements CurrentUserDataSource {
  final SupabaseClient client;

  CurrentUserDataSourceImpl(this.client);

  @override
  String? getCurrentUserId() => client.auth.currentUser?.id;
}
