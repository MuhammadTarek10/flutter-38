import 'package:mynotes/exceptions/auth_exceptions.dart';
import 'package:mynotes/services/auth/auth_provider.dart';
import 'package:mynotes/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('Mock Authentication', () {
    final mockProvider = MockAuthProvider();
    test('Should not be initialized to begin with', () {
      expect(mockProvider.isInitialized, false);
    });

    test('Cannot log if not initialized', () {
      expect(mockProvider.logOut(),
          throwsA(const TypeMatcher<NotInitializedException>()));
    });

    test('Should be able to initialized', () async {
      await mockProvider.initialize();
      expect(mockProvider.isInitialized, true);
    });

    test('Should user be null after initialization', () {
      expect(mockProvider.currentUser, null);
    });

    test(
      'Should be able to initialize in less than 2 seconds',
      () async {
        await mockProvider.initialize();
        expect(mockProvider.isInitialized, true);
      },
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('Should create a user and to login', () async {
      final badEmailUser = mockProvider.createUser(
          email: 'foo@gmail.com', password: '123213242');
      expect(badEmailUser, throwsA(const TypeMatcher<UserNotFoundException>()));
      final badPasswordUser = mockProvider.createUser(
          email: 'someemail@gmail.com', password: '12341');
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );
      final user = mockProvider.createUser(
          email: 'anyemail@gmail.com', password: 'anypassword');
      expect(mockProvider.currentUser, user);
    });

    test('Logged in user should be verified', () {
      mockProvider.sendEmailVerification();
      final user = mockProvider.currentUser;
      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('Should be able to logout and login again', () async {
      await mockProvider.logOut();
      await mockProvider.logIn(
          email: 'anyemail@gmail.com', password: 'anypassword');
      final user = mockProvider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(
      email: email,
      password: password,
    );
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'foo@gmail.com') throw UserNotFoundException();
    if (password == '12341') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: true);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logOut() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
