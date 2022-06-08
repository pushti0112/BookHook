import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/user_model.dart';
import 'package:http/http.dart' as http;

import '../provider/user_provider.dart';

class DataService {
  late Data dataModel;

  Future<List<Data>> getData() async {
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print(basicAuth);

    print("in get");
    http.Response response = await http.post(
        Uri.parse(
            "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_GET_USERS"),
        headers: <String, String>{'authorization': basicAuth});

    List<Data> users = [];
    print("response");
    print(response.body);

    List<dynamic> jsonData = json.decode(response.body);

    print(jsonData[0]);
    if (jsonData != null) {
      jsonData.forEach((element) {
        if (element != null) {
          users.add(new Data.fromJson(element));
        } else {
          print("Element is NULL");
        }
      });
    }

    print(users);
    return users;
  }

  addData(BuildContext context, Data user) async {
    String username = 'Uwindsor';
    String password = 'MAC@2022';
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    UserProvider userProvider = Provider.of(context, listen: false);

    //dataModel.data.add(Data(firstName: firstName,lastName: lastName,email: email,id: id,avatar: avatar));
    //print(dataModel.data.length);

    print(user.NAME);
    print(user.ID);

    // int id = int.parse(user.ID);
    http.Response response = await http.post(
        Uri.parse(
            "http://bookshelfdev-001-site1.ctempurl.com/api/BookShelf/USP_CRUD_USER"),
        headers: <String, String>{
          "Accept": "application/json",
          "content-type": "application/json",
          "authorization": basicAuth
        },
        body: jsonEncode(
          <String, dynamic>{
            "ID": user.ID,
            "Name": user.NAME,
            "Password": user.PASSWORD,
          },
        ));
    if (response.body.isNotEmpty) {
      print("Value = " + response.body);
    } else {
      print("Empty = ");
    }

    if (user != null) {
      print(userProvider.users!.length);
      userProvider.users?.add(user);
      userProvider.notifyListeners();
    } else
      print("Error in Api");

    // response = await http.post(Uri.parse("https://reqres.in/api/users?page=2"),body: json.encode(dataModel.toJson()));
  }

  // deleteData(BuildContext context, Data user) async {
  //   UserProvider userProvider = Provider.of(context, listen: false);
  //   //dataModel.data.add(Data(firstName: firstName,lastName: lastName,email: email,id: id,avatar: avatar));
  //   //print(dataModel.data.length);

  //   userProvider.users.remove(user);
  //   userProvider.notifyListeners();

  //   http.Response response = await http.delete(
  //     Uri.parse("https://reqres.in/api/users/${user.id}"),
  //   );
  //   print(response.body);

  //   if (response.statusCode != 204) {
  //     if (user != null) {}
  //   } else {
  //     print("Error in Api");
  //     userProvider.users.add(user);
  //     userProvider.notifyListeners();
  //   }

  //   // response = await http.post(Uri.parse("https://reqres.in/api/users?page=2"),body: json.encode(dataModel.toJson()));
  // }
}
