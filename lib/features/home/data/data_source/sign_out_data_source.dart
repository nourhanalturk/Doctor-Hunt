import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SignOutDataSource {
  Future<void> signOut();
}

class SignOutDataSourceImpl implements SignOutDataSource {
  final SupabaseClient client;

  SignOutDataSourceImpl(this.client);

  @override
  Future<void> signOut() => client.auth.signOut();
}
