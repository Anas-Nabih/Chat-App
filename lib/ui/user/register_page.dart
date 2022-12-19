import 'package:chat_app/commanUtils/utils.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/ui/cubit/register_cubit/register_cubit.dart';
import 'package:chat_app/widgets/aleady_have_account.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email, password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoading = true;
         } else if (state is RegisterSuccess) {
          isLoading = false;
           Utils.showSnackBar(context: context, msg: "register Successfully");
        } else if (state is RegisterFailure) {
          isLoading = false;
           Utils.showSnackBar(context: context, msg: state.errorMessage);
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
                    text: "Sigin Up",
                    onTapped: () async {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<RegisterCubit>(context)
                            .registerUser(email: email!, password: password!);
                      }
                    }),
                SizedBox(height: 4.h),
                AlreadyHaveAccount(onTapped: () => Utils.pop(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
