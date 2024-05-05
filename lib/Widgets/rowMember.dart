import 'package:flutter/material.dart';
import 'package:legatto/Widgets/popUpMenuUser.dart';

class RowMember extends StatelessWidget {
  late String image;
  late String name;
  late bool isAdmin;
  late bool isUser;

  RowMember(this.image, this.name, this.isAdmin, this.isUser, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: SizedBox.fromSize(
            size: Size.fromRadius(25),
            child: Image.asset(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        if (isAdmin)
          SizedBox(
            width: 50,
            child: Text(
              "Admin",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                backgroundColor: Color.fromRGBO(191, 141, 255, 1),
                fontSize: 10,
              ),
            ),
          ),
        Spacer(
          flex: 100,
        ),
        if (isUser) PopUpMenuUser(isAdmin)
      ],
    );
  }
}
