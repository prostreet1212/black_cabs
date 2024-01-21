import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService._();

  static AuthService? _instance;

  static AuthService get instance {
    if (_instance == null) {
      _instance = AuthService._();
    }
    return _instance!;
  }

  FirebaseAuth? _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneSendOTP(
  {required String phone,
    required void Function(PhoneAuthCredential)? completed,
    required void Function(FirebaseAuthException)? failed,
    required void Function(String, int?)? codeSent,
    required void Function(String)? codeAutoRetrievalTimeout,}
  ) async {
    _auth!.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: completed!,
        verificationFailed: failed!,
        codeSent: codeSent!,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout!);
  }

  Future<String> verifyAndLogin(
      String verificationId, String smsCode, String phone) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    final authCredential = await _auth!.signInWithCredential(credential);
    if (authCredential.user != null) {
      final uid = authCredential.user!.uid;
      final userSnap =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (!userSnap.exists) {
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'uid': uid,
          'phone': phone,
        });
      }
      return uid;
    } else {
      return '';
    }
  }

  Future<String>getCredential(PhoneAuthCredential credential) async{
    final authCredential = await _auth!.signInWithCredential(credential);
    return authCredential.user!.uid;
  }

}
