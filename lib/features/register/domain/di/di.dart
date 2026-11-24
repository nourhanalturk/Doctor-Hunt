import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/features/register/presentation/controller/register_controller.dart';
import '../../../../config/di/di.dart';
import '../../../favorites/domain/di/di.dart';
import '../../../login/domain/di/di.dart';
import '../../../splash/domain/di.dart';
import '../../data/data_source/add_patient_remote_data_source.dart';
import '../../data/data_source/register_auth_remote_data_source.dart';
import '../../data/repo/add_patient_repository.dart';
import '../../data/repository/register_auth_repository.dart';
import '../usecase/add_patient_usecase.dart';
import '../usecase/is_email_unconfirmed_usecase.dart';
import '../usecase/resend_verification_email_usecase.dart';
import '../usecase/sign_up_usecase.dart';

initAddPatientRequest() {
  if (!GetIt.I.isRegistered<AddPatientRemoteDataSource>()) {
    instance.registerLazySingleton<AddPatientRemoteDataSource>(
        () => AddPatientRemoteDataSourceImpl(instance<SupabaseClient>()));
  }

  if (!GetIt.I.isRegistered<AddPatientRepository>()) {
    instance.registerLazySingleton<AddPatientRepository>(
        () => AddPatientRepositoryImpl(instance()));
  }

  if (!GetIt.I.isRegistered<AddPatientUseCase>()) {
    instance.registerFactory<AddPatientUseCase>(
        () => AddPatientUseCase(instance<AddPatientRepository>()));
  }

  if (!GetIt.I.isRegistered<RegisterAuthRemoteDataSource>()) {
    instance.registerLazySingleton<RegisterAuthRemoteDataSource>(
      () => RegisterAuthRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<RegisterAuthRepository>()) {
    instance.registerLazySingleton<RegisterAuthRepository>(
      () => RegisterAuthRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<SignUpUseCase>()) {
    instance.registerFactory<SignUpUseCase>(
      () => SignUpUseCase(instance<RegisterAuthRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<IsEmailUnconfirmedUseCase>()) {
    instance.registerFactory<IsEmailUnconfirmedUseCase>(
      () => IsEmailUnconfirmedUseCase(instance<RegisterAuthRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<ResendVerificationEmailUseCase>()) {
    instance.registerFactory<ResendVerificationEmailUseCase>(
      () => ResendVerificationEmailUseCase(instance<RegisterAuthRepository>()),
    );
  }
}

disposeAddPatientRequest() {
  if (GetIt.I.isRegistered<ResendVerificationEmailUseCase>()) {
    instance.unregister<ResendVerificationEmailUseCase>();
  }

  if (GetIt.I.isRegistered<IsEmailUnconfirmedUseCase>()) {
    instance.unregister<IsEmailUnconfirmedUseCase>();
  }

  if (GetIt.I.isRegistered<SignUpUseCase>()) {
    instance.unregister<SignUpUseCase>();
  }

  if (GetIt.I.isRegistered<RegisterAuthRepository>()) {
    instance.unregister<RegisterAuthRepository>();
  }

  if (GetIt.I.isRegistered<RegisterAuthRemoteDataSource>()) {
    instance.unregister<RegisterAuthRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<AddPatientUseCase>()) {
    instance.unregister<AddPatientUseCase>();
  }

  if (GetIt.I.isRegistered<AddPatientRepository>()) {
    instance.unregister<AddPatientRepository>();
  }

  if (GetIt.I.isRegistered<AddPatientRemoteDataSource>()) {
    instance.unregister<AddPatientRemoteDataSource>();
  }
}

initRegister() {
  disposeLogin();
  disposeSplash();
  disposeLogin();
  initAddPatientRequest();
  initFavorites();
  if (!Get.isRegistered<RegisterController>()) {
    Get.put<RegisterController>(RegisterController());
  }
}

disposeRegister() {
  disposeAddPatientRequest();
  if (Get.isRegistered<RegisterController>()) {
    Get.delete<RegisterController>();
  }
}
