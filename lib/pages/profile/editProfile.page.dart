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
    _profileImageUrl = userData.data()!['profilePic'];
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _updateUserData() async {
    if (_formKey.currentState!.validate()) {
      await firestore.collection('users').doc(user.uid).update({
        'name': _nameController.text,
        if (_imageFile != null) 'profilePic': await _uploadImage(),
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
          : Container(
              color: Color(0xFF0C0C24),
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
                                : const NetworkImage(
                                        'https://firebasestorage.googleapis.com/v0/b/legattofatec.appspot.com/o/profileImages%2Fdefault_profile.png?alt=media&token=18d8aeda-b860-4294-9df7-93e7b50a999b')
                                    as ImageProvider<Object>,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: TextStyle(color: Colors.white),
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.white),
                        // fillColor: Colors.white,
                        // filled: true,
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                      validator: (value) {
                        if (value!.isNotEmpty || value != '') {
                          return null;
                        } else {
                          return 'Insira seu nome';
                        }
                      },
                    ),
                    const SizedBox(height: 30),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 30, 0, 20),
                      width: 200,
                      height: 50,
                      child: OutlinedButton(
                        child: Text(
                          "SALVAR",
                          style: TextStyle(
                              height: 1, fontSize: 20, color: Colors.white),
                        ),
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              width: 3.0,
                              color: Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20))),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }
                          await _updateUserData();
                          GoRouter.of(context).go("/profilepage");
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
