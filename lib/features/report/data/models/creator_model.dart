import '../../domain/entities/creator_entity.dart';

class CreatorModel extends CreatorEntity {
  CreatorModel({
    required super.id,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.fullName,
  });

  factory CreatorModel.fromJson(Map<String, dynamic> json) {
    return CreatorModel(
      id: json['_id'] as String? ?? '',
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      fullName: json['fullName'] as String? ?? '',
    );
  }
}
