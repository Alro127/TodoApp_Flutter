import 'package:firebase_auth/firebase_auth.dart';
import 'package:to_do_app/data/firebase_datasource.dart';

abstract class AuthenticationDataSource {
  Future<void> register(String email, String password, String passwordConfirm);
  Future<void> login(String email, String password);
}

class AuthenticationRemote extends AuthenticationDataSource {
  @override
  Future<void> register(
    String email,
    String password,
    String passwordConfirm,
  ) async {
    // TODO: implement register
    if (password.trim() == passwordConfirm.trim()) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email.trim(),
            password: password.trim(),
          )
          .then((value) {
            FirebaseDatasource().CreateUser(email);
          });
    }
  }

  @override
  Future<void> login(String email, String password) async {
    // TODO: implement login
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }
}
