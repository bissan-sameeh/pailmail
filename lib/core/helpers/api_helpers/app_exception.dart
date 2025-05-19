class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  /// prefix: the error, message: the details of error

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
