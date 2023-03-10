// ignore_for_file: prefer_typing_uninitialized_variables

class AppExceptions implements Exception {
  final _message;
  final _prefix;
  AppExceptions([this._message, this._prefix]);

  @override
  String toString() {
    return ('$_prefix$_message');
  }
}

// if time out for 10sec result not coming
class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message, 'Error During Comunication 500');
}

//if url does not exist
class BadRequestException extends AppExceptions {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}

//if token is expired or not correct
class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorized Request');
}

class DataInvalidException extends AppExceptions {
  DataInvalidException([
    String? message,
  ]) : super(message, '');
}

class ThreeZeroTwoException extends AppExceptions {
  ThreeZeroTwoException([
    String? message,
  ]) : super(message, 'Internal Server Error 302');
}

// if data is not valid
class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message]) : super(message, 'Invalid Input');
}
