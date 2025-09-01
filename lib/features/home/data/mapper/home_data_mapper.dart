import 'package:tender/core/extensions/extensions.dart';
import '../../domain/model/home_data_model.dart';
import '../response/home_data_response.dart';

extension HomeMapper on HomeResponse {
  HomeModel toDomain() => HomeModel(
    id: id,
    createdAt: createdAt,
    section: section,
    name: name.onNull(),
    image: image.onNull(),
    isLive: isLive.onNull(),
    specialty: specialty.onNull(),
    rating: rating.onNull(),
    coastPerHour: coastPerHour.onNull(),
  );
}