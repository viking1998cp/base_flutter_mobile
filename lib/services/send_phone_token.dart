import 'package:firebase_auth/firebase_auth.dart';

class SendPhoneToken {
  SendPhoneToken();

  UserCredential? _firebaseUser;

  String? verificationId;
  // ignore: unused_field
  int? _code;

  Future<void> submitPhoneNumber({required String phone}) async {
    String phoneNumber = "+81" + phone.substring(1, phone.length);
    print(phoneNumber);

    /// The below functions are the callbacks, separated so as to make code more readable
    void verificationCompleted(AuthCredential phoneAuthCredential) {}

    void verificationFailed(_e) {
      print(_e);
    }

    void codeSent(String verificationId, [int? code]) {
      print('codeSent');
      this.verificationId = verificationId;
      print(verificationId);
      this._code = code;
      print(code.toString());
    }

    void codeAutoRetrievalTimeout(String verificationId) {}

    await FirebaseAuth.instance.verifyPhoneNumber(
      /// Make sure to prefix with your country code
      phoneNumber: phoneNumber,

      /// `seconds` didn't work. The underlying implementation code only reads in `milliseconds`
      timeout: Duration(seconds: 120),

      /// If the SIM (with phoneNumber) is in the current device this function is called.
      /// This function gives `AuthCredential`. Moreover `login` function can be called from this callback
      verificationCompleted: verificationCompleted,

      /// Called when the verification is failed
      verificationFailed: verificationFailed,

      /// This is called after the OTP is sent. Gives a `verificationId` and `code`
      codeSent: codeSent,

      /// After automatic code retrival `tmeout` this function is called
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    ); // All the callbacks are above
  }

  Future<bool> submitOTP({required String otp}) async {
    /// get the `smsCode` from the user
    String smsCode = otp;

    try {
      /// when used different phoneNumber other than the current (running) device
      /// we need to use OTP to get `phoneAuthCredential` which is inturn used to signIn/login
      ///

      _firebaseUser = await FirebaseAuth.instance.signInWithCredential(
          PhoneAuthProvider.credential(
              verificationId: this.verificationId!, smsCode: smsCode));
    } catch (_e) {
      print(_e);
    }
    try {
      if (_firebaseUser!.user!.phoneNumber != null) {
        return true;
      }
    } catch (_e) {}
    return false;
  }
}
