import 'package:supabase_flutter/supabase_flutter.dart';

import '../request/sign_in_request.dart';
import '../response/sign_in_response.dart';
import 'auth_data_source_exception.dart';

abstract class AuthRemoteDataSource {
  Future<SignInResponse> signInWithPassword(SignInRequest request);

  bool isEmailUnconfirmed();

  Future<void> resendVerificationEmail(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<SignInResponse> signInWithPassword(SignInRequest request) async {
    try {
      final response = await client.auth.signInWithPassword(
        email: request.email,
        password: request.password,
      );

      return SignInResponse(userId: response.user?.id);
    } on AuthException catch (e) {
      throw AuthDataSourceException(
        message: e.message,
        rawMessage: e.toString(),
      );
    }
  }

  @override
  bool isEmailUnconfirmed() {
    // Mirrors the previous check:
    // currentUser?.emailConfirmedAt.onNull() == null
    // which is only true when there is no current user.
    return client.auth.currentUser == null;
  }

  @override
  Future<void> resendVerificationEmail(String email) async {
    try {
      await client.auth.signInWithOtp(email: email);
    } on AuthException catch (e) {
      throw AuthDataSourceException(
        message: e.message,
        rawMessage: e.toString(),
      );
    }
  }
}
