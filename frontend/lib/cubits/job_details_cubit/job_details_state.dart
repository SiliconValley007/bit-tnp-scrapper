part of 'job_details_cubit.dart';

sealed class JobDetailsState extends Equatable {
  const JobDetailsState();

  @override
  List<Object> get props => [];
}

final class JobDetailsCubitInitial extends JobDetailsState {}

final class JobDetailsLoading extends JobDetailsState {}

final class JobDetailsError extends JobDetailsState {
  final String? message;

  const JobDetailsError(this.message);
}

final class JobDetailsLoaded extends JobDetailsState {
  final JobDetails details;

  const JobDetailsLoaded({
    required this.details,
  });
}
