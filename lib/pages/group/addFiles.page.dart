import 'package:flutter/material.dart';
import 'package:legatto/enum/naipes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';

class AddFiles extends StatefulWidget {
  const AddFiles({super.key});

  @override _AddFiles createState() => _AddFiles();

}

class _AddFiles extends State<AddFiles> {

  Map<
      String, 
      Map<
        String, 
        List<Widget>
      >
  > uploadedFiles = {
    'Teste': {
      'fileNames': [],
      'widgets': []
    }
  };

  _AddFiles(){

    for(var element in Naipes.values){ 
      
      uploadedFiles[element.name] = {
        'fileNames': [],
        'widgets': []
      }; 
      
    }

  }

  List<Widget> naipes = [];

  List<Widget> _listNaipes(){

    naipes = [];

    for(var element in Naipes.values){
      naipes.add(
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
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
                    onPressed: () => _openFileUploader(element.name),
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

              Container(
                  margin: const EdgeInsets.fromLTRB(0, 25, 0, 25),
                child: TextButton(
                  onPressed: () => _openFileUploader(element.name),
                  child: DottedBorder(
                    strokeWidth: 2,
                    color: Colors.grey,
                    borderType: BorderType.RRect,
                    radius: const Radius.circular(10),
                    dashPattern: const [10, 10],
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: uploadedFiles[element.name]!['widgets']!.isEmpty ? 100 : null,
                      child: 
                        uploadedFiles[element.name]!['widgets']!.isEmpty ?
                        const Column(
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
                        ) :
                        Column(
                          children: uploadedFiles[element.name]!['widgets']!
                        )
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

  _openFileUploader(naipe) async {

    // FilePickerResult? result = await FilePicker.platform.pickFiles(
    //   allowedExtensions: ['jpg', 'png', 'pdf'],
    // );

    // if(result != null){ return result.files.first.name; }
    // else{ return ''; }

    // Comportamento ao subir o arquivo

    Widget add = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 70,
          child: Row(
            children: [
              Image.asset(
                'images/PDF.png',
                height: 50,
              ),
              const Text(
                // result!.files.first.name 
                'Teste'
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () => _deleteFile(naipe, uploadedFiles[naipe]!['widgets']!.length),
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(15)
              ),
            ),
            child: const Text(
              'Excluir',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          )
        )
      ],
    );

    setState(() {
      uploadedFiles[naipe]!['widgets']!.add(add);
    });

  }

  _deleteFile(naipe, index){

    setState(() {
      uploadedFiles[naipe]!['widgets']!.removeAt(index);
    });

  }

  Future<String> _uploadFiles() async {

    return '';

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              TextButton(
                onPressed: () => Navigator.pop(context), 
                child: const Icon(Icons.arrow_back_sharp)
              ),
              const Text("Adicionar Arquivos"),
            ],
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/HomeBackground.png"),
              fit: BoxFit.fill,
            )
          ),
          child: ListView(
            children: _listNaipes(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _uploadFiles(),
          backgroundColor: Colors.white,
          child: const Icon(
            Icons.send_outlined,
            color: Colors.black,
          ),
        ),
      );
  }
}
