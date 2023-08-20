// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'criteria.dart';

class Eligibility extends Equatable {
  final String additionalCriteria;
  final List<String> courses;
  final Criteria criteria;
  const Eligibility({
    required this.additionalCriteria,
    required this.courses,
    required this.criteria,
  });

  Eligibility copyWith({
    String? additionalCriteria,
    List<String>? courses,
    Criteria? criteria,
  }) {
    return Eligibility(
      additionalCriteria: additionalCriteria ?? this.additionalCriteria,
      courses: courses ?? this.courses,
      criteria: criteria ?? this.criteria,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'additionalCriteria': additionalCriteria,
      'courses': courses,
      'criteria': criteria.toMap(),
    };
  }

  factory Eligibility.fromMap(Map<String, dynamic> map) {
    return Eligibility(
      additionalCriteria: map['additionalCriteria'] as String,
      courses: List<String>.from((map['courses'] ?? [])),
      criteria: Criteria.fromMap(
          map['criteria'] as Map<String, dynamic>? ?? {}),
    );
  }

  String toJson() => json.encode(toMap());

  factory Eligibility.fromJson(String source) => Eligibility.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [additionalCriteria, courses, criteria,];
}
