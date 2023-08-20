// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class FullTimeEmployment extends Equatable {
  final String jobDescription;
  final String jobDesignation;
  final String placeOfPosting;
  final String jobDescriptionLink;
  final String type;
  const FullTimeEmployment({
    required this.jobDescription,
    required this.jobDesignation,
    required this.placeOfPosting,
    required this.jobDescriptionLink,
    required this.type,
  });

  FullTimeEmployment copyWith({
    String? jobDescription,
    String? jobDesignation,
    String? placeOfPosting,
    String? jobDescriptionLink,
    String? type,
  }) {
    return FullTimeEmployment(
      jobDescription: jobDescription ?? this.jobDescription,
      jobDesignation: jobDesignation ?? this.jobDesignation,
      placeOfPosting: placeOfPosting ?? this.placeOfPosting,
      jobDescriptionLink: jobDescriptionLink ?? this.jobDescriptionLink,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Job Description': jobDescription,
      'Job Designation': jobDesignation,
      'Place of Posting': placeOfPosting,
      'jobDescriptionLink': jobDescriptionLink,
      'type': type,
    };
  }

  factory FullTimeEmployment.fromMap(Map<String, dynamic> map) {
    return FullTimeEmployment(
      jobDescription: map['Job Description'] as String? ?? '',
      jobDesignation: map['Job Designation'] as String? ?? '',
      placeOfPosting: map['Place of Posting'] as String? ?? '',
      jobDescriptionLink: map['jobDescriptionLink'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FullTimeEmployment.fromJson(String source) => FullTimeEmployment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      jobDescription,
      jobDesignation,
      placeOfPosting,
      jobDescriptionLink,
      type,
    ];
  }
}
