import '../../../../core/error_handler/failure.dart';
import '../../../../core/error_handler/response_code.dart';

/// Carries both the user facing message and the raw message that was shown in
/// the error dialog before the Supabase call was moved behind a use case.
class AuthFailure extends Failure {
  final String dialogMessage;

  AuthFailure({
    required String message,
    required this.dialogMessage,
  }) : super(ResponseCode.unKnown, message);
}
