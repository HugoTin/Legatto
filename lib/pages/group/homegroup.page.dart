import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:legatto/Widgets/popUpMenuFile.dart';
import 'package:legatto/Widgets/popUpMenuGroup.dart';
import 'package:legatto/Widgets/posts.dart';
import 'package:go_router/go_router.dart';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

class HomeGroup extends StatefulWidget {
  final String id;
  const HomeGroup(this.id, {super.key});

  @override
  _HomeGroupState createState() => _HomeGroupState();
}

class _HomeGroupState extends State<HomeGroup> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Future<List<FileItem>> futureFiles;
  bool isAdmin = true; // MUDAR DE ACORDO COM O USUÁRIO

  final firestore = FirebaseFirestore.instance;
  var id;

  @override
  void initState() {
    super.initState();

    id = widget.id;

    _tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);

    futureFiles = _fetchFiles();
  }

  Future<List<FileItem>> _fetchFiles() async {
    ListResult result =
        // ALTERAR O PATH
        await FirebaseStorage.instance.ref("uploads/Violino").listAll();
    List<FileItem> files = [];
    for (var item in result.items) {
      var doc = await FirebaseFirestore.instance
          .collection('uploads/Violino/files')
          .doc(item.name)
          .get();
      bool isPinned = doc.exists ? doc['isPinned'] : false;
      files.add(FileItem(item.name, item.fullPath, isPinned));
    }
    files.sort((a, b) => (b.isPinned ? 1 : 0).compareTo(a.isPinned ? 1 : 0));
    return files;
  }

  Future<void> _refreshFileList() async {
    setState(() {
      futureFiles = _fetchFiles();
    });
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

  //FUNÇÃO PARA FIXAR ARQUIVOS (TAMBÉM ALTERAR O PATH)
  void _togglePin(FileItem fileItem) async {
    setState(() {
      fileItem.isPinned = !fileItem.isPinned;
    });
    await FirebaseFirestore.instance
        .collection('uploads/Violino/files')
        .doc(fileItem.name)
        .set({
      'name': fileItem.name,
      'filePath': fileItem.filePath,
      'isPinned': fileItem.isPinned,
    }, SetOptions(merge: true));

    _refreshFileList();
  }

  // FUNÇÃO PARA EXCLUIR ARQUIVOS (TAMBÉM ALTERAR O PATH)
  Future<void> _deleteFile(String filePath, String fileName) async {
    await FirebaseStorage.instance.ref(filePath).delete();
    await FirebaseFirestore.instance
        .collection('uploads/Violino/files')
        .doc(fileName)
        .delete();
    _refreshFileList();
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
          actions: const [
            PopUpMenuGroup(),
          ],
          bottom: TabBar(
            indicatorColor: const Color.fromRGBO(151, 71, 255, 1),
            indicatorWeight: 4,
            indicatorPadding: const EdgeInsets.fromLTRB(70, 0, 70, 0),
            labelColor: const Color.fromRGBO(151, 71, 255, 1),
            unselectedLabelColor: Colors.white,
            controller: _tabController,
            tabs: const [
              Tab(
                text: "Chat",
              ),
              Tab(
                text: "Partituras",
              ),
            ],
          ),
        ),

        // ABA DE POSTAGENS
        body:  StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: firestore
              .collection('posts')
              .where('groupID', isEqualTo: id)
              .snapshots(),
          builder: (context, snapshot){ 

          if(!snapshot.hasData) return const SizedBox(height: 20, width: 20);

          List<dynamic> posts = snapshot.data!.docs.first['main'];

          List<Widget> postsWidgets = posts.map((post) => 
            Posts(
              'images/UsersExemplos/Fernando-Alonso.jpg',
              post['user'],
              post['date'].split(' ')[0],
              post['date'].split(' ')[1],
              post['title'],
              post['content'],
              true,
              true
            )
          ).toList();
          
          return Container(
          color: const Color.fromRGBO(12, 12, 36, 1),
          child: TabBarView(
            controller: _tabController,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("images/OpacidadeBackgroundChat.png"),
                  fit: BoxFit.fitWidth,
                )),
                child: ListView(
                  scrollDirection: Axis.vertical,
                  children: postsWidgets
                ),
              ),

              // ABA ARQUIVOS
              // CONSTRUINDO A LISTA DE ARQUIVOS DO GRUPO
              FutureBuilder(
                  future: futureFiles,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      final files = snapshot.data!;
                      final pinnedFiles =
                          files.where((file) => file.isPinned).toList();
                      final unpinnedFiles =
                          files.where((file) => !file.isPinned).toList();

                      return RefreshIndicator(
                        onRefresh: _refreshFileList,
                        child: ListView.builder(
                            itemCount:
                                pinnedFiles.length + unpinnedFiles.length,
                            itemBuilder: (context, index) {
                              final file = index < pinnedFiles.length
                                  ? pinnedFiles[index]
                                  : unpinnedFiles[index - pinnedFiles.length];

                              return _RowPDF(
                                  file, isAdmin, _togglePin, _deleteFile);
                            }),
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text(snapshot.error.toString()));
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  })),
            ],
          ),
        );
        }
      ),
      floatingActionButton: _bottomButtons()
    ));
  }

  // ALTERANDO O FLOACTING ACTION BUTTON DEPENDENDO DA ABA
  Widget _bottomButtons() {
    return _tabController.index == 0
        ? FloatingActionButton(
            onPressed: () => GoRouter.of(context).go("/newpost/$id"),
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.add_comment_rounded,
              color: Colors.black,
              size: 30,
            ),
          )
        : FloatingActionButton(
            onPressed: () => GoRouter.of(context).go("/addfiles"),
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.note_add_rounded,
              color: Colors.black,
              size: 30,
            ),
          );
  }
}

// CLASSE PARA AS ROWS QUE MOSTRAM OS ARQUIVOS
class _RowPDF extends StatelessWidget {
  final FileItem fileItem;
  final bool isAdmin;
  final ValueChanged<FileItem> onPinToggle;
  final Future<void> Function(String, String) onDelete;

  const _RowPDF(this.fileItem, this.isAdmin, this.onPinToggle, this.onDelete,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        onTap: () => _openFile(context, fileItem.name, fileItem.filePath),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            fileItem.name.contains('.pdf')
                ? const Icon(
                    Icons.picture_as_pdf,
                    color: Colors.white,
                    size: 45,
                  )
                : const Icon(
                    Icons.image,
                    color: Colors.white,
                    size: 45,
                  ),
            const SizedBox(width: 10),
            Icon(
              fileItem.isPinned ? Icons.push_pin : null,
              color: Colors.white,
              size: 20,
            ),
          ],
        ),
        title: Text(
          fileItem.name,
          style: const TextStyle(color: Colors.white, fontSize: 20),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: PopUpMenuFile(
            isAdmin,
            fileItem.filePath,
            () => onPinToggle(fileItem),
            () => onDelete(fileItem.filePath, fileItem.name)),
      ),
    );
  }
}

// CLASSE PARA OS ARQUIVOS NO STORAGE
class FileItem {
  String name;
  String filePath;
  bool isPinned;

  FileItem(this.name, this.filePath, this.isPinned);
}

// FUNÇÃO PARA ABRIR ARQUIVOS
Future<void> _openFile(context, String nameFile, String filePath) async {
  String downloadDir = await AndroidPathProvider.downloadsPath;
  String localPath = '$downloadDir/$nameFile';
  File localFile = File(localPath);

  try {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permissão de armazenamento negada')),
        );
        return;
      }
    }

    if (await localFile.exists()) {
      var result = await OpenFile.open(localPath);
      if (result.type != ResultType.done) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Falha ao abrir o arquivo: ${result.message}')),
        );
      }
      return;
    }

    await _downloadFile(context, nameFile, filePath);
  } catch (e) {
    print(e);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Permissão negada: $e')));
  }
}

// FUNÇÃO PARA DOWNLOAD DE ARQUIVOS
Future<void> _downloadFile(context, String nameFile, String filePath) async {
  ValueNotifier<double> progressNotifier = ValueNotifier(0);

  try {
    var status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      status = await Permission.manageExternalStorage.request();
      if (!status.isGranted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Permissão de armazenamento negada')),
        );
        return;
      }
    }

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(filePath);
    String downloadDir = await AndroidPathProvider.downloadsPath;
    String localPath = '$downloadDir/$nameFile';

    Dio dio = Dio();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(
          'Baixando $nameFile',
          style: const TextStyle(color: Colors.black),
        ),
        content: ValueListenableBuilder<double>(
          valueListenable: progressNotifier,
          builder: (context, progress, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LinearProgressIndicator(value: progress),
                const SizedBox(height: 20),
                Text('${(progress * 100).toStringAsFixed(0)}%'),
              ],
            );
          },
        ),
      ),
    );

    await dio.download(
      await ref.getDownloadURL(),
      localPath,
      onReceiveProgress: (received, total) {
        if (total != -1) {
          progressNotifier.value = received / total;
        }
      },
    );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Download completo: $localPath')),
    );

    OpenFile.open(localPath);
  } catch (e) {
    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Falha no download: $e')),
    );
  }
}
