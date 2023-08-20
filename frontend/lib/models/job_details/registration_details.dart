// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegistrationDetails extends Equatable {
  final String endsOn;
  final String startsFrom;
  const RegistrationDetails({
    required this.endsOn,
    required this.startsFrom,
  });

  RegistrationDetails copyWith({
    String? endsOn,
    String? startsFrom,
  }) {
    return RegistrationDetails(
      endsOn: endsOn ?? this.endsOn,
      startsFrom: startsFrom ?? this.startsFrom,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'endsOn': endsOn,
      'startsFrom': startsFrom,
    };
  }

  factory RegistrationDetails.fromMap(Map<String, dynamic> map) {
    return RegistrationDetails(
      endsOn: map['endsOn'] as String? ?? '',
      startsFrom: map['startsFrom'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RegistrationDetails.fromJson(String source) => RegistrationDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [endsOn, startsFrom];
}
