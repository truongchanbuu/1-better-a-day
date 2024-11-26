abstract class DataState<T> {
  final T? data;
  final Exception? error;

  const DataState({this.data, this.error});
}

final class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

final class DataFailure<T> extends DataState<T> {
  const DataFailure(Exception error) : super(error: error);
}
