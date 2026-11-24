import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tender/core/error_handler/failure.dart';
import 'package:tender/core/usecase/base_usecase.dart';
import 'package:tender/features/medical_records/data/repository/medical_records_repository.dart';
import 'package:tender/features/medical_records/domain/model/record_image_model.dart';

class UploadRecordImageUseCase implements BaseUseCase<File, RecordImageModel> {
  final MedicalRecordsRepository repository;

  UploadRecordImageUseCase(this.repository);

  @override
  Future<Either<Failure, RecordImageModel>> execute(File image) async {
    return repository.uploadRecordImage(image);
  }
}
