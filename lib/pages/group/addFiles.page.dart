import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:legatto/enum/naipes.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddFiles extends StatefulWidget {
  const AddFiles({super.key});

  @override
  _AddFiles createState() => _AddFiles();
}

class _AddFiles extends State<AddFiles> {
  Map<String, Map<String, List<dynamic>>> uploadedFiles = {
    'naipe': {'fileNames': [], 'widgetFiles': [], 'files': []}
  };

  _AddFiles() {
    for (var element in Naipes.values) {
      uploadedFiles[element.name] = {
        'fileNames': [],
        'widgetFiles': [],
        'files': []
      };
    }
  }

  List<Widget> naipes = [];

  // WIDGET REPRESENTANDO CADA BLOCO DE NAIPE
  List<Widget> _listNaipes() {
    naipes = [];

    for (var element in Naipes.values) {
      naipes.add(Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(92, 45, 151, 1),
            borderRadius: BorderRadius.all(Radius.circular(15))),
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
                      '   ${element.name}',
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () => _openFileUploader(element.name),
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: const Text(
                          'Adicionar Arquivo',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ))),
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
                      height: uploadedFiles[element.name]?['widgetFiles']
                                  ?.isEmpty ??
                              true
                          ? 100
                          : null,
                      child: uploadedFiles[element.name]?['widgetFiles']
                                  ?.isEmpty ??
                              true
                          ? const Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.file_download_outlined,
                                  color: Colors.white54,
                                ),
                                Text(
                                  'Os arquivos adicionados aparecerão aqui.',
                                  style: TextStyle(color: Colors.white54),
                                )
                              ],
                            )
                          : Column(
                              children: uploadedFiles[element.name]
                                          ?['widgetFiles']
                                      ?.cast<Widget>() ??
                                  [])),
                ),
              ),
            )
          ],
        ),
      ));
    }

    return naipes;
  }

  // FUNÇÃO PARA SELECIONAR ARQUIVOS E ADICIONAR À LISTA
  _openFileUploader(naipe) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
        allowMultiple: true);

    if (result != null) {
      List<PlatformFile> files = result.files;
      for (var file in files) {
        late Widget add;
        int index = uploadedFiles[naipe]?['widgetFiles']?.length ?? 0;
        add = ListTile(
            leading: file.name.contains('.pdf')
                ? Icon(
                    Icons.picture_as_pdf,
                    color: Colors.white,
                    size: 45,
                  )
                : Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 45,
                  ),
            title: Text(file.name, overflow: TextOverflow.ellipsis),
            trailing: TextButton(
                onPressed: () => _deleteFile(naipe, file.name),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: const Text(
                    'Excluir',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )));
        setState(() {
          uploadedFiles[naipe]?['fileNames']?.add(file.name);
          uploadedFiles[naipe]?['widgetFiles']?.add(add);
          uploadedFiles[naipe]?['files']?.add(File(file.path!));
        });
      }
    } else {
      return;
    }
  }

  // FUNÇÃO PARA REMOVER ARQUIVOS DA LISTA
  _deleteFile(String naipe, String fileName) {
    setState(() {
      int fileIndex = uploadedFiles[naipe]!['fileNames']!.indexOf(fileName);
      if (fileIndex != -1) {
        uploadedFiles[naipe]!['fileNames']!.removeAt(fileIndex);
        uploadedFiles[naipe]!['widgetFiles']!.removeAt(fileIndex);
        uploadedFiles[naipe]!['files']!.removeAt(fileIndex);
      }
    });
  }

  // FUNÇÃO PARA UPLOAD DOS ARQUIVOS
  Future<void> _uploadFiles() async {
    bool isUploading = true;
    bool isSuccess = true;

    bool isEmpty =
        uploadedFiles.values.every((value) => value['files']!.isEmpty);

    if (isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Nenhum arquivo selecionado')),
      );
    } else {
      if (isUploading) {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            });
        for (var naipe in uploadedFiles.keys) {
          List files = uploadedFiles[naipe]?['files'] ?? [];
          for (var file in files) {
            String fileName = file.path.split('/').last;
            try {
              final storageRef = FirebaseStorage.instance.ref();
              final uploadTask =
                  storageRef.child('uploads/$naipe/$fileName').putFile(file);
              await uploadTask.whenComplete(() {});

              // Adicionar referência ao Firestore
              await FirebaseFirestore.instance
                  .collection('uploads/$naipe/files')
                  .doc(fileName)
                  .set({
                'name': fileName,
                'filePath': 'uploads/$naipe/$fileName',
                'isPinned': false,
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('Falha ao enviar o arquivo $fileName')));
              isSuccess = false;
              break;
            }
          }
        }
      }
      Navigator.of(context).pop();
      isUploading = false;
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Arquivos enviados com sucesso!')));
        GoRouter.of(context).go("/homegroup");
      } else {
        return;
      }
    }
  }

  // CONSTRUINDO A TELA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            TextButton(
                onPressed: () => GoRouter.of(context).go("/homegroup"),
                child: const Icon(Icons.arrow_back_sharp)),
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
        )),
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
