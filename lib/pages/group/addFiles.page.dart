import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/enum/naipes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

class AddFiles extends StatefulWidget {
  const AddFiles({super.key});

  @override _AddFiles createState() => _AddFiles();

}

class _AddFiles extends State<AddFiles> {

  List<Widget> naipes = [];

  List<Widget> _listNaipes(){

    for (var element in Naipes.values){

      naipes.add(
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(92, 45, 151, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(15)
            )
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'images/Naipe${element.name}.png',
                        height: 50,
                      ),
                      Text(
                        '   ${element.name} (0)',
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () => _openFileUploader(),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      // alignment: Alignment.centerRight,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15)
                        ),
                      ),
                      child: const Text(
                      'Adicionar Arquivo', 
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ) )
                  ),
                ],
              ),

              TextButton(
                onPressed: () => _openFileUploader(),
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: DottedBorder(
                    strokeWidth: 2,
                    color: Colors.grey,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 10],
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.75,
                      height: 100,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            Icons.file_download_outlined,
                            color: Colors.white54,
                          ),
                          Text(
                            'Os arquivos adicionados aparecerão aqui.',
                            style: TextStyle(
                              color: Colors.white54
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      );

    }

    return naipes;

  }

  Future<String> _openFileUploader() async {

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['jpg', 'png', 'pdf'],
    );

    if(result != null){ return result.files.first.name; }
    else{ return ''; }

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => _openFileUploader(), 
                child: const Icon(Icons.arrow_back_sharp)
              ),
              const Text("Adicionar Arquivos"),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(20, 25, 20, 25),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/HomeBackground.png"),
              fit: BoxFit.fill,
            )
          ),
          child: ListView(
            children: _listNaipes(),
          )
        ));
  }
}
