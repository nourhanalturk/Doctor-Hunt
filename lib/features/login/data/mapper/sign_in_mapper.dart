import '../../domain/model/sign_in_model.dart';
import '../response/sign_in_response.dart';

extension SignInMapper on SignInResponse {
  SignInModel toDomain() => SignInModel(userId: userId);
}
