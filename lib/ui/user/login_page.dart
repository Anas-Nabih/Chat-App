import 'package:chat_app/commanUtils/utils.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/ui/blocs/auth/auth_bloc.dart';
import 'package:chat_app/ui/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/ui/home_screen/home_screen.dart';
import 'package:chat_app/ui/user/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:chat_app/widgets/do_not_have_account.dart';
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
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoading = true;
        } else if (state is LoginSuccess) {
          BlocProvider.of<ChatCubit>(context).getMessages();
          // Utils.push(context: context, navigationScreen: ChatScreen(email: email!), replace: true);
          Utils.push(context: context, navigationScreen: HomeScreen(), replace: true);
          isLoading = false;
        } else if (state is LoginFailure) {
          Utils.showSnackBar(context: context, msg: state.errorMessage);
          isLoading = false;
        }
      },
      builder: (context, state) => ModalProgressHUD(
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
                CustomBtn(
                    text: "Sign in",
                    onTapped: () async {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<AuthBloc>(context).add(LoginEvent(email: email!, password: password!));
                      }
                    }),
                SizedBox(height: 4.h),
                DoNotHaveAccount(
                    onTapped: () => Utils.push(
                        context: context, navigationScreen: RegisterPage())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
