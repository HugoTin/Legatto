// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/popUpMenuFile.dart';
import 'package:legatto/Widgets/popUpMenuGroup.dart';
import 'package:legatto/Widgets/posts.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class HomeGroup extends StatefulWidget {
  const HomeGroup({super.key});

  @override
  _HomeGroupState createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void _actionButton(BuildContext context) {
    null;
  }

  late Future<ListResult> futureFiles;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);

    // futureFiles = FirebaseStorage.instance.ref('partituras/').listAll();
    futureFiles = FirebaseStorage.instance.ref("partituras/").listAll();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
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
                    icon: Icon(Icons.arrow_back)),
                SizedBox(width: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: SizedBox.fromSize(
                    size: Size.fromRadius(18),
                    child: Image.asset(
                      "images/logo-osrp.jpeg",
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text("Orquestra Sinfônica")
              ],
            ),
          ),
          actions: [
            PopUpMenuGroup(),
          ],
          bottom: TabBar(
            indicatorColor: Color.fromRGBO(151, 71, 255, 1),
            indicatorWeight: 4,
            indicatorPadding: EdgeInsets.fromLTRB(70, 0, 70, 0),
            labelColor: Color.fromRGBO(151, 71, 255, 1),
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            tabs: [
              Tab(
                text: "Chat",
              ),
              Tab(
                text: "Partituras",
              ),
            ],
          ),
        ),
        body: Expanded(
          child: Container(
            color: Color.fromRGBO(12, 12, 36, 1),
            // padding: EdgeInsets.all(20),
            child: TabBarView(
              controller: _tabController,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage("images/OpacidadeBackgroundChat.png"),
                    fit: BoxFit.fitWidth,
                  )),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      Posts(
                          'images/UsersExemplos/Fernando-Alonso.jpg',
                          "Fernando Alonso",
                          "21/04",
                          "23:00",
                          "Título da postagem",
                          "Conteúdo da postagem",
                          true,
                          true),
                      SizedBox(height: 20),
                      Posts(
                          'images/UsersExemplos/Pierre-Gasly.jpg',
                          "Pierre Gasly",
                          "21/04",
                          "23:30",
                          "Apresentação no dia 22/04",
                          "Apresentação do primeiro sprint!!",
                          false,
                          false),
                      SizedBox(height: 20),
                      Posts(
                          'images/UsersExemplos/Lando-Norris.jpg',
                          "Lando Norris",
                          "21/04",
                          "23:31",
                          "Olá a todos!",
                          "É um prazer conhecê-los!!",
                          true,
                          false),
                      SizedBox(height: 20),
                      Posts(
                          'images/UsersExemplos/Lance-Stroll.jpg',
                          "Lance Stroll",
                          "21/04",
                          "23:35",
                          "Boa noite!!",
                          "Essa é minha primeira postagem",
                          false,
                          true),
                    ],
                  ),
                ),
                FutureBuilder(
                    future: futureFiles,
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        final files = snapshot.data!.items;

                        return ListView.builder(
                            itemCount: files.length,
                            itemBuilder: (context, index) {
                              final file = files[index];

                              return _RowPDF(file.name, file.fullPath, true);
                            });
                      } else if (snapshot.hasError) {
                        return Center(child: Text(snapshot.error.toString()));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
              ],
            ),
          ),
        ),
        floatingActionButton: _bottomButtons(),
      ),
    );
  }

  Widget _bottomButtons() {
    return _tabController.index == 0
        ? FloatingActionButton(
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(
              Icons.add_comment_rounded,
              color: Colors.black,
              size: 30,
            ),
          )
        : FloatingActionButton(
            onPressed: () => GoRouter.of(context).go("/addfiles"),
            backgroundColor: Colors.white,
            child: Icon(
              Icons.note_add_rounded,
              color: Colors.black,
              size: 30,
            ),
          );
  }
}

class _RowPDF extends StatelessWidget {
  late String nameFile;
  late String filePath;
  late bool isAdmin;

  _RowPDF(this.nameFile, this.filePath, this.isAdmin, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        onTap: () => _openFile(context, nameFile, filePath),
        leading: nameFile.contains('.pdf')
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
        title: Text(
          nameFile,
          style: TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopUpMenuFile(isAdmin),
      ),
    );
  }
}

Future<void> _openFile(context, String nameFile, String filePath) async {
  String downloadDir = await AndroidPathProvider.downloadsPath;
  String localPath = '$downloadDir/$nameFile';
  File localFile = File(localPath);

  try {
    // Verifica e solicita permissão de armazenamento
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permissão de armazenamento negada')),
        );
        return;
      }
    }

    // Verificar se o arquivo já existe
    if (await localFile.exists()) {
      // Verifique se o arquivo pode ser aberto
      var result = await OpenFile.open(localPath);
      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Falha ao abrir o arquivo: ${result.message}')),
        );
      }
      return;
    }
    ;
    // Se o arquivo não existir, fazer o download
    await _downloadFile(context, nameFile, filePath);
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Permissão negada: $e')));
  }
}

Future<void> _downloadFile(context, String nameFile, String filePath) async {
  ValueNotifier<double> progressNotifier = ValueNotifier(0);

  try {
    // Verifica e solicita permissão de armazenamento
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Permissão de armazenamento negada')),
        );
        return;
      }
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(filePath);
    String downloadDir = await AndroidPathProvider.downloadsPath;
    String localPath = '$downloadDir/$nameFile';

    Dio dio = Dio();

    // Mostrar o diálogo de progresso
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Baixando $nameFile',
          style: TextStyle(color: Colors.black),
        ),
        content: ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (context, progress, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: progress),
                SizedBox(height: 20),
                Text('${(progress * 100).toStringAsFixed(0)}%'),
              ],
            );
          },
        ),
      ),
    );

    // Usar Dio para baixar o arquivo com progresso
    await dio.download(
      await ref.getDownloadURL(),
      localPath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          progressNotifier.value = received / total;
        }
      },
    );

    Navigator.of(context).pop(); // Fechar o diálogo de progresso

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download completo: $localPath')),
    );

    // Abrir o arquivo após o download
    OpenFile.open(localPath);
  } catch (e) {
    Navigator.of(context).pop(); // Fechar o diálogo de progresso se houver erro
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Falha no download: $e')),
    );
  }
}
