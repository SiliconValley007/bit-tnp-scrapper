// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tnp_scanner/models/job_details/company_details.dart';
import 'package:tnp_scanner/models/job_details/eligibility.dart';
import 'package:tnp_scanner/models/job_details/job_profile_details.dart';
import 'package:tnp_scanner/models/job_details/registration_details.dart';
import 'package:tnp_scanner/models/job_details/salary_details.dart';
import 'package:tnp_scanner/models/job_details/stipend_details.dart';

class JobDetails extends Equatable {
  final CompanyDetails companyDetails;
  final Eligibility eligibility;
  final JobProfileDetails jobProfileDetails;
  final String postedBy;
  final RegistrationDetails registrationDetails;
  final SalaryDetails salaryDetails;
  final String salaryDetailsRemarks;
  final List<String> selectionProcess;
  final StipendDetails stipendDetails;

  const JobDetails({
    required this.companyDetails,
    required this.eligibility,
    required this.jobProfileDetails,
    required this.postedBy,
    required this.registrationDetails,
    required this.salaryDetails,
    required this.salaryDetailsRemarks,
    required this.selectionProcess,
    required this.stipendDetails,
  });

  JobDetails copyWith({
    CompanyDetails? companyDetails,
    Eligibility? eligibility,
    JobProfileDetails? jobProfileDetails,
    String? postedBy,
    RegistrationDetails? registrationDetails,
    SalaryDetails? salaryDetails,
    String? salaryDetailsRemarks,
    List<String>? selectionProcess,
    StipendDetails? stipendDetails,
  }) {
    return JobDetails(
      companyDetails: companyDetails ?? this.companyDetails,
      eligibility: eligibility ?? this.eligibility,
      jobProfileDetails: jobProfileDetails ?? this.jobProfileDetails,
      postedBy: postedBy ?? this.postedBy,
      registrationDetails: registrationDetails ?? this.registrationDetails,
      salaryDetails: salaryDetails ?? this.salaryDetails,
      salaryDetailsRemarks: salaryDetailsRemarks ?? this.salaryDetailsRemarks,
      selectionProcess: selectionProcess ?? this.selectionProcess,
      stipendDetails: stipendDetails ?? this.stipendDetails,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'companyDetails': companyDetails.toMap(),
      'eligibility': eligibility.toMap(),
      'jobProfileDetails': jobProfileDetails.toMap(),
      'postedBy': postedBy,
      'registrationDetails': registrationDetails.toMap(),
      'salaryDetails': salaryDetails.toMap(),
      'salaryDetailsRemarks': salaryDetailsRemarks,
      'selectionProcess': selectionProcess,
      'stipendDetails': stipendDetails.toMap(),
    };
  }

  factory JobDetails.fromMap(Map<String, dynamic> map) {
    return JobDetails(
      companyDetails: CompanyDetails.fromMap(
          map['companyDetails'] as Map<String, dynamic>? ?? {}),
      eligibility: Eligibility.fromMap(
          map['eligibility'] as Map<String, dynamic>? ?? {}),
      jobProfileDetails: JobProfileDetails.fromMap(
          map['jobProfileDetails'] as Map<String, dynamic>? ?? {}),
      postedBy: map['postedBy'] as String? ?? '',
      registrationDetails: RegistrationDetails.fromMap(
          map['registrationDetails'] as Map<String, dynamic>? ?? {}),
      salaryDetails: SalaryDetails.fromMap(
          map['salaryDetails'] as Map<String, dynamic>? ?? {}),
      salaryDetailsRemarks: map['salaryDetailsRemarks'] as String? ?? '',
      selectionProcess: List<String>.from((map['selectionProcess'] ?? [])),
      stipendDetails: StipendDetails.fromMap(
          map['stipendDetails'] as Map<String, dynamic>? ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory JobDetails.fromJson(String source) =>
      JobDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      companyDetails,
      eligibility,
      jobProfileDetails,
      postedBy,
      registrationDetails,
      salaryDetails,
      salaryDetailsRemarks,
      selectionProcess,
      stipendDetails,
    ];
  }
}
