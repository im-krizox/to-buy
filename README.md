# 🛒 ToBuy - Lista de Compras Inteligente

Una aplicación móvil desarrollada en Flutter con Firebase que permite a los usuarios gestionar sus listas de compras de manera inteligente y eficiente.

## 🚀 Estado del Proyecto

### ✅ Funcionalidades Implementadas

#### **Fase 1: Configuración Inicial** ✅
- ✅ Proyecto Flutter configurado
- ✅ Dependencias Firebase instaladas
- ✅ Estructura de carpetas organizada
- ✅ Configuración de Firebase
- ✅ Navegación con GoRouter
- ✅ Tema moderno y atractivo

#### **Fase 2: Autenticación** ✅
- ✅ Pantalla de bienvenida
- ✅ Registro con email/contraseña
- ✅ Inicio de sesión con email/contraseña
- ✅ Autenticación con Google
- ✅ Autenticación con Facebook
- ✅ Autenticación con Apple
- ✅ Recuperación de contraseña
- ✅ Gestión de sesiones
- ✅ Protección de rutas

#### **Fase 3: Lista de Compras CRUD** ✅
- ✅ Modelo `ShoppingItem` completo
- ✅ Servicio de Firestore para CRUD
- ✅ Lista en tiempo real con StreamBuilder
- ✅ Agregar nuevos artículos
- ✅ Marcar como comprado/pendiente
- ✅ Eliminar artículos (swipe to delete)
- ✅ Filtros (Todos/Pendientes/Comprados)
- ✅ Categorización de productos
- ✅ Interfaz intuitiva y moderna

#### **Fase 5: Analytics Dashboard** ✅
- ✅ Estadísticas generales
- ✅ Gráfico de progreso (Pie Chart)
- ✅ Distribución por categorías
- ✅ Datos en tiempo real

### 🔄 Próximas Funcionalidades

#### **Fase 4: Categorización con IA** (Pendiente)
- [ ] API para categorización automática
- [ ] Integración con formulario de agregar

#### **Fase 6: Pulido y Deployment** (Pendiente)
- [ ] Testing completo
- [ ] Pantalla de edición de artículos
- [ ] Iconos y splash screen personalizados
- [ ] Build para producción

## 🏗️ Arquitectura

### Estructura del Proyecto
```
lib/
├── main.dart                 # Punto de entrada
├── app.dart                 # Configuración principal
├── config/
│   └── firebase_config.dart # Configuración Firebase
├── core/
│   ├── theme/
│   │   └── app_theme.dart   # Tema de la aplicación
│   └── routes/
│       └── app_router.dart  # Navegación
├── features/
│   ├── auth/
│   │   └── screens/         # Pantallas de autenticación
│   ├── shopping_list/
│   │   └── screens/         # Lista de compras
│   └── analytics/
│       └── screens/         # Dashboard analítico
├── shared/
│   ├── models/
│   │   └── shopping_item.dart # Modelo de datos
│   ├── services/
│   │   ├── auth_service.dart  # Servicio autenticación
│   │   └── shopping_service.dart # Servicio CRUD
│   └── widgets/             # Componentes reutilizables
└── utils/                   # Utilidades
```

### Tecnologías Utilizadas

- **Flutter 3.32.6** - Framework de desarrollo
- **Dart 3.8.1** - Lenguaje de programación
- **Firebase Auth** - Autenticación
- **Cloud Firestore** - Base de datos NoSQL
- **Provider** - Gestión de estado
- **GoRouter** - Navegación
- **FL Chart** - Gráficos y visualizaciones
- **Material Design 3** - Sistema de diseño

## 🎨 Características de UI/UX

### Tema Visual
- **Colores principales**: Indigo (#6366F1) y Emerald (#10B981)
- **Soporte**: Modo claro y oscuro
- **Diseño**: Material Design 3
- **Tipografía**: Consistente y legible

### Componentes Destacados
- **Botones de autenticación social** personalizados
- **Lista de artículos** con gestos intuitivos
- **Gráficos interactivos** para análisis
- **Filtros dinámicos** para organización
- **Loading states** con animaciones

## 🔥 Funcionalidades Destacadas

### Gestión de Lista de Compras
- **Tiempo real**: Los cambios se sincronizan instantáneamente
- **Filtros inteligentes**: Ver todos, pendientes o comprados
- **Categorización**: 8 categorías predefinidas con iconos
- **Interacciones**: Swipe para eliminar, tap para marcar

### Analytics Dashboard
- **Estadísticas generales**: Total, comprados, pendientes
- **Gráfico de progreso**: Visualización circular del progreso
- **Distribución por categorías**: Barras de progreso con porcentajes

### Autenticación Completa
- **Múltiples proveedores**: Email, Google, Facebook, Apple
- **Seguridad**: Protección de rutas y gestión de sesiones
- **UX**: Validación de formularios y manejo de errores

## 🚀 Cómo Ejecutar

### Requisitos Previos
1. Flutter SDK (3.32.6 o superior)
2. Dart SDK (3.8.1 o superior)
3. Proyecto Firebase configurado
4. Android Studio / VS Code
5. Dispositivo/emulador para testing

### Configuración
1. **Clonar el repositorio**
   ```bash
   git clone <repository-url>
   cd to-buy
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Configurar Firebase**
   - Crear proyecto en Firebase Console
   - Habilitar Authentication (Email, Google, Facebook, Apple)
   - Crear base de datos Firestore
   - Actualizar `lib/config/firebase_config.dart` con tus credenciales

4. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

## 📱 Screenshots

### Pantalla de Bienvenida
- Diseño moderno con opciones de autenticación
- Soporte para múltiples proveedores

### Lista de Compras
- Vista en tiempo real de artículos
- Filtros por estado
- Gestos intuitivos

### Analytics Dashboard
- Gráficos interactivos
- Estadísticas detalladas
- Distribución por categorías

## 🧪 Testing

```bash
# Ejecutar tests
flutter test

# Analizar código
flutter analyze
```

## 📦 Dependencias Principales

```yaml
dependencies:
  firebase_core: ^2.24.2
  firebase_auth: ^4.16.0
  cloud_firestore: ^4.14.0
  provider: ^6.1.1
  go_router: ^12.1.3
  fl_chart: ^0.66.2
  flutter_spinkit: ^5.2.0
  google_sign_in: ^6.1.6
  flutter_facebook_auth: ^6.0.4
  sign_in_with_apple: ^5.0.0
  flutter_secure_storage: ^9.0.0
```

## 👥 Contribución

Este proyecto sigue las mejores prácticas de desarrollo Flutter:

- **Arquitectura limpia** con separación de responsabilidades
- **Código bien documentado** y comentado
- **Gestión de estado** con Provider
- **Manejo de errores** robusto
- **UI responsiva** y accesible

## 📄 Licencia

Este proyecto está desarrollado como parte de un ejercicio de desarrollo de aplicaciones móviles con Flutter y Firebase.

---

**Desarrollado con ❤️ usando Flutter**
