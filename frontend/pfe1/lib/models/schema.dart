// lib/models/schema.dart
import 'dart:convert';
import 'moto.dart';

class Schema {
  final int id;
  final String nom;
  final int? parentId;
  final String version;
  final double price;
  final int? motoId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Moto? moto; // Relation avec la moto
  final Schema? parent; // Relation auto-référentielle

  Schema({
    required this.id,
    required this.nom,
    this.parentId,
    required this.version,
    required this.price,
    this.motoId,
    this.createdAt,
    this.updatedAt,
    this.moto,
    this.parent,
  });

  factory Schema.fromJson(Map<String, dynamic> json) {
  // Assure une conversion correcte du prix de String en double
  double parsePrice(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      try {
        return double.parse(value);
      } catch (e) {
        print("Erreur lors de la conversion du prix: $e");
        return 0.0;
      }
    }
    return 0.0;
  }

  return Schema(
    id: json['id'],
    nom: json['nom'] ?? 'Sans nom',
    parentId: json['parent_id'],
    version: json['version'] ?? '1.0',
    price: parsePrice(json['price']),
    motoId: json['moto_id'],
    createdAt: json['created_at'] != null 
        ? DateTime.parse(json['created_at']) 
        : null,
    updatedAt: json['updated_at'] != null 
        ? DateTime.parse(json['updated_at']) 
        : null,
    moto: json['moto'] != null ? Moto.fromJson(json['moto']) : null,
    parent: json['parent'] != null ? Schema.fromJson(json['parent']) : null,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'parent_id': parentId,
      'version': version,
      'price': price,
      'moto_id': motoId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'moto': moto?.toJson(),
      'parent': parent?.toJson(),
    };
  }
  
  static int min(int a, int b) {
    return (a < b) ? a : b;
  }
}