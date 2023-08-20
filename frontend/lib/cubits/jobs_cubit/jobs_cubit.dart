import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnp_scanner/cubits/course_search_cubit/course_search_cubit.dart';
import 'package:tnp_scanner/manager/course_manager.dart';

import '../../locator.dart';
import '../../models/job.dart';
import '../../repositories/job_repository.dart';

part 'jobs_state.dart';

class JobsCubit extends Cubit<JobsState> {
  JobsCubit({required this.searchCubit}) : super(const JobsLoading()) {
    _jobRepository = locator.get<JobRepository>();
    _jobListings = _jobRepository.getItems().listen((jobs) {
      for (int i = 0; i < jobs.length; i++) {
        CourseManager.addUniqueString(jobs[i].courses);
      }
      CourseManager.finalizeList();
      searchCubit.searchCourses();
      emit(JobsLoaded(newJobs: jobs));
    });
  }

  late final JobRepository _jobRepository;
  late StreamSubscription<List<Job>> _jobListings;
  final CourseSearchCubit searchCubit;

  @override
  Future<void> close() {
    _jobListings.cancel();
    return super.close();
  }
}
