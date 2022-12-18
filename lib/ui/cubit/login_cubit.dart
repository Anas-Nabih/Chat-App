import 'package:bloc/bloc.dart';
import 'package:chat_app/commanUtils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


  Future<void> loginUser({required String email, required String password}) async{
    emit(LoginLoading());
    try{
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
      emit(LoginSuccess());
    }on FirebaseAuthException catch(ex){
      if (ex.code == CONST.userNotFound) {
       emit( LoginFailure(errorMessage: 'No user found for that email.'));
      } else if (ex.code == CONST.wrongPassword) {
        LoginFailure(errorMessage:  'Wrong password provided for that user.');
       }
    }catch(e){
      print(e.toString());
      emit(LoginFailure(errorMessage: "Some Thing Wrong Happened"));
    }
  }
}
