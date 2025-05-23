class AppException implements Exception {
  final dynamic _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  /// prefix: the error, message: the details of error
  String get message {
    if (_message is String) return _message;
    if (_message is Map && _message['message'] is String) return _message['message'];
    return _message.toString();
  }

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

///types of exceptions
class FetchDataException extends AppException {
  FetchDataException([message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message, "Bad Request");
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message, "Unauthorised: ");
}

class InvalidInputException extends AppException {
  InvalidInputException([message]) : super(message, "Invalid Input: ");
}
