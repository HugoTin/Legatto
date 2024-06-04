import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/rowAddNaipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import 'package:legatto/enum/naipes.dart';

var rows = Naipes.values;
var baseRows = rows;

class AddNaipe extends StatefulWidget {
  String id;

  AddNaipe(this.id, {super.key});

  @override
  _AddNaipeState createState() => _AddNaipeState(id);
}

class _AddNaipeState extends State<AddNaipe> {
  String id;

  _AddNaipeState(this.id) {

    asyncInit();

  }

  asyncInit() async {

    final firestore = FirebaseFirestore.instance;

    var fire = await firestore.collection('group').doc(id).get();

    Map<String, dynamic>? data = fire.data();

    Map<String, dynamic> naipes = data?['naipes'];

    print('firefodase3 $naipes');
    
    print('firefodase3 $rows');
    List<String> naipesNome = rows.map((row) => row.name.toString().replaceAll('{', '').replaceAll('}', '')).toList();
    // String clarinete = mapa.last;
    // print('firefodase3 ${naipes[clarinete]} $clarinete');

    // rows = naipesNome
    // .where((naipe) => naipes[naipe.name]['ativo'] == true).toList();

  }

  final controller = TextEditingController();

  List<Widget> rowsWidgets = rows
  .map((naipe) => (
    naipe.name != 'Geral' 
    ? RowAddNaipe('images/Naipe${naipe.name}.png', naipe.name, false)
    : const SizedBox()
  )).toList();

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
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsetsDirectional.all(15),
              color: const Color.fromRGBO(12, 12, 36, 1),
              child: ListView.builder(
                itemCount: rowsWidgets.length,
                itemBuilder: (context, index) {
                  final row = rowsWidgets[index];

                  return row;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void searchMember(String query) {
    final suggestions = baseRows.where((row) {
      final rowTitle = row.name.toLowerCase();
      final input = query.toLowerCase();

      return rowTitle.contains(input);
    }).toList();

    setState(() {
      rows = suggestions;
    
      rowsWidgets = rows
      .map((naipe) => (
        naipe.name != 'Geral' 
        ? RowAddNaipe('images/Naipe${naipe.name}.png', naipe.name, false)
        : const SizedBox()
      )).toList();
      
    });
  }
}
