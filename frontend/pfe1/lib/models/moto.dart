// lib/models/moto.dart
import 'dart:convert';
import 'model_moto.dart';

class Moto {
  final int id;
  final int modelId;
  final int? clientId;
  final String? image;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ModelMoto? model; // Relation avec le modèle

  Moto({
    required this.id,
    required this.modelId,
    this.clientId,
    this.image,
    required this.createdAt,
    required this.updatedAt,
    this.model,
  });

  factory Moto.fromJson(Map<String, dynamic> json) {
    return Moto(
      id: json['id'],
      modelId: json['model_id'],
      clientId: json['client_id'],
      image: json['image'],
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : DateTime.now(),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at']) 
          : DateTime.now(),
      model: json['model'] != null ? ModelMoto.fromJson(json['model']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'model_id': modelId,
      'client_id': clientId,
      'image': image,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'model': model?.toJson(),
    };
  }
  
  factory Moto.fromJsonString(String jsonString) {
    return Moto.fromJson(json.decode(jsonString));
  }
}