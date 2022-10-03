import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restapi/main.dart';
import 'package:restapi/repository.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  Repository repository = Repository();
  final _nameController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah User"),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Nama Lengkap',
              ),
            ),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                hintText: 'Alamat',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                bool response = await repository.postData(
                    _nameController.text, _alamatController.text);
                if (response) {
                  Get.offAll(MyHomePage());
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Data berhasil ditambahkan")));
                } else {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("Gagal")));
                }
              },
              child: Text("Simpan"),
            ),
          ],
        ),
      ),
    );
  }
}

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  Repository repository = Repository();
  final _nameController = TextEditingController();
  final _alamatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;
    if (args[1].isNotEmpty) {
      _nameController.text = args[1];
    }
    if (args[2].isNotEmpty) {
      _alamatController.text = args[2];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
      ),
      body: Container(
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Nama Lengkap',
              ),
            ),
            TextField(
              controller: _alamatController,
              decoration: InputDecoration(
                hintText: 'Alamat',
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  bool response = await repository.putData(int.parse(args[0]),
                      _nameController.text, _alamatController.text);
                  if (response) {
                    Get.offAll(MyHomePage());
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Data berhasil diedit")));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Gagal")));
                  }
                },
                child: Text("Simpan Perubahan")),
          ],
        ),
      ),
    );
  }
}
