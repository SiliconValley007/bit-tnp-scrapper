// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tnp_scanner/models/job_details/full_time_employment.dart';
import 'package:tnp_scanner/models/job_details/internship.dart';

class JobProfileDetails extends Equatable {
  final FullTimeEmployment fullTimeEmployment;
  final Internship internship;
  const JobProfileDetails({
    required this.fullTimeEmployment,
    required this.internship,
  });

  JobProfileDetails copyWith({
    FullTimeEmployment? fullTimeEmployment,
    Internship? internship,
  }) {
    return JobProfileDetails(
      fullTimeEmployment: fullTimeEmployment ?? this.fullTimeEmployment,
      internship: internship ?? this.internship,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullTimeEmployment': fullTimeEmployment.toMap(),
      'internship': internship.toMap(),
    };
  }

  factory JobProfileDetails.fromMap(Map<String, dynamic> map) {
    return JobProfileDetails(
      fullTimeEmployment: FullTimeEmployment.fromMap(
          map['fullTimeEmployment'] as Map<String, dynamic>? ?? {}),
      internship:
          Internship.fromMap(map['internship'] as Map<String, dynamic>? ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory JobProfileDetails.fromJson(String source) =>
      JobProfileDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [fullTimeEmployment, internship];
}
