import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/profile/data/repository/profile_repository.dart';
import 'package:tender/features/profile/data/request/upload_profile_image_request.dart';
import 'package:tender/features/profile/domain/model/uploaded_image_model.dart';

class UploadProfileImageUseCase
    implements BaseUseCase<UploadProfileImageRequest, UploadedImageModel> {
  final ProfileRepository repository;

  UploadProfileImageUseCase(this.repository);

  @override
  Future<Either<Failure, UploadedImageModel>> execute(
    UploadProfileImageRequest request,
  ) async {
    return repository.uploadProfileImage(request);
  }
}
