import 'package:bloc/bloc.dart';
import 'package:chat_app/commanUtils/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({required String email, required String password})async{
    emit(RegisterLoading());
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
       emit(RegisterSuccess());
    } on FirebaseAuthException catch (e){
      if (e.code == CONST.weakPassword) {
         emit(RegisterFailure(errorMessage: 'The password provided is too weak.'));
      } else if (e.code == CONST.emailAlreadyUsed) {
         emit(RegisterFailure(errorMessage: 'The account already exists for that email.'));
       }
    }
    catch (e){
       emit(RegisterFailure(errorMessage: "Some Thing Wrong Happened ${e.toString()}"));
    }
  }
}
