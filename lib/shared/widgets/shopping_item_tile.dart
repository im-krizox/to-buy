import 'package:flutter/material.dart';
import '../models/shopping_item.dart';

class ShoppingItemTile extends StatelessWidget {
  final ShoppingItem item;
  final VoidCallback? onTogglePurchased;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ShoppingItemTile({
    super.key,
    required this.item,
    this.onTogglePurchased,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 32,
        ),
      ),
      confirmDismiss: (direction) async {
        return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Eliminar artículo'),
              content: Text('¿Estás seguro de que quieres eliminar "${item.name}"?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Eliminar'),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) {
        onDelete?.call();
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: ListTile(
          leading: GestureDetector(
            onTap: onTogglePurchased,
            child: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: item.purchased 
                      ? Theme.of(context).primaryColor 
                      : Colors.grey,
                  width: 2,
                ),
                color: item.purchased 
                    ? Theme.of(context).primaryColor 
                    : Colors.transparent,
              ),
              child: item.purchased
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 16,
                    )
                  : null,
            ),
          ),
          title: Text(
            item.name,
            style: TextStyle(
              decoration: item.purchased 
                  ? TextDecoration.lineThrough 
                  : TextDecoration.none,
              color: item.purchased 
                  ? Colors.grey 
                  : Theme.of(context).textTheme.bodyLarge?.color,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                _getCategoryIcon(item.category),
                size: 16,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                item.category,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• Cantidad: ${item.quantity}',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit, size: 20),
                onPressed: onEdit,
                tooltip: 'Editar',
              ),
              IconButton(
                icon: const Icon(Icons.delete, size: 20),
                onPressed: () => _showDeleteDialog(context),
                tooltip: 'Eliminar',
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Frutas y Verduras':
        return Icons.local_florist;
      case 'Carnes y Pescados':
        return Icons.set_meal;
      case 'Lácteos':
        return Icons.local_drink;
      case 'Panadería':
        return Icons.bakery_dining;
      case 'Bebidas':
        return Icons.local_bar;
      case 'Limpieza':
        return Icons.cleaning_services;
      case 'Higiene Personal':
        return Icons.face_retouching_natural;
      default:
        return Icons.shopping_basket;
    }
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar artículo'),
          content: Text('¿Estás seguro de que quieres eliminar "${item.name}"?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onDelete?.call();
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
} 