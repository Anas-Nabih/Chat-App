import 'package:chat_app/commanUtils/navigator_uutils.dart';
import 'package:chat_app/res/colors.dart';
import 'package:chat_app/ui/user/register_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:MColors.primaryColor,
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
                    CustomTextFormField(hintText: "Email"),
                    SizedBox(height: 4.h),
                    CustomTextFormField(hintText: "Password")
                  ],
                )),
            SizedBox(height: 8.h),
            CustomBtn(text: "Sigin in"),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: ()=>NavigatorUtils.push(context, RegisterPage()),
              child: Text.rich(TextSpan(
                text:"don't have an account?\t" ,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w400),
                children: [
                  TextSpan(text: "Sigin Up",style: TextStyle(
                      color: Colors.white,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600))
                  ]
              )),
            ),

          ],
        ),
      ),
    );
  }
}




