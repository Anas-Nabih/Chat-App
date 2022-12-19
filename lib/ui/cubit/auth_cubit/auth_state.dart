part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class LoginInitial extends AuthState {}
class LoginLoading extends AuthState {}
class LoginSuccess extends AuthState {}
class LoginFailure extends AuthState {
  LoginFailure({required this.errorMessage});
  final String errorMessage;
}

class RegisterInitial extends AuthState {}
class RegisterLoading extends AuthState{}
class RegisterSuccess extends AuthState{}
class RegisterFailure extends AuthState{
  RegisterFailure({required this.errorMessage});
  final String errorMessage;
}