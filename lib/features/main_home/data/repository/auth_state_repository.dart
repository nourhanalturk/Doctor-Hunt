import '../../domain/model/auth_state_model.dart';
import '../data_source/auth_state_remote_data_source.dart';
import '../mapper/auth_state_mapper.dart';

abstract class AuthStateRepository {
  Stream<AuthStateModel> watchAuthState();
}

class AuthStateRepositoryImpl implements AuthStateRepository {
  final AuthStateRemoteDataSource remoteDataSource;

  AuthStateRepositoryImpl(this.remoteDataSource);

  @override
  Stream<AuthStateModel> watchAuthState() =>
      remoteDataSource.watchAuthState().map((response) => response.toDomain());
}
