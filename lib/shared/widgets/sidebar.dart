import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppSidebar extends StatelessWidget {
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: colorScheme.primaryContainer),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Pesantren Management',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Bendahara',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onPrimaryContainer,
                    )),
              ],
            ),
          ),
          _MenuItem(icon: Icons.dashboard, label: 'Dashboard', route: '/dashboard', context: context),
          const Divider(),
          _MenuItem(icon: Icons.people, label: 'Santri', route: '/santri', context: context),
          _MenuItem(icon: Icons.calendar_today, label: 'Tahun Ajaran', route: '/tahun-ajaran', context: context),
          _MenuItem(icon: Icons.class_, label: 'Kelas', route: '/kelas', context: context),
          _MenuItem(icon: Icons.group, label: 'Rombel', route: '/santri-kelas', context: context),
          const Divider(),
          _MenuItem(icon: Icons.receipt_long, label: 'Tagihan', route: '/billing', context: context),
          _MenuItem(icon: Icons.payments, label: 'Pembayaran', route: '/payment', context: context),
          _MenuItem(icon: Icons.account_balance, label: 'Buku Kas', route: '/cashbook', context: context),
          const Divider(),
          _MenuItem(icon: Icons.logout, label: 'Keluar', route: '/login', context: context),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String route;
  final BuildContext context;

  const _MenuItem({required this.icon, required this.label, required this.route, required this.context});

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouterState.of(context).uri.toString().startsWith(route);
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: isActive,
      onTap: () {
        context.go(route);
        if (Scaffold.maybeOf(context)?.hasDrawer ?? false) {
          Navigator.of(context).pop();
        }
      },
    );
  }
}