
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
 │
 │    
 ├── features/
 │    ├── profile/
 │    │     ├── data/
 │    │     ├── domain/
 │    │     └── presentation/
 │            ├── bloc/
 │            └── pages/profile_page.dart
 │
 └── main.dart
```