import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthenticationHelper {
  final FirebaseAuth auth = FirebaseAuth.instance;
  get user => auth.currentUser;
  //------------signUp Method--------------

  Future<String?> signUp(
      {required String email, required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
  //-----------signInn method--------------

  Future<String?> signIn(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //--------signOut method
  Future<void> signOut() async {
    await auth.signOut();
    print('SignOut');
  }
}
