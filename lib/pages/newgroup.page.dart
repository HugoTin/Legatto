import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:info_popup/info_popup.dart';

class NewGroup extends StatelessWidget {
  const NewGroup({super.key});

  void _onEntry(BuildContext context) {
    //Adicionar o usuário a um grupo
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar em um grupo"),
        ),
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color.fromRGBO(52, 82, 214, 1),
                Color.fromRGBO(27, 1, 61, 1),
              ])),
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
                      maxLength: 8,
                      decoration: InputDecoration(
                        hintText: "Digite o Código",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        filled: true,
                        fillColor: Colors.white,
                        counterText: "",
                      ),
                      keyboardType: TextInputType.number),
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
