import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Render AsyncValue, handles loading/error/data states.
class AsyncValueWidget<T> extends ConsumerWidget {
  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final Widget Function(Object error, StackTrace? stack)? errorHandler;

  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
    this.errorHandler,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value.when(
      loading: () =>
          loading ?? const Center(child: CircularProgressIndicator()),
      error: (err, st) => errorHandler != null
          ? errorHandler!(err, st)
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(err.toString(), textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
      data: (d) => data(d),
    );
  }
}
