import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tender/config/di/di.dart';
import 'package:tender/features/login/presentation/controller/login_controller.dart';
import 'package:tender/features/main_home/domain/di/di.dart';
import 'package:tender/features/out_boarding/domain/di.dart';
import 'package:tender/features/register/domain/di/di.dart';
import 'package:tender/features/splash/domain/di.dart';

import '../../../../core/network/app_api.dart';
import '../../../favorites/domain/di/di.dart';
import '../../data/data_source/auth_remote_data_source.dart';
import '../../data/data_source/login_data_source.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/login_repository.dart';
import '../usecase/is_email_unconfirmed_usecase.dart';
import '../usecase/login_usecase.dart';
import '../usecase/resend_otp_usecase.dart';
import '../usecase/sign_in_usecase.dart';

initLoginRequest() {
  if (!GetIt.I.isRegistered<LoginRemoteDataSource>()) {
    instance.registerLazySingleton<LoginRemoteDataSource>(
        () => LoginRemoteDataSourceImplement(instance<AppService>()));
  }

  if (!GetIt.I.isRegistered<LoginRepository>()) {
    instance.registerLazySingleton<LoginRepository>(
        () => LoginRepositoryImplement(instance(), instance()));
  }

  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(
        () => LoginUseCase(instance<LoginRepository>()));
  }

  if (!GetIt.I.isRegistered<AuthRemoteDataSource>()) {
    instance.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(instance<SupabaseClient>()),
    );
  }

  if (!GetIt.I.isRegistered<AuthRepository>()) {
    instance.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(instance(), instance()),
    );
  }

  if (!GetIt.I.isRegistered<SignInUseCase>()) {
    instance.registerFactory<SignInUseCase>(
      () => SignInUseCase(instance<AuthRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<IsEmailUnconfirmedUseCase>()) {
    instance.registerFactory<IsEmailUnconfirmedUseCase>(
      () => IsEmailUnconfirmedUseCase(instance<AuthRepository>()),
    );
  }

  if (!GetIt.I.isRegistered<ResendOtpUseCase>()) {
    instance.registerFactory<ResendOtpUseCase>(
      () => ResendOtpUseCase(instance<AuthRepository>()),
    );
  }
}

disposeLoginRequest() {
  if (GetIt.I.isRegistered<ResendOtpUseCase>()) {
    instance.unregister<ResendOtpUseCase>();
  }

  if (GetIt.I.isRegistered<IsEmailUnconfirmedUseCase>()) {
    instance.unregister<IsEmailUnconfirmedUseCase>();
  }

  if (GetIt.I.isRegistered<SignInUseCase>()) {
    instance.unregister<SignInUseCase>();
  }

  if (GetIt.I.isRegistered<AuthRepository>()) {
    instance.unregister<AuthRepository>();
  }

  if (GetIt.I.isRegistered<AuthRemoteDataSource>()) {
    instance.unregister<AuthRemoteDataSource>();
  }

  if (GetIt.I.isRegistered<LoginUseCase>()) {
    instance.unregister<LoginUseCase>();
  }

  if (GetIt.I.isRegistered<LoginRepository>()) {
    instance.unregister<LoginRepository>();
  }

  if (GetIt.I.isRegistered<LoginRemoteDataSource>()) {
    instance.unregister<LoginRemoteDataSource>();
  }
}

initLogin() {
  print("initLogin called");
  initLoginRequest();
  disposeOutBoarding();
  disposeSplash();
  disposeRegister();
  disposeMainHome();
  // disposeMainContainer();
  initFavorites();
  if (!Get.isRegistered<LoginController>()) {
    Get.put(LoginController());
  }
}

disposeLogin() {
  disposeLoginRequest();
  if (Get.isRegistered<LoginController>()) {
    Get.delete<LoginController>();
  }
}
