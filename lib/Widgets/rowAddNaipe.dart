import 'package:flutter/material.dart';
import 'package:legatto/widgets/popUpMenuNaipe.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RowAddNaipe extends StatelessWidget {
  final String id;
  final String image;
  final String name;
  final FirebaseFirestore firestore;

  const RowAddNaipe(this.id, this.image, this.name, this.firestore, {super.key});

  void _addNaipe(BuildContext context){

    firestore
    .collection('group')
    .doc(id)
    .update({ 'naipes.$name.ativo' : true });

    GoRouter.of(context).pop();

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListTile(
        textColor: Colors.white,
        iconColor: Colors.white,
        leading: Image.asset(image),
        title: Text(
          name,
          style: const TextStyle(fontSize: 18),
        ),
        trailing: IconButton(
          onPressed: () => _addNaipe(context),
          icon: const Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }
}
