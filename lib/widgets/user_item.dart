import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class UserItem extends StatelessWidget {
  const UserItem(
      {super.key,
      required this.userName,
      required this.userIMG,
      required this.lastMSG,
      required this.onTapped});

  final String userName, userIMG, lastMSG;
  final void Function() onTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 2.w, left: 2.w, top: 2.h),
      child: GestureDetector(
        onTap: onTapped,
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 5.h,
              backgroundImage: NetworkImage(userIMG),
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
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text("11:45 am"),
              ],
            )
          ],
        ),
      ),
    );
  }
}
