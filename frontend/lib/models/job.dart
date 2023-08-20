// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final String id;
  final String company;
  final String deadLine;
  final String postedOn;
  final String updates;
  final String viewAndApply;
  final Set<String> courses;

  const Job({
    required this.id,
    required this.company,
    required this.deadLine,
    required this.postedOn,
    required this.updates,
    required this.viewAndApply,
    required this.courses,
  });

  Job copyWith({
    String? id,
    String? company,
    String? deadLine,
    String? postedOn,
    String? updates,
    String? viewAndApply,
    Set<String>? courses,
  }) {
    return Job(
      id: id ?? this.id,
      company: company ?? this.company,
      deadLine: deadLine ?? this.deadLine,
      postedOn: postedOn ?? this.postedOn,
      updates: updates ?? this.updates,
      viewAndApply: viewAndApply ?? this.viewAndApply,
      courses: courses ?? this.courses,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'company': company,
      'deadLine': deadLine,
      'postedOn': postedOn,
      'updates': updates,
      'viewAndApply': viewAndApply,
      'courses': courses.toList(),
    };
  }

  factory Job.fromMap(Map<String, dynamic> map, {String id = ""}) {
    return Job(
      id: id,
      company: map['company'] as String? ?? '',
      deadLine: map['deadLine'] as String? ?? '',
      postedOn: map['postedOn'] as String? ?? '',
      updates: map['updates'] as String? ?? '',
      viewAndApply: map['viewAndApply'] as String? ?? '',
      courses: List<String>.from((map['courses'] ?? [])).toSet(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Job.fromJson(String source) =>
      Job.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Job(company: $company, deadLine: $deadLine, postedOn: $postedOn, updates: $updates, viewAndApply: $viewAndApply, courses: $courses)';
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      company,
      deadLine,
      postedOn,
      updates,
      viewAndApply,
      courses,
    ];
  }
}
