import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:restapi/add-user.dart';
import 'package:restapi/model.dart';
import 'package:restapi/repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/home': (context) => MyHomePage(),
        '/add-user': (context) => AddUser(),
        '/edit-user': (context) => EditUser(),
      },
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> listUser = [];
  Repository repository = Repository();

  getData() async {
    listUser = await repository.getData();
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter CRUD"),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(AddUser());
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listUser[index].name,
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Text(listUser[index].alamat)
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    bool response =
                        await repository.deleteData(listUser[index].id);
                    if (response) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Data berhasil dihapus")));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Data gagal dihapus")));
                    }
                    getData();
                  },
                  icon: Icon(Icons.delete),
                ),
                IconButton(
                    onPressed: () => {
                          Get.toNamed('/edit-user', arguments: [
                            listUser[index].id,
                            listUser[index].name,
                            listUser[index].alamat,
                          ]),
                        },
                    icon: Icon(Icons.edit)),
              ],
            );
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: listUser.length),
    );
  }
}
