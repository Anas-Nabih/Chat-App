import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/commanUtils/preference/perfs.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: event.email, password: event.password);
          Map<String, dynamic> currentUser = {
            "id": user.user?.uid ?? "null",
            "email": user.user?.email ?? "null",
            "phone": user.user?.phoneNumber ?? "null",
            "displayName": user.user?.displayName ?? "null",
            "photoUrl": user.user?.photoURL ?? "null",
            "lastMsg": user.user?.displayName ?? "null",
          };

          Prefs.setCurrentUser(jsonEncode(UserModel.fromJson(currentUser)));
          Prefs.setCurrentUser(jsonEncode(UserModel.fromJson(currentUser)));

          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          if (ex.code == CONST.userNotFound) {
            emit(LoginFailure(errorMessage: 'No user found for that email.'));
          } else if (ex.code == CONST.wrongPassword) {
            emit(LoginFailure(
                errorMessage: 'Wrong password provided for that user.'));
          }
        } catch (e) {
          print("login error: $e");
          emit(LoginFailure(errorMessage: "Some Thing Wrong Happened"));
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: event.email, password: event.password);
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (e) {
          if (e.code == CONST.weakPassword) {
            emit(RegisterFailure(
                errorMessage: 'The password provided is too weak.'));
          } else if (e.code == CONST.emailAlreadyUsed) {
            emit(RegisterFailure(
                errorMessage: 'The account already exists for that email.'));
          }
        } catch (e) {
          emit(RegisterFailure(
              errorMessage: "Some Thing Wrong Happened ${e.toString()}"));
        }
      }
    });
  }
}
