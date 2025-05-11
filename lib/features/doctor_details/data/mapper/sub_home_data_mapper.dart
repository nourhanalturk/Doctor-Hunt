import '../../domain/model/sub_home_data_model.dart';
import '../response/sub_home_data_response.dart';

extension SubHomeDataMapper on SubHomeDataResponse {
  SubHomeDataModel toDomain() => SubHomeDataModel(
    name: name,
    image: image,
    speciality: speciality,
    rating: rate,
  );
}
