import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/rowMember.dart';

class UsersNaipe extends StatelessWidget {
  const UsersNaipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Membros de Violino")),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.person_add_alt_rounded,
          color: Colors.black,
        ),
        onPressed: () => Navigator.pushNamed(context, "/searchuser"),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.all(15),
        color: Color.fromRGBO(12, 12, 36, 1),
        child: Column(
          children: [
            RowMember('images/UsersExemplos/Fernando-Alonso.jpg',
                'Fernando Alonso', true, true),
            RowMember('images/UsersExemplos/Lance-Stroll.jpg', 'Lance Stroll',
                true, false),
            RowMember('images/UsersExemplos/Pierre-Gasly.jpg', 'Pierre Gasly',
                false, true),
            RowMember('images/UsersExemplos/Lando-Norris.jpg', 'Lando Norris',
                false, false),
          ],
        ),
      ),
    );
  }
}
