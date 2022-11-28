 import 'package:chat_app/commanUtils/const.dart';
import 'package:chat_app/commanUtils/utils.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email, password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
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
                          validation: (val){
                            if(val!.isEmpty) {
                              return "Please Enter Your Email";
                            }
                          },
                          hintText: "Email"),
                      SizedBox(height: 4.h),
                      CustomTextFormField(
                          onChanged: (val) => password = val,
                          validation: (val){
                            if(val!.isEmpty) {
                              return "Please Enter Your Password";
                            }else if(val!.length < 6){
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
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        isLoading = true;
                      });
                      try{
                        await registerUserWithEmailAndPassword();
                      }on FirebaseAuthException catch(e){
                        registerException(e, context);
                       }catch (e){

                        Utils.showSnackBar(context: context, msg:e.toString());
                      }
                    }

                    setState(() {
                      isLoading = false;
                    });

                  }),
              SizedBox(height: 4.h),
              GestureDetector(
                onTap: () => Utils.pop(context),
                child: Text.rich(TextSpan(
                    text: "already have an account?\t",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                          text: "Sigin in",
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
    );
  }

  void registerException(FirebaseAuthException e, BuildContext context) {
    if (e.code == CONST.weakPassword) {
      Utils.showSnackBar(context: context, msg: 'The password provided is too weak.');
    } else if (e.code == CONST.emailAlreadyUsed) {
      Utils.showSnackBar(context: context, msg: 'The account already exists for that email.');
      }
  }

  Future<void> registerUserWithEmailAndPassword() async {
     UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email!, password: password!);
     Utils.showSnackBar(context: context, msg: "Login Successfully");

  }

}
