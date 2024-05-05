import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:legatto/Widgets/rowNaipe.dart';

class ManagNaipe extends StatelessWidget {
  const ManagNaipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: SizedBox.fromSize(
                size: Size.fromRadius(20),
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
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
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            RowNaipe('images/NaipeClarinete.png', 'Clarinete', 4, true),
            SizedBox(height: 20),
            RowNaipe('images/NaipeTrompete.png', 'Trompete', 2, false),
            SizedBox(height: 20),
            RowNaipe('images/NaipeViolino.png', 'Violino', 4, true)
          ],
        ),
      ),
    );
  }
}
