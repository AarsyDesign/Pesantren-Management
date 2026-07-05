import 'package:flutter/material.dart';
import 'package:pesantren_management/shared/widgets/sidebar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: const AppSidebar(),
      body: const Center(
        child: Text('Dashboard — coming soon'),
      ),
    );
  }
}
