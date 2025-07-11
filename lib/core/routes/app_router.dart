import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../features/auth/screens/welcome_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/register_screen.dart';
import '../../features/shopping_list/screens/shopping_list_screen.dart';
import '../../features/shopping_list/screens/add_item_screen.dart';
import '../../features/analytics/screens/analytics_screen.dart';

class AppRouter {
  static const String welcome = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String addItem = '/add-item';
  static const String analytics = '/analytics';
  
  static final GoRouter router = GoRouter(
    initialLocation: welcome,
    routes: [
      // Pantalla de bienvenida
      GoRoute(
        path: welcome,
        name: 'welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      
      // Pantallas de autenticación
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // Pantalla principal (Lista de compras)
      GoRoute(
        path: home,
        name: 'home',
        builder: (context, state) => const ShoppingListScreen(),
        routes: [
          GoRoute(
            path: 'add-item',
            name: 'add-item',
            builder: (context, state) => const AddItemScreen(),
          ),
        ],
      ),
      
      // Pantalla de analíticas
      GoRoute(
        path: analytics,
        name: 'analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
    ],
    
    // Redirección basada en autenticación
    redirect: (context, state) {
      final user = FirebaseAuth.instance.currentUser;
      final isAuthenticated = user != null;
      
      // Rutas que requieren autenticación
      final protectedRoutes = [home, analytics];
      final isGoingToProtectedRoute = protectedRoutes.any((route) => 
        state.fullPath?.startsWith(route) == true);
      
      // Rutas de autenticación (solo para usuarios no autenticados)
      final authRoutes = [welcome, login, register];
      final isGoingToAuthRoute = authRoutes.contains(state.fullPath);
      
      // Si no está autenticado y trata de ir a una ruta protegida
      if (!isAuthenticated && isGoingToProtectedRoute) {
        return welcome;
      }
      
      // Si está autenticado y trata de ir a una ruta de auth
      if (isAuthenticated && isGoingToAuthRoute) {
        return home;
      }
      
      // No redireccionar
      return null;
    },
    
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Página no encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.go(welcome),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    ),
  );
} 