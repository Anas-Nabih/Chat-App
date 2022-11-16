import 'package:chat_app/const/colors.dart';
import 'package:chat_app/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_text_form_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RegisterPage extends StatelessWidget {
    RegisterPage({Key? key}) : super(key: key);

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
            CustomBtn(text: "Sigin Up"),
            SizedBox(height: 4.h),
            GestureDetector(
              onTap: ()=>Navigator.push(context, CupertinoPageRoute(builder: (context) => LoginPage(),)),
              child: Text.rich(TextSpan(
                  text:"already have an account?\t" ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(text: "Sigin in",style: TextStyle(
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
