abstract class FirebaseApiException implements Exception {}

class AuthException extends FirebaseApiException {
  AuthException({this.errorCode = '', this.message = ''});

  final String errorCode;
  final String message;

  // TODO Convert error codes to user friendly strings
  @override
  String toString() => errorCode + message;
}

class DatabaseWriteException extends FirebaseApiException {
  DatabaseWriteException(this.message);

  final String message;

  @override
  String toString() => message;
}

class DatabaseReadException extends FirebaseApiException {
  DatabaseReadException(this.message);

  final String message;

  @override
  String toString() => message;
}
