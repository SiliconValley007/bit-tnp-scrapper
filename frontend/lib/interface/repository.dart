import '../models/job.dart';
import '../models/job_details/job_details.dart';

abstract class Repository {
  Stream<List<Job>> getItems();
  Future<JobDetails?> getDetailedJobDescription({required String id});
}
