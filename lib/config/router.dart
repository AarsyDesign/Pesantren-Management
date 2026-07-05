import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/auth/pages/login_page.dart';
import 'package:pesantren_management/features/dashboard/pages/dashboard_page.dart';

class RouteNames {
  static const login = 'login';
  static const dashboard = 'dashboard';
  static const billing = 'billing';
  static const payment = 'payment';
  static const cashbook = 'cashbook';
}

final goRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/login',
      name: RouteNames.login,
      builder: (context, _) => const LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      name: RouteNames.dashboard,
      builder: (context, _) => const DashboardPage(),
    ),
  ],
);
