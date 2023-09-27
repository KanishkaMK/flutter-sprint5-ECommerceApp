import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is LoginWithEmailAndPassword) {
        try {
           final userdetails = await auth.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          
       if (userdetails == null) {
           
            emit(LoginFailedState());
          } else {
            
            emit(NavigateToHomeScreen());
          }
        } catch (e) {
         
          emit(LoginFailedState());
        }
      }
    });
  }
}
