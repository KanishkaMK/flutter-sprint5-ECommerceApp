import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        final sellerRef = FirebaseFirestore.instance
            .collection('sellercollection')
            .where('email', isEqualTo: event.email)
            .where('usertype', isEqualTo: 'seller')
            .get();
        final result = await sellerRef;
        if (result.docs.isNotEmpty) {
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
        } else {
          emit(SellerNotExxistLoginFailedState());
        }
      }
    });
  }
}
