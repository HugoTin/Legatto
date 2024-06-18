import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legatto/Widgets/popUpMenuGroup.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!.displayName;
final firestore = FirebaseFirestore.instance;

class NewPost extends StatefulWidget {
  final String id;
  const NewPost(this.id, {super.key});

  @override
  _NewPostState createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {

  final fieldTitle = TextEditingController();
  final fieldContent = TextEditingController();
  
  var id;

  @override
  void initState() {
    super.initState();

    id = widget.id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          title: InkWell(
            onTap: () => GoRouter.of(context).go("/configgroup"),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () => GoRouter.of(context).go("/home"),
                    icon: const Icon(Icons.arrow_back)),
                const SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(18),
                    child: Image.asset(
                      "images/logo-osrp.jpeg",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text("Orquestra Sinfônica")
              ],
            ),
          ),
        ),

        body: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Color.fromRGBO(12, 12, 36, 1),
              image: DecorationImage(
              image: AssetImage("images/OpacidadeBackgroundChat.png"),
              fit: BoxFit.fitWidth,
          )),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              TextField(
                controller: fieldTitle,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: 'Digite o Titulo',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Color.fromARGB(255, 25, 4, 99),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: fieldContent,
                maxLines: 14,
                style: const TextStyle(
                  color: Colors.white,
                ),
                decoration: const InputDecoration(
                  hintText: 'Digite a mensagem',
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                  fillColor: Color.fromARGB(255, 25, 4, 99),
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ]
          ),
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => newPost(context, id, fieldTitle.text, fieldContent.text),
        backgroundColor: Colors.white,
        child: const Icon(
          Icons.send,
          color: Colors.black,
          size: 30,
        ),
      )
    ));
  }
}

newPost(context, id, title, content) async{

  if(title == '' || content == '') {
    print('Não preenchidos');
  }else{

    var doc = await firestore
    .collection('posts')
    .where('groupID', isEqualTo: id)
    .get();

    var idDoc = doc.docs.first.id;
    // print('asdasdasd $idDoc');
    List<dynamic> postsDoc = doc.docs.first.data()['main'];
    // print('asdasdasd $postsDoc');

    DateTime now = DateTime.now();

    var day = '';
    var month = '';
    var hour = '';
    var minute = '';

    now.day < 10 ? day = '0${now.day}' : day = now.day.toString();
    now.month < 10 ? month = '0${now.month}' : month = now.month.toString();
    now.hour < 10 ? hour = '0${now.hour}' : hour = now.hour.toString();
    now.minute < 10 ? minute = '0${now.minute}' : minute = now.minute.toString();

    postsDoc.add({
      'title': title,
      'content': content,
      'user': user,
      'date': '$day/$month $hour:$minute'
    });
    // print('asdasdasd 2 $postsDoc');

    firestore
    .collection('posts')
    .doc(idDoc)
    .update({ 'main': postsDoc });

    GoRouter.of(context).go("/homegroup/$id");

  }

}