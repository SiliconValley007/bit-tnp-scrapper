import 'package:get_it/get_it.dart';

import 'repositories/job_repository.dart';

late final GetIt locator;

void setup() {
  locator = GetIt.I;
  locator.registerLazySingleton<JobRepository>(() => JobRepository());
}
