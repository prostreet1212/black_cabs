part of 'auth_bloc.dart';



abstract   class AuthState extends Equatable{

  AuthState();

  @override
  List<Object> get props=>[];
}

class AuthInitialState extends AuthState{}

class LoadingAuthState extends AuthState{}

class LoggedInState extends AuthState{
  final String uid;
  LoggedInState(this.uid);
}

class AutoLoggedInState extends AuthState{
  final String uid;
  AutoLoggedInState(this.uid);
}

class StateErrorSignUp extends AuthState{
  final String message;
  StateErrorSignUp(this.message);
}

class CodeSentState extends AuthState{
  final String verificationId;
  final int token;

  CodeSentState(this.verificationId, this.token);

}



