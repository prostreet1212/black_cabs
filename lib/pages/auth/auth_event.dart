

part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable{
  const AuthEvent();
  @override
  List<Object> get props=>[];
}

class SignUpEvent extends AuthEvent{
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;

  SignUpEvent(this.uid, this.firstName, this.lastName, this.email, this.phone);
}

class PhoneNumberVerificationEvent extends AuthEvent{
  final String phone;
  const PhoneNumberVerificationEvent(this.phone);
}

class CompletedAuthEvent extends AuthEvent{
  final AuthCredential credential;

  CompletedAuthEvent(this.credential);
}

class PhoneAuthCodeVerifiedEvent extends AuthEvent{
  final String phone;
  final String smsCode;
  final String verificationId;
  PhoneAuthCodeVerifiedEvent(this.phone, this.smsCode, this.verificationId);

}

class ErrorOccuredEvent extends AuthEvent{
  final AuthCredential error;

  ErrorOccuredEvent(this.error);
}

class CodeSentEvent extends AuthEvent{
  final int token;
  final String verificationId;
  CodeSentEvent(this.token, this.verificationId);
}