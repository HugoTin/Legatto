import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Text('Nenhum usuário logado'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              GoRouter.of(context).go('/home');
            }),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('users').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('Dados não encontrados'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 52,
                  backgroundImage: NetworkImage(userData['profilePic']),
                ),
                const SizedBox(height: 12),
                Text(
                  userData['name'],
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Text(
                  userData['email'],
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 12),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.edit, color: Colors.white),
                  title: const Text(
                    'Editar Perfil',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    GoRouter.of(context).go("/editprofile");
                  },
                ),
              ],
            ),
          );
        },
      ),
      backgroundColor: const Color(0xFF0C0C24),
    );
  }
}
