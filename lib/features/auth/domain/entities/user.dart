import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String? email;
  final String? username;
  final String? gender;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final String? provider;
  final String? phoneNumber;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const UserEntity({
    required this.id,
    this.email,
    this.username,
    this.gender,
    this.provider,
    this.dateOfBirth,
    this.avatarUrl,
    this.phoneNumber,
    this.createdAt,
    this.updatedAt,
  });

  static const empty = UserEntity(id: '');

  bool get isLoggedIn => this != empty;

  UserEntity copyWith({
    String? id,
    String? email,
    String? username,
    String? gender,
    DateTime? dateOfBirth,
    String? avatarUrl,
    String? phoneNumber,
    String? provider,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserEntity(
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

  @override
  List<Object?> get props => [
        id,
        email,
        username,
        gender,
        avatarUrl,
        dateOfBirth,
        phoneNumber,
        provider,
        createdAt,
        updatedAt
      ];

  static const String idFieldName = 'id';
  static const String emailFieldName = 'email';
  static const String usernameFieldName = 'username';
  static const String genderFieldName = 'gender';
  static const String dateOfBirthFieldName = 'dateOfBirth';
  static const String providerFieldName = 'provider';
  static const String avatarUrlFieldName = 'avatarUrl';
  static const String phoneNumberFieldName = 'phoneNumber';
  static const String createdAtFieldName = 'createdAt';
  static const String updatedAtFieldName = 'updatedAt';
}
