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
        onPressed: () => Navigator.pushNamed(context, '/addnaipe'),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.all(15),
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("images/HomeBackground.png"),
          fit: BoxFit.fill,
        )),
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
