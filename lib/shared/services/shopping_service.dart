import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/shopping_item.dart';

class ShoppingService extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Obtener referencia a la colección de items del usuario
  CollectionReference _getItemsCollection(String userId) {
    return _firestore.collection('users').doc(userId).collection('items');
  }
  
  // Agregar nuevo item
  Future<void> addItem(ShoppingItem item) async {
    try {
      await _getItemsCollection(item.userId).add(item.toMap());
      debugPrint('Item agregado: ${item.name}');
    } catch (e) {
      debugPrint('Error al agregar item: $e');
      rethrow;
    }
  }
  
  // Actualizar item existente
  Future<void> updateItem(ShoppingItem item) async {
    try {
      await _getItemsCollection(item.userId)
          .doc(item.id)
          .update(item.toMap());
      debugPrint('Item actualizado: ${item.name}');
    } catch (e) {
      debugPrint('Error al actualizar item: $e');
      rethrow;
    }
  }
  
  // Eliminar item
  Future<void> deleteItem(String userId, String itemId) async {
    try {
      await _getItemsCollection(userId).doc(itemId).delete();
      debugPrint('Item eliminado con ID: $itemId');
    } catch (e) {
      debugPrint('Error al eliminar item: $e');
      rethrow;
    }
  }
  
  // Marcar item como comprado/no comprado
  Future<void> togglePurchased(String userId, String itemId, bool purchased) async {
    try {
      await _getItemsCollection(userId).doc(itemId).update({
        'purchased': purchased,
      });
      debugPrint('Item marcado como ${purchased ? "comprado" : "pendiente"}');
    } catch (e) {
      debugPrint('Error al cambiar estado del item: $e');
      rethrow;
    }
  }
  
  // Obtener stream de todos los items del usuario
  Stream<List<ShoppingItem>> getItemsStream(String userId) {
    return _getItemsCollection(userId)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ShoppingItem.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }
  
  // Obtener items filtrados por estado (comprados/pendientes)
  Stream<List<ShoppingItem>> getFilteredItemsStream(
    String userId,
    ItemFilter filter,
  ) {
    Query query = _getItemsCollection(userId).orderBy('timestamp', descending: true);
    
    switch (filter) {
      case ItemFilter.purchased:
        query = query.where('purchased', isEqualTo: true);
        break;
      case ItemFilter.pending:
        query = query.where('purchased', isEqualTo: false);
        break;
      case ItemFilter.all:
        // No filtro adicional
        break;
    }
    
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ShoppingItem.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }
  
  // Obtener items por categoría
  Stream<List<ShoppingItem>> getItemsByCategory(
    String userId,
    String category,
  ) {
    return _getItemsCollection(userId)
        .where('category', isEqualTo: category)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return ShoppingItem.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
    });
  }
  
  // Obtener estadísticas básicas
  Future<ShoppingStats> getStats(String userId) async {
    try {
      final snapshot = await _getItemsCollection(userId).get();
      final items = snapshot.docs.map((doc) {
        return ShoppingItem.fromMap(
          doc.data() as Map<String, dynamic>,
          doc.id,
        );
      }).toList();
      
      final totalItems = items.length;
      final purchasedItems = items.where((item) => item.purchased).length;
      final pendingItems = totalItems - purchasedItems;
      
      // Contar por categorías
      final Map<String, int> categoryCounts = {};
      for (final item in items) {
        categoryCounts[item.category] = (categoryCounts[item.category] ?? 0) + 1;
      }
      
      return ShoppingStats(
        totalItems: totalItems,
        purchasedItems: purchasedItems,
        pendingItems: pendingItems,
        categoryCounts: categoryCounts,
      );
    } catch (e) {
      debugPrint('Error al obtener estadísticas: $e');
      rethrow;
    }
  }
}

// Enum para filtros
enum ItemFilter { all, purchased, pending }

// Clase para estadísticas
class ShoppingStats {
  final int totalItems;
  final int purchasedItems;
  final int pendingItems;
  final Map<String, int> categoryCounts;
  
  ShoppingStats({
    required this.totalItems,
    required this.purchasedItems,
    required this.pendingItems,
    required this.categoryCounts,
  });
} 