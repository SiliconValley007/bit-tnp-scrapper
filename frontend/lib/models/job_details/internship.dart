import 'dart:convert';

import 'package:equatable/equatable.dart';

class Internship extends Equatable {
  final String jobDescription;
  final String jobDesignation;
  final String placeOfPosting;
  final String jobDescriptionLink;
  final String type;
  const Internship({
    required this.jobDescription,
    required this.jobDesignation,
    required this.placeOfPosting,
    required this.jobDescriptionLink,
    required this.type,
  });

  Internship copyWith({
    String? jobDescription,
    String? jobDesignation,
    String? placeOfPosting,
    String? jobDescriptionLink,
    String? type,
  }) {
    return Internship(
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

  factory Internship.fromMap(Map<String, dynamic> map) {
    return Internship(
      jobDescription: map['Job Description'] as String? ?? '',
      jobDesignation: map['Job Designation'] as String? ?? '',
      placeOfPosting: map['Place of Posting'] as String? ?? '',
      jobDescriptionLink: map['jobDescriptionLink'] as String? ?? '',
      type: map['type'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Internship.fromJson(String source) => Internship.fromMap(json.decode(source) as Map<String, dynamic>);

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