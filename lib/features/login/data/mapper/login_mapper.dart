import 'package:tender/features/login/data/mapper/login_data_mapper.dart';

import '../../domain/model/login_model.dart';
import '../response/login_response.dart';

extension LoginMapper on LoginResponse {
  LoginModel toDomain() => LoginModel(
        data: data!.toDomain(),
      );
}
