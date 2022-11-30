import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  const UserItem({required this.userName, required this.userIMG, required this.lastMSG});

  final String userName, userIMG, lastMSG;
  @override
  Widget build(BuildContext context) {
     return Padding(
      padding: EdgeInsets.only(right: 2.w,left: 2.w,top: 2.h),
      child: Row(
        children: [
          CircleAvatar(
            maxRadius: 5.h,
            child: Image.network(userIMG),
          ),
          SizedBox(
            width: 3.w,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName),
              Text(lastMSG),
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("11:45 am"),

            ],
          )
        ],
      ),
    );
  }
}