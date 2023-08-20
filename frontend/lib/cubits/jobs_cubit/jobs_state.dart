part of 'jobs_cubit.dart';

abstract class JobsState extends Equatable {
  const JobsState();

  @override
  List<Object> get props => [];
}

class JobsLoading extends JobsState {
  const JobsLoading();
}

class JobsLoaded extends JobsState {
  const JobsLoaded({required this.newJobs});

  final List<Job> newJobs;

  @override
  List<Object> get props => [newJobs];
}

class CoursePreferenceChanged extends JobsState {
  final String currentCoursePreference;

  const CoursePreferenceChanged({
    required this.currentCoursePreference,
  });
}
