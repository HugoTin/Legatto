import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/rowAddNaipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import 'package:legatto/enum/naipes.dart';

var rows = Naipes.values
.where((row) => row.name != 'Geral')
.map((row) => row.name.toString().replaceAll('{', '').replaceAll('}', ''))
.toList();
var baseRows = rows;

class AddNaipe extends StatefulWidget {
  final String id;

  const AddNaipe(this.id, {super.key});

  @override
  _AddNaipeState createState() => _AddNaipeState(id);
}

class _AddNaipeState extends State<AddNaipe> {
  final String id;

  _AddNaipeState(this.id);

  final firestore = FirebaseFirestore.instance;

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => GoRouter.of(context).go('/managnaipe/$id'),
          icon: const Icon(Icons.arrow_back)
        ),
        title: Container(
          margin: const EdgeInsets.all(15),
          child: TextField(
            decoration: const InputDecoration(
                hintText: 'Pesquisar...',
                hintStyle: TextStyle(color: Colors.white)),
            cursorColor: const Color.fromRGBO(191, 141, 255, 1),
            controller: controller,
            onChanged: searchMember,
          ),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: firestore
        .collection('group')
        .doc(id)
        .snapshots(),
        builder: (context, orderSnapshot){

          var naipes = orderSnapshot.data!.get('naipes');

          // print('docCodeso2 $naipes $rows ${naipes[rows[0]]}');

          List<Widget> rowsWidgets = rows
          .map((naipe) => (
            naipes[naipe]?['ativo'] != true
            ? RowAddNaipe(
              id,
              'images/Naipe$naipe.png',
              naipe,
              firestore
            )
            : const SizedBox()
          )).toList();

          return Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsetsDirectional.all(15),
                  color: const Color.fromRGBO(12, 12, 36, 1),
                  child: ListView(
                    children: rowsWidgets,
                  ),
                ),
              ),
            ],
          );
        }
      )
    );
  }
}

void searchMember(String query) {
  //   final suggestions = baseRows.where((row) {
  //     final rowTitle = row.toLowerCase();
  //     final input = query.toLowerCase();

  //     return rowTitle.contains(input);
  //   }).toList();

  //   setState(() {
  //     rows = suggestions;
    
  //     rowsWidgets = rows
  //     .map((naipe) => (
  //       RowAddNaipe('images/Naipe$naipe.png', naipe, false)
  //     )).toList();
      
  //   });
  // }
}