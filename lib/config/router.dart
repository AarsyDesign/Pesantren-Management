import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/auth/pages/login_page.dart';
import 'package:pesantren_management/features/dashboard/pages/dashboard_page.dart';
import 'package:pesantren_management/features/master/pages/santri_list_page.dart';
import 'package:pesantren_management/features/master/pages/santri_form_page.dart';
import 'package:pesantren_management/features/master/pages/santri_detail_page.dart';

class RouteNames {
  static const login = 'login';
  static const dashboard = 'dashboard';
  static const santri = 'santri';
  static const santriNew = 'santri-new';
  static const santriDetail = 'santri-detail';
  static const santriEdit = 'santri-edit';
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
    GoRoute(
      path: '/santri',
      name: RouteNames.santri,
      builder: (context, _) => const SantriListPage(),
    ),
    GoRoute(
      path: '/santri/new',
      name: RouteNames.santriNew,
      builder: (context, _) => const SantriFormPage(),
    ),
    GoRoute(
      path: '/santri/:id',
      name: RouteNames.santriDetail,
      builder: (context, state) => SantriDetailPage(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/santri/:id/edit',
      name: RouteNames.santriEdit,
      builder: (context, state) => SantriFormPage(id: state.pathParameters['id']),
    ),
  ],
);