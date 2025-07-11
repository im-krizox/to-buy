import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingItem {
  final String id;
  final String name;
  final int quantity;
  final String category;
  final bool purchased;
  final DateTime timestamp;
  final String userId;

  ShoppingItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
    required this.purchased,
    required this.timestamp,
    required this.userId,
  });

  // Constructor para crear un nuevo item (sin ID)
  ShoppingItem.create({
    required this.name,
    required this.quantity,
    required this.category,
    required this.userId,
    this.purchased = false,
    DateTime? timestamp,
  })  : id = '',
        timestamp = timestamp ?? DateTime.now();

  // Conversión desde Map (Firestore)
  factory ShoppingItem.fromMap(Map<String, dynamic> map, String id) {
    return ShoppingItem(
      id: id,
      name: map['name'] ?? '',
      quantity: map['quantity'] ?? 1,
      category: map['category'] ?? 'Otros',
      purchased: map['purchased'] ?? false,
      timestamp: (map['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      userId: map['userId'] ?? '',
    );
  }

  // Conversión a Map (para Firestore)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'category': category,
      'purchased': purchased,
      'timestamp': Timestamp.fromDate(timestamp),
      'userId': userId,
    };
  }

  // Crear copia con cambios
  ShoppingItem copyWith({
    String? id,
    String? name,
    int? quantity,
    String? category,
    bool? purchased,
    DateTime? timestamp,
    String? userId,
  }) {
    return ShoppingItem(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      purchased: purchased ?? this.purchased,
      timestamp: timestamp ?? this.timestamp,
      userId: userId ?? this.userId,
    );
  }

  @override
  String toString() {
    return 'ShoppingItem(id: $id, name: $name, quantity: $quantity, category: $category, purchased: $purchased)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ShoppingItem &&
        other.id == id &&
        other.name == name &&
        other.quantity == quantity &&
        other.category == category &&
        other.purchased == purchased &&
        other.timestamp == timestamp &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        category.hashCode ^
        purchased.hashCode ^
        timestamp.hashCode ^
        userId.hashCode;
  }
} 