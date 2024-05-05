import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/rowMember.dart';

class SearchUser extends StatelessWidget {
  const SearchUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Membros de Violino")),
      body: Container(
        padding: EdgeInsetsDirectional.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                const Color(0xFF233C95),
                const Color(0xFF1B013D),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: Column(
          children: [
            RowMember('images/UsersExemplos/Fernando-Alonso.jpg',
                'Fernando Alonso', true, true),
          ],
        ),
      ),
    );
  }
}
