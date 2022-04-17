// LOGIN EXCEPTION
class UserNotFoundException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// REGISTER EXCEPTION
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyExistedException implements Exception {}

class InvalidEmailAuthException implements Exception {}

// GENERIC EXCEPTION
class GenericAuthException implements Exception {}

class UserNotLoggedInException implements Exception {}
