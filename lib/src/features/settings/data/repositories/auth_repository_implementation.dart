import 'package:devprompt/src/features/settings/domain/repositories/abstract_auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepositoryImplementation extends SettingsAuthRepository {
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImplementation({
    required this.googleSignIn,
    required this.firebaseAuth,
  });

  @override
  Future<void> signOut() async {
    try {
      await firebaseAuth.signOut();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
    } catch (e) {
      throw (e.toString());
    }
  }
}
