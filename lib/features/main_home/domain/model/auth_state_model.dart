class AuthStateModel {
  final String event;
  final String? userId;
  final bool hasSession;

  const AuthStateModel({
    required this.event,
    required this.userId,
    required this.hasSession,
  });
}
