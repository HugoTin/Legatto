import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:info_popup/info_popup.dart';

class NewGroup extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser!.uid;
  final firestore = FirebaseFirestore.instance;

  Future<void> _onEntry(BuildContext context) async {
    var groupId;
    dynamic membersUID;

    try {
      await firestore
          .collection("group")
          .where("code", isEqualTo: "12TESTE12")
          .get()
          .then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            groupId = docSnapshot.id;
            for (var memberUID in docSnapshot.data()['membersUID']) {
              if (memberUID == user) {
                groupId = null;
                break;
              }
            }
            if (groupId == null) {
              break;
            }
            membersUID = docSnapshot.data()['membersUID'];
          }
        },
        onError: (e) => null,
      );
      membersUID.add(user);

      if (groupId != null) {
        firestore
            .collection("group")
            .doc(groupId)
            .update({"membersUID": membersUID});
      }
    } on Exception catch (exception) {
      null;
    }

    // ignore: use_build_context_synchronously
    GoRouter.of(context).go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => GoRouter.of(context).go("/home"),
          ),
          title: Text("Entrar em um grupo"),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/HomeBackground.png"),
            fit: BoxFit.fill,
          )),
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              height: 240,
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(bottom: 20),
                      width: 300,
                      child: Text("Insira o Código do Grupo",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1, fontSize: 25, color: Colors.white))),
                  TextField(
                    style: TextStyle(color: Colors.black),
                    // maxLength: 9,
                    decoration: InputDecoration(
                      hintText: "Digite o Código",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.white,
                      counterText: "",
                    ),
                    // keyboardType: TextInputType.number
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                    width: 200,
                    height: 50,
                    child: OutlinedButton(
                      child: Text(
                        "ENTRAR",
                        style: TextStyle(
                            height: 1, fontSize: 20, color: Colors.white),
                      ),
                      style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            width: 3.0,
                            color: Colors.white,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () => _onEntry(context),
                    ),
                  ),
                  //   IconButton(
                  //       onPressed: () {},
                  //       icon: Icon(
                  //         Icons.help_outline_rounded,
                  //         color: Colors.white,
                  //       ))
                  InfoPopupWidget(
                    contentTitle:
                        'Insira um código de grupo informado pelo administrador do grupo.',
                    arrowTheme: InfoPopupArrowTheme(
                      color: Colors.white,
                    ),
                    contentMaxWidth: 200,
                    contentTheme: InfoPopupContentTheme(
                      infoContainerBackgroundColor: Colors.white,
                      infoTextStyle: TextStyle(color: Colors.black),
                      contentPadding: const EdgeInsets.all(8),
                      contentBorderRadius:
                          BorderRadius.all(Radius.circular(10)),
                      infoTextAlign: TextAlign.center,
                    ),
                    dismissTriggerBehavior:
                        PopupDismissTriggerBehavior.onTapArea,
                    // areaBackgroundColor: Colors.black,
                    // indicatorOffset: Offset.zero,
                    // contentOffset: Offset.zero,
                    child: Icon(
                      Icons.help_outline_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
