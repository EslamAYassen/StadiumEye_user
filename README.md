
# Example for structure

```bash
lib/
 ├── core/
 │    ├── constants/
 │    ├── errors/
 │    ├── utils/
 │    └── network/
 │
 ├── features/
 │    ├── report/
 │    │     ├── data/
 │    │     │     ├── models/
 │    │     │     │     └── report_model.dart
 │    │     │     ├── datasources/
 │    │     │     │     └── report_remote_ds.dart
 │    │     │     └── repositories/
 │    │     │           └── report_repo_impl.dart
 │    │     │
 │    │     ├── domain/
 │    │     │     ├── entities/
 │    │     │     │     └── report_entity.dart
 │    │     │     ├── repositories/
 │    │     │     │     └── report_repo.dart
 │    │     │     └── usecases/
 │    │     │           ├── create_report.dart
 │    │     │           └── get_my_reports.dart
 │    │     │
 │    │     └── presentation/
 │    │           ├── bloc/
 │    │           │     ├── report_bloc.dart
 │    │           │     ├── report_event.dart
 │    │           │     └── report_state.dart
 │    │           ├── pages/
 │    │           │     ├── add_report_page.dart
 │    │           │     ├── home_page.dart
 │    │           │     └── reports_page.dart
 │    │           └── widgets/
 │    │
 │    │
 │    ├── profile/
 │    │     ├── data/
 │    │     ├── domain/
 │    │     └── presentation/
 │    │        ├── bloc/
 │    │        └── pages/profile_page.dart
 │    │
 │    └─ auth/
 │      ├── data/
 │      │   ├── datasources/
 │      │   │   ├── auth_remote_datasource.dart
 │      │   │   └── auth_local_datasource.dart
 │      │   ├── models/
 │      │   │   └── user_model.dart
 │      │   └── repositories/
 │      │       └── auth_repository_impl.dart
 │      │
 │      ├── domain/
 │      │   ├── entities/
 │      │   │   └── user_entity.dart
 │      │   ├── repositories/
 │      │   │   └── auth_repository.dart
 │      │   └── usecases/
 │      │       ├── login_usecase.dart
 │      │       ├── register_usecase.dart
 │      │       ├── verify_email_usecase.dart
 │      │       ├── logout_usecase.dart
 │      │       ├── forgot_password_usecase.dart
 │      │       ├── verify_reset_code_usecase.dart
 │      │       ├── reset_password_usecase.dart
 │      │       └── get_cached_user_usecase.dart
 │      │
 │      ├── presentation/
 │      │   ├── bloc/
 │      │   │   ├── auth_bloc.dart
 │      │   │   ├── auth_event.dart
 │      │   │   └── auth_state.dart
 │      │   └── pages/
 │      │       ├── login_page.dart
 │      │       ├── register_page.dart
 │      │       ├── verify_email_page.dart
 │      │       ├── forgot_password_page.dart
 │      │       ├── verify_reset_code_page.dart
 │      │       └── reset_password_page.dart
 │      │
 │      └── auth_injection.dart
 │
 └── main.dart
```