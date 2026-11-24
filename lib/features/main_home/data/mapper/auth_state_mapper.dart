import '../../domain/model/auth_state_model.dart';
import '../response/auth_state_response.dart';

extension AuthStateMapper on AuthStateResponse {
  AuthStateModel toDomain() => AuthStateModel(
        event: event,
        userId: userId,
        hasSession: hasSession,
      );
}
