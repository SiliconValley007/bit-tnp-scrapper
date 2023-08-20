// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class Criteria extends Equatable {
  final String tenth;
  final String twelfth;
  final String otherCriteria;
  final String pg;
  final String ug;
  const Criteria({
    required this.tenth,
    required this.twelfth,
    required this.otherCriteria,
    required this.pg,
    required this.ug,
  });

  Criteria copyWith({
    String? tenth,
    String? twelfth,
    String? otherCriteria,
    String? pg,
    String? ug,
  }) {
    return Criteria(
      tenth: tenth ?? this.tenth,
      twelfth: twelfth ?? this.twelfth,
      otherCriteria: otherCriteria ?? this.otherCriteria,
      pg: pg ?? this.pg,
      ug: ug ?? this.ug,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '10th:': tenth,
      '12th:': twelfth,
      'Other Criteria:': otherCriteria,
      'PG:': pg,
      'UG:': ug,
    };
  }

  factory Criteria.fromMap(Map<String, dynamic> map) {
    return Criteria(
      tenth: map['10th:'] as String? ?? '',
      twelfth: map['12th:'] as String? ?? '',
      otherCriteria: map['Other Criteria:'] as String? ?? '',
      pg: map['PG:'] as String? ?? '',
      ug: map['UG:'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Criteria.fromJson(String source) => Criteria.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      tenth,
      twelfth,
      otherCriteria,
      pg,
      ug,
    ];
  }
}
