import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restapi/model.dart';

class Repository {
  final _baseUrl = 'https://63399c1166857f698fb8e025.mockapi.io/restapiflutter';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/users'));

      if (response.statusCode == 200) {
        Iterable it = jsonDecode(response.body);
        List<User> user = it.map((e) => User.fromJson(e)).toList();
        return user;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String name, String alamat) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + '/users'),
          body: {"name": name, "alamat": alamat});
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String name, String alamat) async {
    try {
      final response = await http.put(
          Uri.parse(_baseUrl + '/users/' + id.toString()),
          body: {'name': name, 'alamat': alamat});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl + '/users/' + id));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
