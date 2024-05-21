import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

class AddFiles extends StatelessWidget {
  const AddFiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Convidar membros"),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage("images/HomeBackground.png"),
            fit: BoxFit.fill,
          )),
          child: Container()
        ));
  }
}
