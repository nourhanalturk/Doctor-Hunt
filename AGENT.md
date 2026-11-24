# AGENT.md — Roles and Rules for AI Agents in This Repository

This file defines the roles an AI agent must follow when working in this project.
Read it before changing code. It reflects the existing Flutter architecture in
`lib/` (GetX controllers, GetIt dependency injection, dartz `Either`, Supabase).

---

## Role 1: Architecture Guardian (most important)

Protect the dependency direction:

```
presentation  ->  domain  ->  data  ->  Supabase / other external services
```

Rules:

1. **A controller (`presentation/controller`) must never import or call Supabase.**
   - No `supabase.from(...)`, `Supabase.instance.client`, `SupabaseTableConstants`,
     `SupabaseFieldsConstants`, Dio, or shared preferences calls in a controller.
   - A controller may only: handle UI events, hold UI state, call use cases through
     GetIt (`instance<SomeUseCase>()`), and render results/errors with `dialogRender`
     or `Get.snackbar`.
   - If a controller currently reads the current user id (e.g. `supabase.auth.currentUser!.id`),
     move that lookup into the data source or pass it in from the caller/DI,
     not into a new controller method.
2. **Supabase access belongs only in `data/data_source/*remote_data_source.dart`.**
   - The data source takes an injected `SupabaseClient`, performs the query, and
     returns a `data/response/*Response` (or a primitive/DTO), never a UI model.
3. **`data/repository` translates between data and domain.**
   - It checks `NetworkInfo`, catches exceptions, maps responses to domain models,
     and returns `Either<Failure, T>` (`dartz`).
   - It does not know about GetX or widgets.
4. **`domain/usecase` is the only entry point used by presentation.**
   - Use cases implement `BaseUseCase<In, Out>` or `BaseGetUseCase<Out>` from
     `lib/core/usecase/base_usecase.dart` and return `Future<Either<Failure, Out>>`.
   - Use cases contain no Supabase, NoSQL, HTTP, or widget code.
5. **Views (`presentation/view`) only build widgets and call controller methods.**
   - No business logic, no data-fetching, no direct service access in views/widgets.

If you find an existing violation (for example `getDoctorName` in
`lib/features/bookings/presentation/controller/bookings_controller.dart` queries
Supabase directly), do not copy the pattern. When you touch that code, extract the
query into a data source + repository + use case and keep the controller clean.

### Allowed imports (quick check)

| Layer | May import | Must NOT import |
|---|---|---|
| `presentation/controller` | `core` helpers/usecase interface, `domain/usecase`, feature requests/models, DI | `supabase_flutter`, `data/data_source`, table/field constants |
| `domain/usecase` | `core/usecase`, `core/error_handler`, repository contract, domain models, requests | `supabase_flutter`, `data/data_source`, Flutter widgets |
| `data/repository` | `data/data_source`, `data/mapper`, `core/error_handler`, `core/internet_checker`, domain models | widgets, controllers |
| `data/data_source` | `supabase_flutter`, `config/constants`, `data/request`, `data/response` | controllers, views |

---

## Role 2: Feature Structure Keeper

Follow the folder layout already used by `bookings`, `doctor_appointment`, `home`,
`profile`, and `register`:

```
lib/features/<feature>/
├── data/
│   ├── data_source/    # Supabase query implementation + abstract contract
│   ├── mapper/         # Response -> domain model mapping (toDomain())
│   ├── repository/     # abstract repository + implementation, Either<Failure, T>
│   ├── request/        # request DTOs (with toJson when needed)
│   └── response/       # response DTOs (json_serializable + .g.dart files)
├── domain/
│   ├── di/di.dart      # GetIt registrations + init/dispose for this feature
│   ├── model/          # pure domain models (reuse across features when shared)
│   └── usecase/        # one use case per action (some older features use `use_case/`)
└── presentation/
    ├── controller/     # GetX controller
    └── view/           # screens and `widget/` subfolder for reusable widgets
```

When adding a new action to an existing feature, add a new file in the matching
folders instead of growing an existing controller or data source into a god class.

Naming conventions in this repo:
- `<action>_remote_data_source.dart`: `abstract class <Action>RemoteDataSource` and
  `<Action>RemoteDataSourceImpl`.
- `<action>_repository.dart`: `abstract class <Action>Repository` and
  `<Action>RepositoryImpl`.
- `<action>_usecase.dart`: `class <Action>UseCase implements BaseUseCase<...>`.
- Match the feature's existing folder spelling (`usecase` vs `use_case`, `widget`
  vs `widgets`) instead of renaming unrelated folders.

---

## Role 3: Dependency Injection Manager

- Register every new data source, repository, and use case in the feature's
  `domain/di/di.dart` using `GetIt.I`.
- Register interfaces (`<Action>RemoteDataSource`, `<Action>Repository`) and
  resolve concrete implementations behind them. Inject `SupabaseClient` from
  `GetIt.I<SupabaseClient>()`, which is registered in `lib/config/di/di.dart`.
- Use `registerLazySingleton` for data sources/repositories and `registerFactory`
  for use cases, matching `lib/features/bookings/domain/di/di.dart`.
- Always guard registration with `isRegistered<T>()` and provide a matching
  `dispose...()` that unregisters in reverse order and deletes the GetX controller.
- Wire feature `init...()` / `dispose...()` functions into route/navigation code
  instead of creating controllers manually in widgets.

---

## Role 4: Error and State Handler

- All repository and use case results use `Either<Failure, T>` from `dartz`.
  Return `Left(Failure(...))` / `Left(ServerFailure(...))` on errors and
  `Right(value)` on success; never throw across the domain boundary.
- Check `NetworkInfo.isConnected` before remote calls and return the standard
  no-internet `Failure` when offline (see `get_appointments_repository.dart`).
- Reuse `lib/core/error_handler` (`Failure`, `ServerFailure`,
  `DataSourceExtension`, `ResponseCode`, `TypeHandlerEnum`) and
  `lib/core/resources/manager_strings.dart` for user-facing messages.
- Controllers must handle both `fold` branches, toggle their loading flags, and
  call `update()` consistently.

---

## Role 5: Data Mapping Specialist

- Keep JSON/Supabase row shapes in `data/response` and `data/request` only.
- Convert DTOs to domain models with a `toDomain()` mapper in `data/mapper`, as in
  `get_appointments_mapper.dart`.
- When adding a `@JsonSerializable()` response, run build_runner to generate the
  `.g.dart` file and commit both files.
- Use constants from `config/constants/supabase_tables_constants.dart` and
  `supabase_fields_constants.dart` inside **data sources only**; never hard-code
  table or column strings in controllers.
- Prefer reusing existing domain models (for example `AppointmentModel` from
  `doctor_appointment/domain/model`) over duplicating them in a new feature.

---

## Role 6: Change Minimizer and Verifier

- Do not change unrelated features, routes, translations, or DI registrations.
- Do not expose, log, or move `.env` values; secrets stay out of source code.
- Preserve existing style: 2-space indentation, existing import style, and the
  localization keys in `assets/translations`.
- Before finishing, run:
  - `dart format lib`
  - `flutter analyze`
  - `flutter test` (when tests exist for the touched feature)
- Report which files you changed and confirm that no controller gained direct
  Supabase access.

---

## Example: turning a direct Supabase call into a clean use case

Bad (do not write this):

```dart
// in presentation/controller/booking_controller.dart
getDoctorName(int id) async {
  final value = await supabase
      .from(SupabaseTableConstants.homeData)
      .select()
      .eq('id', id)
      .single();
  doctorName = value['name'];
  update();
}
```

Good — split the same behavior across the layers:

1. `data/data_source/get_doctor_remote_data_source.dart`
   - abstract `GetDoctorRemoteDataSource`
   - `GetDoctorRemoteDataSourceImpl(SupabaseClient client)` performs the `.from(...).select()...` query and returns a response DTO.
2. `data/mapper/get_doctor_mapper.dart` maps the response to a domain model.
3. `data/repository/get_doctor_repository.dart` checks connectivity, catches errors, and returns `Either<Failure, DoctorModel>`.
4. `domain/usecase/get_doctor_usecase.dart` implements `BaseUseCase<int, DoctorModel>` and delegates to the repository.
5. `domain/di/di.dart` registers the data source, repository, and use case with `GetIt.I`.
6. The controller only does:

```dart
final result = await instance<GetDoctorUseCase>().execute(doctorId);
result.fold(
  (failure) => dialogRender(/* error UI */),
  (doctor) {
    doctorName = doctor.name;
    update();
  },
);
```
