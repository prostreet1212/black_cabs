import 'package:black_cabs/services/auth.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitialState()) {
    on<PhoneNumberVerificationEvent>(_phoneNumberVerificationEvent);
    on<PhoneAuthCodeVerifiedEvent>(_phoneAuthCodeVerifiedEvent);
    on<CodeSentEvent>(_codeSentEvent);
  }

  _phoneAuthCodeVerifiedEvent(
      PhoneAuthCodeVerifiedEvent event, Emitter<AuthState> emit) async {
    final uid = await AuthService.instance
        .verifyAndLogin(event.verificationId, event.smsCode, event.smsCode);
    emit(LoggedInState(uid));
  }

  _codeSentEvent(CodeSentEvent event, Emitter<AuthState> emit) {
    emit(CodeSentState(event.verificationId, event.token));
  }

  _phoneNumberVerificationEvent(PhoneNumberVerificationEvent event, Emitter<AuthState> emit)async{
    emit(LoadingAuthState());
    await AuthService.instance.verifyPhoneSendOTP(
        phone: event.phone,
        completed: (credential){
          print('completed');
          add(CompletedAuthEvent(credential));
        },
        failed: (error){

        },
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

  }
}
