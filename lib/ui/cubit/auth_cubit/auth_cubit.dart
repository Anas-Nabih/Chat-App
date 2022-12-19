import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/commanUtils/preference/perfs.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> loginUser({required String email, required String password}) async{
    emit(LoginLoading());
    try{
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);
      Map<String, dynamic> currentUser = {
        "name":user.user?.displayName ?? "null",
        "email":user.user!.email ?? "null",
        "img":user.user!.photoURL ?? "null",
        "phone":user.user!.phoneNumber ?? "null",
      };
      Prefs.setCurrentUser(jsonEncode(UserModel.fromJson(currentUser)));

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
