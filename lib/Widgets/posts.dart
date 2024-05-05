import 'package:flutter/material.dart';
import 'package:legatto/Widgets/popUpMenuPost.dart';

class Posts extends StatelessWidget {
  late String userImage;
  late String name;
  late String day;
  late String horario;
  late String titlePost;
  late String content;
  late bool isAdmin;
  late bool isSender;

  Posts(this.userImage, this.name, this.day, this.horario, this.titlePost,
      this.content, this.isAdmin, this.isSender,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          color: Color.fromRGBO(92, 45, 151, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(25),
                  child: Image.asset(
                    userImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: TextStyle(
                            color: Color.fromRGBO(32, 215, 255, 1),
                            fontSize: 20,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        day,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        horario,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(flex: 100),
              if (isAdmin | isSender) PopUpMenuPost(isAdmin)
            ],
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              titlePost,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              content,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                child: Text(
                  "Responder",
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}
