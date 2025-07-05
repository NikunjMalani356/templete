import 'dart:io';
import 'dart:typed_data';

import 'package:cc_template_dev/app/helper/extension_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  // ===================================== Sign In ======================================= //
  @override
  Future<User?> logIn(String emailAddress, String password) async {
    try {
      final authUser = await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailAddress, password: password);
      if (authUser.user != null) {
        'User verified successfully'.showSuccess();
        return authUser.user;
      }
    } on FirebaseAuthException catch (e) {
      'Catch FirebaseAuthException in logIn --> ${e.message}'.errorLogs();
      e.message?.showSuccess();
    } on SocketException catch (e) {
      'Catch SocketException in logIn --> ${e.message}'.errorLogs();
      e.message.showSuccess();
    }
    return null;
  }

  // ===================================== Sign out ======================================= //
  @override
  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      'SignOut Error: $e'.errorLogs();
    }
  }

  // ===================================== Register ======================================= //
  @override
  Future<User?> registerWithEmailAndPassword(String email, String password) async {
    try {
      final UserCredential authUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      return authUser.user;
    } on FirebaseAuthException catch (e) {
      'Catch FirebaseAuthException in registerWithEmailAndPassword --> ${e.message}'.errorLogs();
      if (e.code == 'email-already-in-use') {
        "The email you entered is already in use".showError();
      }
    }
    return null;
  }

  // ===================================== Forgot Password ======================================= //

  @override
  Future<bool> sendPasswordOnEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      'Catch FirebaseAuthException in sendPasswordOnEmail --> ${e.message}'.errorLogs();
    } on SocketException catch (e) {
      'Catch SocketException in sendPasswordOnEmail --> ${e.message}'.errorLogs();
    }
    return false;
  }

  // ===================================== Upload to Firebase ======================================= //
  @override
  Future<String?> uploadToFirebase(File file, {bool isVideo = false, bool isHeadShot=false}) async {
    try {
      final String fileName = file.path.split('/').last;
      'File name --> $fileName'.infoLogs();

      final folderRef = FirebaseStorage.instance
          .ref()
          .child('${FirebaseAuth.instance.currentUser?.uid}/${isVideo ? 'videos' : 'image'}');

      final Uint8List imageData = await file.readAsBytes();
      final Reference ref = folderRef.child(isVideo?'introductionVideo':isHeadShot?'headShotImage':'fullBodyImage');
      await ref.putData(imageData, SettableMetadata(contentType: isVideo ? 'video/mp4' : 'image/png', cacheControl: 'no-store'));

      final String downloadUrl = (await ref.getDownloadURL()).split('&token').first;
      'File uploaded successfully! Download URL: $downloadUrl'.logs();
      return downloadUrl;
    } on FirebaseException catch (e) {
      'Catch FirebaseException in uploadToFirebase --> ${e.message}'.errorLogs();
      e.message?.showSuccess();
    } on SocketException catch (e) {
      'Catch SocketException in uploadToFirebase --> ${e.message}'.errorLogs();
      e.message.showSuccess();
    }
    return null;
  }
}
