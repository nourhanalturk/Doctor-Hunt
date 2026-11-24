import 'package:supabase_flutter/supabase_flutter.dart';

import '../request/sign_up_request.dart';
import '../response/sign_up_response.dart';
import 'auth_data_source_exception.dart';

abstract class RegisterAuthRemoteDataSource {
  Future<SignUpResponse> signUp(SignUpRequest request);

  bool isEmailUnconfirmed();

  Future<void> resendVerificationEmail(String email);
}

class RegisterAuthRemoteDataSourceImpl implements RegisterAuthRemoteDataSource {
  final SupabaseClient client;

  RegisterAuthRemoteDataSourceImpl(this.client);

  @override
  Future<SignUpResponse> signUp(SignUpRequest request) async {
    try {
      final response = await client.auth.signUp(
        email: request.email,
        password: request.password,
      );

      return SignUpResponse(userId: response.user!.id);
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
