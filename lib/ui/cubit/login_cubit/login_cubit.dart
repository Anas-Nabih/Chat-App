import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/commanUtils/preference/perfs.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/cubit/login_cubit/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());


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
}
