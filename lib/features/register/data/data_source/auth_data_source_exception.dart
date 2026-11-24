/// Data-layer representation of an auth error. Keeps Supabase exception types
/// out of the repository and domain layers.
class AuthDataSourceException implements Exception {
  final String message;
  final String rawMessage;

  const AuthDataSourceException({
    required this.message,
    required this.rawMessage,
  });

  @override
  String toString() => rawMessage;
}
