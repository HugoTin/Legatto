import 'package:flutter/material.dart';
import 'package:legatto/widgets/popUpMenuNaipe.dart';

class RowNaipe extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final int participants;
  final bool isAdmin;

  const RowNaipe(this.id, this.image, this.name, this.participants, this.isAdmin, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            child: Image.asset(
              image,
              height: 50,
              width: 40,
            )
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(width: 10),
          Text(
            "(${participants.toString()})",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const Spacer(
            flex: 100,
          ),
          PopUpMenuNaipe(id, isAdmin, name),
        ],
      ),
    );
  }
}
