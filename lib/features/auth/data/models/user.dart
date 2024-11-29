import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user.dart';

part 'user.g.dart';

@JsonSerializable()
class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    super.email,
    super.username,
    super.gender,
    super.avatarUrl,
    super.provider,
    super.phoneNumber,
    super.dateOfBirth,
    super.createdAt,
    super.updatedAt,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
      username: username,
      gender: gender,
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
      provider: provider,
      createdAt: createdAt,
      dateOfBirth: dateOfBirth,
      updatedAt: updatedAt,
    );
  }

  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? username,
    DateTime? dateOfBirth,
    String? gender,
    String? avatarUrl,
    String? provider,
    String? phoneNumber,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      email: entity.email,
      username: entity.username,
      gender: entity.gender,
      avatarUrl: entity.avatarUrl,
      phoneNumber: entity.phoneNumber,
      provider: entity.provider,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      dateOfBirth: entity.dateOfBirth,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
