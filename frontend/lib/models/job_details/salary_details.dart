// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class SalaryDetails extends Equatable {
  final List<String> allowance;
  final List<String> basicPay;
  final List<String> ctc;
  final List<String> esop;
  final List<String> joiningBonus;
  final List<String> otherBenefits;
  final List<String> programmes;
  final List<String> rsu;
  const SalaryDetails({
    required this.allowance,
    required this.basicPay,
    required this.ctc,
    required this.esop,
    required this.joiningBonus,
    required this.otherBenefits,
    required this.programmes,
    required this.rsu,
  });

  SalaryDetails copyWith({
    List<String>? allowance,
    List<String>? basicPay,
    List<String>? ctc,
    List<String>? esop,
    List<String>? joiningBonus,
    List<String>? otherBenefits,
    List<String>? programmes,
    List<String>? rsu,
  }) {
    return SalaryDetails(
      allowance: allowance ?? this.allowance,
      basicPay: basicPay ?? this.basicPay,
      ctc: ctc ?? this.ctc,
      esop: esop ?? this.esop,
      joiningBonus: joiningBonus ?? this.joiningBonus,
      otherBenefits: otherBenefits ?? this.otherBenefits,
      programmes: programmes ?? this.programmes,
      rsu: rsu ?? this.rsu,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'Allowance/s': allowance,
      'Basic Pay': basicPay,
      'CTC': ctc,
      'ESOP': esop,
      'Joining/Rention Bonus': joiningBonus,
      'Other Benefits': otherBenefits,
      'Programmes': programmes,
      'RSU': rsu,
    };
  }

  factory SalaryDetails.fromMap(Map<String, dynamic> map) {
    return SalaryDetails(
      allowance: List<String>.from((map['Allowance/s'] ?? ['', ''])),
      basicPay: List<String>.from((map['Basic Pay'] ?? ['', ''])),
      ctc: List<String>.from((map['CTC'] ?? ['', ''])),
      esop: List<String>.from((map['ESOP'] ?? ['', ''])),
      joiningBonus: List<String>.from((map['Joining/Rention Bonus'] ?? ['', ''])),
      otherBenefits: List<String>.from((map['Other Benefits'] ?? ['', ''])),
      programmes: List<String>.from((map['Programmes'] ?? ['', ''])),
      rsu: List<String>.from((map['RSU'] ?? ['', ''])),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalaryDetails.fromJson(String source) => SalaryDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      allowance,
      basicPay,
      ctc,
      esop,
      joiningBonus,
      otherBenefits,
      programmes,
      rsu,
    ];
  }
}
