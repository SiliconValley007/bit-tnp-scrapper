import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tnp_scanner/models/job_details/job_details.dart';

import '../interface/repository.dart';
import '../models/job.dart';

class JobRepository implements Repository {
  late final CollectionReference _collectionRef;
  late final CollectionReference _collectionRefJobDetails;

  JobRepository() {
    final FirebaseFirestore instance = FirebaseFirestore.instance;
    _collectionRef = instance.collection('jobs');
    _collectionRefJobDetails = instance.collection('job-details');
  }

  @override
  Stream<List<Job>> getItems() {
    // Query query = _collectionRef.orderBy("postedOn", descending: true);
    // if (_lastFetchedDocument != null) {
    //   query = query.startAfterDocument(_lastFetchedDocument!).limit(paginationSize);
    // } else {
    //   query = query.limit(paginationSize);
    // }
    // return query.snapshots().map((snapshot) {
    //   _lastFetchedDocument = snapshot.docs.last;
    //   return snapshot.docs.map((doc) {
    //     final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //     return Job.fromMap(data);
    //   }).toList();
    // });
    return _collectionRef
        .orderBy("postedOn", descending: true)
        .snapshots()
        .map((snapshot) {
      // _lastFetchedDocument = snapshot.docs.last;
      return snapshot.docs.map((doc) {
        final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Job.fromMap(data, id: doc.id);
      }).toList();
    });
  }

  @override
  Future<JobDetails?> getDetailedJobDescription({required String id}) async {
    try {
      DocumentSnapshot snapshot = await _collectionRefJobDetails.doc(id).get();

      if (snapshot.exists) {
        return JobDetails.fromMap(snapshot.data() as Map<String, dynamic>);
      }

      return null; // No document with the provided ID
    } catch (e) {
      log('Error fetching job: $e');
      return null;
    }
  }
}
