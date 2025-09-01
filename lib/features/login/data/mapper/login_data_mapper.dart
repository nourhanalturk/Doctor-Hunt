import 'package:tender/core/extensions/extensions.dart';
import '../../domain/model/login_data_model.dart';
import '../response/login_data_response.dart';

extension LoginDataMapper on LoginDataResponse {
  LoginDataModel toDomain() => LoginDataModel(
        token: token.onNull(),
      );
}
