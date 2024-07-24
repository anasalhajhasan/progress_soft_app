class ServerException implements Exception {
  String? message;
  ServerException({
    this.message,
  });
  List<String?> get props => [message];
}