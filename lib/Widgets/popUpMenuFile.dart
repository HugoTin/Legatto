import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class PopUpMenuFile extends StatelessWidget {
  final bool isAdmin;
  final String filePath;
  final VoidCallback
      refreshCallback; // Callback para atualizar a lista de arquivos

  const PopUpMenuFile(this.isAdmin, this.filePath, this.refreshCallback,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<int>(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      itemBuilder: (context) => [
        const PopupMenuItem(
          textStyle: TextStyle(color: Colors.black),
          value: 1,
          child: Text("Favoritar"),
        ),
        if (isAdmin)
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 2,
            child: Text("Renomear"),
          ),
        if (isAdmin)
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 3,
            child: Text("Arquivar"),
          ),
        if (isAdmin)
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 4,
            child: Text("Fixar"),
          ),
        if (isAdmin)
          const PopupMenuItem(
            textStyle: TextStyle(color: Colors.black),
            value: 5,
            child: Text("Excluir"),
          ),
      ],
      onSelected: (value) {
        switch (value) {
          case 1:
            null;
            break;
          case 2:
            if (isAdmin) null;
            break;
          case 3:
            if (isAdmin) null;
            break;
          case 4:
            if (isAdmin) null;
            break;
          case 5:
            if (isAdmin) {
              _deleteFile(context, filePath);
            }
            break;
        }
      },
    );
  }

  Future<void> _deleteFile(BuildContext context, String filePath) async {
    try {
      await FirebaseStorage.instance.ref(filePath).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Arquivo excluído com sucesso')),
      );
      refreshCallback();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falha ao excluir o arquivo: $e')),
      );
    }
  }
}
