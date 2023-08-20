import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tnp_scanner/repositories/job_repository.dart';

import '../../locator.dart';
import '../../models/job_details/job_details.dart';

part 'job_details_state.dart';

class JobDetailsCubit extends Cubit<JobDetailsState> {
  JobDetailsCubit() : super(JobDetailsCubitInitial()) {
    _jobRepository = locator.get<JobRepository>();
  }

  late final JobRepository _jobRepository;

  void getJobDetails(String id) async {
    emit(JobDetailsLoading());
    final JobDetails? details =
        await _jobRepository.getDetailedJobDescription(id: id);
    if (details != null) {
      log(details.toString());
      emit(JobDetailsLoaded(details: details));
    } else {
      emit(JobDetailsError(
          'No job details found. Please contact administrator. \nReport id: $id'));
    }
  }
}
