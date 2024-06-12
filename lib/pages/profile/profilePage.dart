import 'package:flutter/material.dart';

class Profilepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(36.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  "https://qph.cf2.quoracdn.net/main-qimg-7ff109f9b744a4ba97b6648fcfb0b6b5-lq"),
            ),
            const SizedBox(height: 12),
            const Text(
              "Willian",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const Text(
              "republicachinesa@comunismo.com.br",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.white),
              title: const Text(
                'Mudar senha',
                style: TextStyle(
                  fontSize: 16, // Updated font size to 16
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action for change password
              },
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip, color: Colors.white),
              title: const Text(
                'Políticas de privacidade',
                style: TextStyle(
                  fontSize: 16, // Updated font size to 16
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action for privacy policy
              },
            ),
            ListTile(
              leading: const Icon(Icons.description, color: Colors.white),
              title: const Text(
                'Termos de uso',
                style: TextStyle(
                  fontSize: 16, // Updated font size to 16
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action for terms of use
              },
            ),
            ListTile(
              leading: const Icon(Icons.error, color: Colors.white),
              title: const Text(
                'Reportar erros',
                style: TextStyle(
                  fontSize: 16, // Updated font size to 16
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action for reporting errors
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.white),
              title: const Text(
                'Sair',
                style: TextStyle(
                  fontSize: 16, // Updated font size to 16
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // Action for logout
              },
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0xFF0C0C24),
    );
  }
}
