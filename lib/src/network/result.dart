
abstract class Result {
  const Result();
}

class Success<T> extends Result {
  final T data;

  Success(this.data);
}

class Error extends Result {
  int errorCode = -1;
  final String errorMessage;

  Error(this.errorMessage, {this.errorCode = -1});
}