import 'package:beemee/models/user.dart' as beemee_user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final Logger logger = Logger();

  beemee_user.User? _userFromFirebase(User? user) {
    if (user != null) {
      return beemee_user.User(
        id: user.uid,
        email: user.email,
        name: user.displayName,
      );
    }
    return null;
  }

  Future<beemee_user.User?> signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw AuthException('Email and password cannot be empty');
    }
    try {
      UserCredential result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = result.user;
      logger.d('User signed up: ${user?.uid}');
      return _userFromFirebase(user);
    } catch (e) {
      logger.e('Error signing up $email: $e');
      throw AuthException('Sign up failed: $e');
    }
  }

  Future<beemee_user.User?> signIn(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw AuthException('Email and password cannot be empty');
    }
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      User? user = result.user;
      logger.d('User signed in: ${user?.uid}');
      return _userFromFirebase(user);
    } catch (e) {
      logger.e('Error signing in $email: $e');
      throw AuthException('Sign in failed: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    logger.d('User signed out');
  }
}
class Logger {
  final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // number of method calls to be displayed
      errorMethodCount: 8, // number of method calls if stacktrace is provided
      lineLength: 120, // width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print an emoji for each log message
      printTime: true, // Should each log print contain a timestamp
    ),
  );

  void d(dynamic message) => _logger.d(message);
  void e(dynamic message, [dynamic error]) => _logger.e(message, error);
}