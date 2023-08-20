// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class CompanyDetails extends Equatable {
  final String description;
  final String url;
  const CompanyDetails({
    required this.description,
    required this.url,
  });

  CompanyDetails copyWith({
    String? description,
    String? url,
  }) {
    return CompanyDetails(
      description: description ?? this.description,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'description': description,
      'url': url,
    };
  }

  factory CompanyDetails.fromMap(Map<String, dynamic> map) {
    return CompanyDetails(
      description: map['description'] as String? ?? '',
      url: map['url'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyDetails.fromJson(String source) => CompanyDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [description, url];
}
