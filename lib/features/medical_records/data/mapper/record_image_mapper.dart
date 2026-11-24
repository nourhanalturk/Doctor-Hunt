import '../../domain/model/record_image_model.dart';
import '../response/uploaded_record_image_response.dart';

extension RecordImageMapper on UploadedRecordImageResponse {
  RecordImageModel toDomain() => RecordImageModel(url: url);
}
