import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../core/routes/app_router.dart';
import '../../../shared/services/auth_service.dart';
import '../../../shared/services/shopping_service.dart';
import '../../../shared/models/shopping_item.dart';
import '../../../shared/widgets/shopping_item_tile.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({super.key});

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  ItemFilter _currentFilter = ItemFilter.all;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final shoppingService = Provider.of<ShoppingService>(context);
    
    if (!authService.isAuthenticated || authService.currentUser == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final userId = authService.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Lista de Compras'),
        actions: [
          PopupMenuButton<ItemFilter>(
            icon: const Icon(Icons.filter_list),
            onSelected: (filter) {
              setState(() {
                _currentFilter = filter;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: ItemFilter.all,
                child: Text('Todos los artículos'),
              ),
              const PopupMenuItem(
                value: ItemFilter.pending,
                child: Text('Pendientes'),
              ),
              const PopupMenuItem(
                value: ItemFilter.purchased,
                child: Text('Comprados'),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.analytics_outlined),
            onPressed: () => context.push(AppRouter.analytics),
            tooltip: 'Ver análisis',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _handleLogout(context),
            tooltip: 'Cerrar sesión',
          ),
        ],
      ),
      body: Column(
        children: [
          // Indicador de filtro actual
          if (_currentFilter != ItemFilter.all)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
              child: Text(
                'Mostrando: ${_getFilterText(_currentFilter)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          
          // Lista de artículos
          Expanded(
            child: StreamBuilder<List<ShoppingItem>>(
              stream: shoppingService.getFilteredItemsStream(userId, _currentFilter),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: SpinKitFadingCube(
                      color: Theme.of(context).primaryColor,
                      size: 50.0,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Error al cargar la lista',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${snapshot.error}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {}); // Recargar
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }

                final items = snapshot.data ?? [];

                if (items.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _currentFilter == ItemFilter.all 
                              ? Icons.shopping_cart_outlined
                              : Icons.filter_list_off,
                          size: 120,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _getEmptyMessage(_currentFilter),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _getEmptySubtitle(_currentFilter),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return ShoppingItemTile(
                      item: item,
                      onTogglePurchased: () => _togglePurchased(item, shoppingService),
                      onEdit: () => _editItem(context, item),
                      onDelete: () => _deleteItem(item, shoppingService),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/home/add-item'),
        tooltip: 'Agregar artículo',
        child: const Icon(Icons.add),
      ),
    );
  }

  String _getFilterText(ItemFilter filter) {
    switch (filter) {
      case ItemFilter.all:
        return 'Todos los artículos';
      case ItemFilter.pending:
        return 'Artículos pendientes';
      case ItemFilter.purchased:
        return 'Artículos comprados';
    }
  }

  String _getEmptyMessage(ItemFilter filter) {
    switch (filter) {
      case ItemFilter.all:
        return '¡Tu lista está vacía!';
      case ItemFilter.pending:
        return '¡No hay artículos pendientes!';
      case ItemFilter.purchased:
        return '¡No hay artículos comprados!';
    }
  }

  String _getEmptySubtitle(ItemFilter filter) {
    switch (filter) {
      case ItemFilter.all:
        return 'Agrega tu primer artículo para comenzar';
      case ItemFilter.pending:
        return 'Todos los artículos están comprados';
      case ItemFilter.purchased:
        return 'Aún no has comprado ningún artículo';
    }
  }

  Future<void> _togglePurchased(ShoppingItem item, ShoppingService service) async {
    try {
      await service.togglePurchased(item.userId, item.id, !item.purchased);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar artículo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _editItem(BuildContext context, ShoppingItem item) {
    // TODO: Implementar pantalla de edición
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Función de edición próximamente'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  Future<void> _deleteItem(ShoppingItem item, ShoppingService service) async {
    try {
      await service.deleteItem(item.userId, item.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Artículo "${item.name}" eliminado'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al eliminar artículo: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _handleLogout(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cerrar sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await authService.signOut();
                if (context.mounted) {
                  context.go(AppRouter.welcome);
                }
              },
              child: const Text('Cerrar sesión'),
            ),
          ],
        );
      },
    );
  }
} 