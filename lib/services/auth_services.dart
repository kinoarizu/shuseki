part of 'services.dart';

class AuthServices {
  static auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  static Future<ResponseHandler> register(Auth authData) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );

      User user = result.user.convertToUser(
        nidk: authData.nidk,
        name: authData.name,
        imei: authData.imei,
        coordinate: authData.coordinate,
      );

      await UserServices.updateUser(user);

      return ResponseHandler(user: user);
    } 
    on auth.FirebaseAuthException catch (e) {
      return ResponseHandler(
        message: e.code,
      );
    } 
  }

  static Future<ResponseHandler> logIn(Auth authData) async {
    try {
      bool checkEmail = await UserServices.isEmailExists(authData.email);
      bool matchImei = await UserServices.isImeiMatch(authData.email);

      if (!checkEmail) {
        return ResponseHandler(
          message: 'email-not-registered',
        );
      } else if (!matchImei) {
        return ResponseHandler(
          message: 'imei-different',
        );
      }

      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: authData.email, 
        password: authData.password,
      );

      User user = await result.user.fromFireStore();

      return ResponseHandler(user: user);
    }
    catch (e) {
      return ResponseHandler(
        message: 'wrong-password',
      );
    }
  }

  static Future<ResponseHandler> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);

      return ResponseHandler();
    } 
    catch (e) {
      return ResponseHandler(
        message: 'user-not-found',
      );
    }
  }

  static Future<void> logOut() async {
    await _auth.signOut();
  }

  static Stream<auth.User> get userStream => _auth.authStateChanges();
}
