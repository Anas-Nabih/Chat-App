import 'dart:convert';

import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/commanUtils/preference/perfs.dart';
 import 'package:chat_app/commanUtils/utils.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/models/user_model.dart';
import 'package:chat_app/ui/chat_screen/chat_screen.dart';
import 'package:chat_app/ui/cubit/login_cubit.dart';
import 'package:chat_app/ui/user/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? email, password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit,LoginState>(
      listener: (context, state){
        if(state is LoginLoading){
          isLoading = true;
        }else if(state is LoginSuccess){
           Utils.push(context: context,navigationScreen:  ChatScreen(email:email!), replace: false);
           isLoading = false;
        }else if(state is LoginFailure) {
          Utils.showSnackBar(context: context, msg:state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context,state) => ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: MColors.primaryColor,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Chat App",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 8.h),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextFormField(
                            onChanged: (val) => email = val,
                            validation: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter Your Email";
                              }
                            },
                            hintText: "Email"),
                        SizedBox(height: 4.h),
                        CustomTextFormField(
                            onChanged: (val) => password = val,
                            validation: (val) {
                              if (val!.isEmpty) {
                                return "Please Enter Your Password";
                              } else if (val.length < 6) {
                                return "Password at least should be +6 chars";
                              }
                            },
                            hintText: "Password")
                      ],
                    )),
                SizedBox(height: 8.h),
                CustomBtn(text: "Sigin in",onTapped:  () async {
                  if(_formKey.currentState!.validate()){
                    BlocProvider.of<LoginCubit>(context).loginUser(email: email!, password: password!);

                  }
                  }),
                SizedBox(height: 4.h),
                GestureDetector(
                  onTap: () => Utils.push(context: context,navigationScreen:  RegisterPage()),
                  child: Text.rich(TextSpan(
                      text: "don't have an account?\t",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400),
                      children: [
                        TextSpan(
                            text: "Sigin Up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600))
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> loginWithEmailAndPassword(BuildContext context) async {
    UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email!, password: password!);

    Map<String, dynamic> currentUser = {
      "name":user.user?.displayName ?? "null",
      "email":user.user!.email ?? "null",
      "img":user.user!.photoURL ?? "null",
      "phone":user.user!.phoneNumber ?? "null",
    };
    Prefs.setCurrentUser(jsonEncode(UserModel.fromJson(currentUser)));
    Utils.showSnackBar(context: context, msg: "login Successfully");
    Prefs.getCurrentUser.then((value){
      UserModel userObj = UserModel.fromJson(jsonDecode(value));
      Utils.push(context: context,navigationScreen:  ChatScreen(email:userObj.email!),
          replace: false);
    });

  }

  void loginException(FirebaseAuthException e, BuildContext context) {
     if (e.code == CONST.userNotFound) {
      Utils.showSnackBar(context: context, msg: 'No user found for that email.');
     } else if (e.code == CONST.wrongPassword) {
      Utils.showSnackBar(context: context, msg: 'Wrong password provided for that user.');
    }
  }
}
