import '../../domain/model/sign_up_model.dart';
import '../response/sign_up_response.dart';

extension SignUpMapper on SignUpResponse {
  SignUpModel toDomain() => SignUpModel(userId: userId);
}
