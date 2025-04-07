// Result Type
sealed class Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure({int statusCode, String error}) = Failure<T>;
}

class Success<T> implements Result<T> {
  final T data;
  const Success(this.data);
}

class Failure<T> implements Result<T> {
  final int statusCode;
  final String error;
  const Failure({this.statusCode = 500, this.error = ''});
}
