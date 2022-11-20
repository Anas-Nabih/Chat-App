import 'package:chat_app/commanUtils/navigator_uutils.dart';
import 'package:chat_app/const/colors.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        onChanged: (val) => email = val, hintText: "Email"),
                    SizedBox(height: 4.h),
                    CustomTextFormField(
                        onChanged: (val) => password = val,
                        hintText: "Password")
                  ],
                )),
            SizedBox(height: 8.h),
            CustomBtn(text: "Sigin Up",onTapped: ()async{
              UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email!, password: password!);
              print(user.user!.email);
            }),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: () => NavigatorUtils.pop(context),
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
    );
  }
}
