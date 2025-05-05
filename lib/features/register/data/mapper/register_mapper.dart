import 'package:tender/core/extensions/extensions.dart';

import '../../domain/model/register_model.dart';
import '../response/register_response.dart';

extension RegisterMapper on RegisterResponse {
  RegisterModel toDomain() => RegisterModel(
        status: status.onNull(),
      );
}
