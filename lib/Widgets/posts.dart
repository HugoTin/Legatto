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
      margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
          color: Color.fromRGBO(92, 45, 151, 1),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(25),
                  child: Image.asset(
                    userImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: const TextStyle(
                            color: Color.fromRGBO(32, 215, 255, 1),
                            fontSize: 20,
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        day,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        horario,
                        style: const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ],
                  )
                ],
              ),
              const Spacer(flex: 100),
              if (isAdmin | isSender) PopUpMenuPost(isAdmin)
            ],
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              titlePost,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.sizeOf(context).width,
            child: Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)))),
                child: const Text(
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
