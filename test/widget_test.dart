import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pesantren_management/app.dart';

void main() {
  testWidgets('App renders login page', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(child: PesantrenManagementApp()),
    );
    expect(find.text('Pesantren Management'), findsOneWidget);
  });
}