import 'package:go_router/go_router.dart';
import 'package:pesantren_management/features/auth/pages/login_page.dart';
import 'package:pesantren_management/features/dashboard/pages/dashboard_page.dart';
import 'package:pesantren_management/features/master/pages/santri_list_page.dart';
import 'package:pesantren_management/features/master/pages/santri_form_page.dart';
import 'package:pesantren_management/features/master/pages/santri_detail_page.dart';
import 'package:pesantren_management/features/master/pages/tahun_ajaran_list_page.dart';
import 'package:pesantren_management/features/master/pages/tahun_ajaran_form_page.dart';
import 'package:pesantren_management/features/master/pages/kelas_list_page.dart';
import 'package:pesantren_management/features/master/pages/kelas_form_page.dart';
import 'package:pesantren_management/features/master/pages/santri_kelas_list_page.dart';
import 'package:pesantren_management/features/master/pages/santri_kelas_enroll_page.dart';

final goRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (context, _) => const LoginPage()),
    GoRoute(path: '/dashboard', builder: (context, _) => const DashboardPage()),

    // Santri
    GoRoute(path: '/santri', builder: (context, _) => const SantriListPage()),
    GoRoute(path: '/santri/new', builder: (context, _) => const SantriFormPage()),
    GoRoute(path: '/santri/:id', builder: (context, state) => SantriDetailPage(id: state.pathParameters['id']!)),
    GoRoute(path: '/santri/:id/edit', builder: (context, state) => SantriFormPage(id: state.pathParameters['id'])),

    // Tahun Ajaran
    GoRoute(path: '/tahun-ajaran', builder: (context, _) => const TahunAjaranListPage()),
    GoRoute(path: '/tahun-ajaran/new', builder: (context, _) => const TahunAjaranFormPage()),
    GoRoute(path: '/tahun-ajaran/:id/edit', builder: (context, state) => TahunAjaranFormPage(id: state.pathParameters['id'])),

    // Kelas
    GoRoute(path: '/kelas', builder: (context, _) => const KelasListPage()),
    GoRoute(path: '/kelas/new', builder: (context, state) => KelasFormPage(tahunAjaranId: state.uri.queryParameters['tahunAjaranId'])),
    GoRoute(path: '/kelas/:id/edit', builder: (context, state) => KelasFormPage(id: state.pathParameters['id'])),

    // Santri Kelas (Rombel)
    GoRoute(path: '/santri-kelas', builder: (context, _) => const SantriKelasListPage()),
    GoRoute(path: '/santri-kelas/enroll', builder: (context, state) => SantriKelasEnrollPage(
      tahunAjaranId: state.uri.queryParameters['tahunAjaranId'],
      kelasId: state.uri.queryParameters['kelasId'],
    )),
  ],
);