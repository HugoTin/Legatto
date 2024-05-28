import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/rowAddNaipe.dart';

var allRows = [
  RowAddNaipe('images/NaipeTrompete.png', 'Trompete', false),
  RowAddNaipe('images/NaipeClarinete.png', 'Clarinete', false),
  RowAddNaipe('images/NaipeClarinete.png', 'Clarinete', false),
  RowAddNaipe('images/NaipeClarinete.png', 'Clarinete', false),
];

class AddNaipe extends StatefulWidget {
  const AddNaipe({super.key});

  @override
  _AddNaipeState createState() => _AddNaipeState();
}

class _AddNaipeState extends State<AddNaipe> {
  List<RowAddNaipe> rows = allRows;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.all(15),
          child: TextField(
            decoration: InputDecoration(
                hintText: 'Pesquisar...',
                hintStyle: TextStyle(color: Colors.white)),
            cursorColor: Color.fromRGBO(191, 141, 255, 1),
            controller: controller,
            onChanged: searchMember,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsetsDirectional.all(15),
              color: Color.fromRGBO(12, 12, 36, 1),
              child: ListView.builder(
                itemCount: rows.length,
                itemBuilder: (context, index) {
                  final row = rows[index];

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
    final suggestions = allRows.where((row) {
      final rowTitle = row.name.toLowerCase();
      final input = query.toLowerCase();

      return rowTitle.contains(input);
    }).toList();

    setState(() => rows = suggestions);
  }
}
