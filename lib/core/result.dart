/// Result type — no null checks, no try/catch spreading.
sealed class Result<T, E> {
  const Result();
  bool get isOk => this is Ok<T, E>;
  bool get isErr => this is Err<T, E>;

  R fold<R>(R Function(T) onOk, R Function(E) onErr) {
    return switch (this) {
      Ok(:final value) => onOk(value),
      Err(:final error) => onErr(error),
    };
  }

  T unwrap() {
    return switch (this) {
      Ok(:final value) => value,
      Err(:final error) => throw Exception('unwrap on Err: $error'),
    };
  }
}

final class Ok<T, E> extends Result<T, E> {
  final T value;
  const Ok(this.value);
}

final class Err<T, E> extends Result<T, E> {
  final E error;
  const Err(this.error);
}
