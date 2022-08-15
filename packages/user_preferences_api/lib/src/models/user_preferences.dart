import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:user_preferences_api/src/models/json_map.dart';

part 'user_preferences.g.dart';

@immutable
@JsonSerializable()
class UserPreferences extends Equatable {
  final DateTime lastUpdated;
  final int activePractice;

  const UserPreferences(
      {required this.lastUpdated, required this.activePractice});

  @override
  List<Object?> get props => [lastUpdated, activePractice];

  static UserPreferences fromJson(JsonMap json) =>
      _$UserPreferencesFromJson(json);

  JsonMap toJson() => _$UserPreferencesToJson(this);

  UserPreferences copyWith({
    DateTime? lastUpdated,
    int? activePractice,
  }) {
    return UserPreferences(
      lastUpdated: lastUpdated ?? this.lastUpdated,
      activePractice: activePractice ?? this.activePractice,
    );
  }
}
