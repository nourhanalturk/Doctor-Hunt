import 'package:supabase_flutter/supabase_flutter.dart';

import '../response/auth_state_response.dart';

abstract class AuthStateRemoteDataSource {
  Stream<AuthStateResponse> watchAuthState();
}

class AuthStateRemoteDataSourceImpl implements AuthStateRemoteDataSource {
  final SupabaseClient client;

  AuthStateRemoteDataSourceImpl(this.client);

  @override
  Stream<AuthStateResponse> watchAuthState() =>
      client.auth.onAuthStateChange.map(
        (data) => AuthStateResponse(
          event: data.event.toString(),
          userId: data.session?.user.id,
          hasSession: data.session != null,
        ),
      );
}
