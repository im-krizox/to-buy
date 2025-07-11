import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/app_router.dart';
import '../../../shared/services/auth_service.dart';
import '../../../shared/widgets/social_auth_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo y título
              const Icon(
                Icons.shopping_cart_rounded,
                size: 120,
                color: Color(0xFF6366F1),
              ),
              const SizedBox(height: 24),
              Text(
                'ToBuy',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF6366F1),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Tu lista de compras inteligente',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Botones de autenticación social
              Consumer<AuthService>(
                builder: (context, authService, _) {
                  return Column(
                    children: [
                      SocialAuthButton(
                        text: 'Continuar con Google',
                        icon: Icons.g_mobiledata_rounded,
                        backgroundColor: Colors.white,
                        textColor: Colors.black87,
                        borderColor: Colors.grey[300],
                        onPressed: () => _signInWithGoogle(context, authService),
                      ),
                      const SizedBox(height: 16),
                      SocialAuthButton(
                        text: 'Continuar con Apple',
                        icon: Icons.apple,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        onPressed: () => _signInWithApple(context, authService),
                      ),
                      const SizedBox(height: 16),
                      SocialAuthButton(
                        text: 'Continuar con Facebook',
                        icon: Icons.facebook,
                        backgroundColor: const Color(0xFF1877F2),
                        textColor: Colors.white,
                        onPressed: () => _signInWithFacebook(context, authService),
                      ),
                    ],
                  );
                },
              ),
              
              const SizedBox(height: 32),
              
              // Divisor
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey[300]),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'o',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey[300]),
                  ),
                ],
              ),
              
              const SizedBox(height: 32),
              
              // Botones de email
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => context.push(AppRouter.login),
                  child: const Text('Iniciar sesión con email'),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => context.push(AppRouter.register),
                  child: const Text('Crear cuenta'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> _signInWithGoogle(BuildContext context, AuthService authService) async {
    try {
      await authService.signInWithGoogle();
      if (context.mounted && authService.isAuthenticated) {
        context.go(AppRouter.home);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $e')),
        );
      }
    }
  }
  
  Future<void> _signInWithApple(BuildContext context, AuthService authService) async {
    try {
      await authService.signInWithApple();
      if (context.mounted && authService.isAuthenticated) {
        context.go(AppRouter.home);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $e')),
        );
      }
    }
  }
  
  Future<void> _signInWithFacebook(BuildContext context, AuthService authService) async {
    try {
      await authService.signInWithFacebook();
      if (context.mounted && authService.isAuthenticated) {
        context.go(AppRouter.home);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al iniciar sesión: $e')),
        );
      }
    }
  }
} 