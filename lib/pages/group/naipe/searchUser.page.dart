import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/rowMember.dart';

var allRows = [
  RowMember('images/UsersExemplos/Fernando-Alonso.jpg', 'Fernando Alonso',
      false, true),
  RowMember(
      'images/UsersExemplos/Lando-Norris.jpg', 'Lando Norris', false, true),
];

class SearchUser extends StatefulWidget {
  const SearchUser({super.key});

  @override
  _SearchUserState createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  List<RowMember> rows = allRows;
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
