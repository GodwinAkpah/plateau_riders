

class APIResponse<T> {
  final String status;
  final String message;
  final T? data;

  APIResponse({
    required this.status,
    required this.message,
    this.data,
  });
}