class AuthStateResponse {
  final String event;
  final String? userId;
  final bool hasSession;

  const AuthStateResponse({
    required this.event,
    required this.userId,
    required this.hasSession,
  });
}
