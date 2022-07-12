// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:daily_practices_api/models/json_map.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'daily_practice.g.dart';

@immutable
@JsonSerializable()
class DailyPractice extends Equatable {
  final int id;
  final String practice;

  const DailyPractice({
    required this.id,
    required this.practice,
  });

  @override
  List<Object?> get props => [id, practice];

  static DailyPractice fromJson(JsonMap json) => _$DailyPracticeFromJson(json);

  JsonMap toJson() => _$DailyPracticeToJson(this);

  DailyPractice copyWith({
    int? id,
    String? practice,
  }) {
    return DailyPractice(
      id: id ?? this.id,
      practice: practice ?? this.practice,
    );
  }
}
