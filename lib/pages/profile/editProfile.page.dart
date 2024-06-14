import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  File? _imageFile;
  String? _profileImageUrl;
  bool _isLoading = true;

  final user = FirebaseAuth.instance.currentUser!;
  final firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    DocumentSnapshot<Map<String, dynamic>> userData =
        await firestore.collection('users').doc(user.uid).get();
    _nameController.text = userData.data()!['name'];
    _emailController.text = userData.data()!['email'];
    _profileImageUrl = userData.data()!['profilePictureUrl'];
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      await firestore.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        'email': _emailController.text,
        if (_imageFile != null) 'profilePictureUrl': await _uploadImage(),
      });
    }
  }

  Future<String> _uploadImage() async {
    final storageRef = FirebaseStorage.instance.ref();
    final profileImagesRef = storageRef.child('profileImages/${user.uid}');
    final uploadTask = profileImagesRef.putFile(_imageFile!);
    final snapshot = await uploadTask.whenComplete(() => null);
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).go("/profilepage");
          },
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 48,
                        backgroundImage: _imageFile != null
                            ? FileImage(_imageFile!) as ImageProvider<Object>
                            : _profileImageUrl != null
                                ? NetworkImage(_profileImageUrl!)
                                    as ImageProvider<Object>
                                : const AssetImage('images/default_profile.png')
                                    as ImageProvider<Object>,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu nome';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, insira seu email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () async {
                        await _updateUserData();
                        GoRouter.of(context).go("/profilepage");
                      },
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
