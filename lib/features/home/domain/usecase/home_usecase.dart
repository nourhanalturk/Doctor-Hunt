import 'package:dartz/dartz.dart';
import '../../../../core/error_handler/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/repository/home_data_repository.dart';
import '../model/home_data_model.dart';

class HomeUsecase implements BaseGetUseCase<List<HomeModel>> {
  final HomeRepository repository;

  HomeUsecase(this.repository);

  @override
  Future<Either<Failure, List<HomeModel>>> execute() async {
    return await repository.getHomeSections();
  }
}
