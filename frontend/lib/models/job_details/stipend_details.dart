// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class StipendDetails extends Equatable {
  final String pg;
  final String pgBenefits;
  final String ug;
  final String ugBenefits;
  const StipendDetails({
    required this.pg,
    required this.pgBenefits,
    required this.ug,
    required this.ugBenefits,
  });

  StipendDetails copyWith({
    String? pg,
    String? pgBenefits,
    String? ug,
    String? ugBenefits,
  }) {
    return StipendDetails(
      pg: pg ?? this.pg,
      pgBenefits: pgBenefits ?? this.pgBenefits,
      ug: ug ?? this.ug,
      ugBenefits: ugBenefits ?? this.ugBenefits,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pg': pg,
      'pgBenefits': pgBenefits,
      'ug': ug,
      'ugBenefits': ugBenefits,
    };
  }

  factory StipendDetails.fromMap(Map<String, dynamic> map) {
    return StipendDetails(
      pg: map['pg'] as String? ?? '',
      pgBenefits: map['pgBenefits'] as String? ?? '',
      ug: map['ug'] as String? ?? '',
      ugBenefits: map['ugBenefits'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StipendDetails.fromJson(String source) => StipendDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [pg, pgBenefits, ug, ugBenefits];
}
