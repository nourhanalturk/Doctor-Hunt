import '../../domain/model/uploaded_image_model.dart';
import '../response/uploaded_image_response.dart';

extension UploadedImageMapper on UploadedImageResponse {
  UploadedImageModel toDomain() => UploadedImageModel(url: url);
}
