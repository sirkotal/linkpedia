class UserNotFoundException implements Exception {
  final String message;

  UserNotFoundException(this.message);

  @override
  String toString() {
    return message;
  }
}

class WrongPasswordException implements Exception {
  final String message;

  WrongPasswordException(this.message);

  @override
  String toString() {
    return message;
  }
}

class InvalidEmailException implements Exception {
  final String message;

  InvalidEmailException(this.message);

  @override
  String toString() {
    return message;
  }
}

class WeakPasswordException implements Exception {
  final String message;

  WeakPasswordException(this.message);

  @override
  String toString() {
    return message;
  }
}

class EmailAlreadyInUseException implements Exception {
  final String message;

  EmailAlreadyInUseException(this.message);

  @override
  String toString() {
    return message;
  }
}

class UserAlreadyExistsException implements Exception {
  final String message;

  UserAlreadyExistsException(this.message);

  @override
  String toString() {
    return message;
  }
}
